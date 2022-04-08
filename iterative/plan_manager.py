# -*- coding: utf-8 -*-
# Plan manager keeps the plans found so far and performs all plan manipulations
from __future__ import print_function
from genericpath import isdir

import shutil
import itertools
import os, sys
import subprocess
import re
import logging
from sysconfig import get_path_names
from numpy import empty
import copy_plans
import json
from driver import limits
from planner_call import BaseCostOptimalPlannerCall, BaseSatisficingPlannerCall, HmaxPlannerCall, TopkReformulationPlannerCall, make_call, get_base_dir
from pddl_parser.PDDL import PDDL_Parser, parse

_PLAN_INFO_REGEX = re.compile(r"; cost = (\d+) \((unit cost|general cost)\)([\n]{0,1})")


def _read_last_line(filename):
    line = None
    with open(filename) as input_file:
        for line in input_file:
            pass
    return line


def _parse_plan(plan_filename):
    """Parse a plan file and return a pair (cost, problem_type)
    summarizing the salient information. Return (None, None) for
    incomplete plans."""

    last_line = _read_last_line(plan_filename) or ""
    match = _PLAN_INFO_REGEX.match(last_line)
    if match:
        return int(match.group(1)), match.group(2)
    else:
        return None, None


class PlanManager(object):
    def __init__(self, args, plan_prefix, local_folder, compute_best_known):
        self._plan_prefix = plan_prefix
        self._plan_costs = []
        self._problem_type = None
        self._local_folder = local_folder
        self._best_known_bound = None
        self._compute_best_known = compute_best_known
        # plans' management folders
        parser = PDDL_Parser()
        prob_dir, prob_filename = os.path.split(args.problem)
        prob_filename, prob_ext = os.path.splitext(prob_filename)
        self._final_plans_folder = get_base_dir() + '/results/' + args.domain.split("/")[-2] + "-" + prob_filename + "-" + str(args.number_of_plans)
        self._rplans_folder = self._final_plans_folder + '/forced_relevant_plans'
        self._iplans_folder = self._final_plans_folder + '/filtered_plans'
        self._unfiltered_plans_folder = self._final_plans_folder + '/unfiltered_plans'

    def get_plan_prefix(self):
        return self._plan_prefix


    def get_number_valid_plans(self, up_to_best_known_bound):
        if up_to_best_known_bound and not self._compute_best_known:
            raise RuntimeError("Cannot use up_to_best_known_bound if the best known bound is not computed.")

        return self.get_plan_counter_upto_best_known_bound() if up_to_best_known_bound else self.get_plan_counter()

    def get_number_invalid_plans(self):
        return len([name for name in os.listdir(self._iplans_folder) if not os.path.isdir(os.path.join(self._iplans_folder, name))])

    def get_number_unfiltered_plans(self):
        return len([name for name in os.listdir(self._unfiltered_plans_folder) if not os.path.isdir(os.path.join(self._unfiltered_plans_folder, name))])

    def get_plan_counter(self):
        return len(self._plan_costs)

    def get_plan_counter_upto_best_known_bound(self):
        if not self._compute_best_known:
            raise RuntimeError("Cannot call get_plan_counter_upto_best_known_bound if the best known bound is not computed.")
        plan_costs_upto_best_known_bound = [x for x in self._plan_costs if x <= self._best_known_bound]
        return len(plan_costs_upto_best_known_bound)

    def get_best_plan_cost(self):
        """Return best plan cost found so far. Return string
        "infinity" if no plans found yet.
        No assumption that the last plan is the best"""
        if self._plan_costs:
            return min(self._plan_costs)
        else:
            return "infinity"

    def get_highest_plan_cost(self):
        """Return the highest plan cost found so far. Return string
        "infinity" if no plans found yet.
        No assumption on plan orders"""
        if self._plan_costs:
            return max(self._plan_costs)
        else:
            return "infinity"

    def get_problem_type(self):
        if self._problem_type is None:
            raise ValueError("no plans found yet: cost type not set")
        return self._problem_type

    def get_last_processed_plan(self):
        counter = self.get_plan_counter()
        if counter == 0:
            return None
        return self._get_local_plan_file(counter)

    def forget_last_processed_plan(self):
        del self._plan_costs[-1]

    """
    Parse filename of domain or problem file in follow-plan approach
    """
    def parse_follow_plan_filename(self, name):
        directory, filename = os.path.split(name)
        filename, extension = os.path.splitext(filename)
        file = f'{directory}/{filename}-follow-plan.pddl'
        return file

    def process_new_plans(self, args, planner, _timers):
        """Update information about plans after a planner run.

        Read newly generated plans and store the relevant information.
        If the last plan file is incomplete, delete it.
        The best known bound is set to the cost of the cheapest out of the new plans.
        """
        def bogus_plan(msg):
            logging.info("%s: %s" % (plan_filename, msg))
            #raise RuntimeError("%s: %s" % (plan_filename, msg))

        num_plans_so_far = self.get_plan_counter()
        had_incomplete_plan = False
        new_plans_min_cost = None 
        for counter in itertools.count(num_plans_so_far + 1):
            if self.get_number_valid_plans(True) >= args.number_of_plans:
                logging.debug(f"Enough plans found ({self.get_number_valid_plans(True)})")
                break
            plan_filename = self._get_local_plan_file(counter)
            if not os.path.exists(plan_filename):
                break
            if had_incomplete_plan:
                bogus_plan("plan found after incomplete plan")
                break
            cost, problem_type = _parse_plan(plan_filename)
            if cost is None:
                had_incomplete_plan = True
                logging.info("%s is incomplete. Deleted the file." % plan_filename)
                os.remove(plan_filename)
            else:
                logging.debug("plan manager: found new plan with cost %d (%s)" % (cost, plan_filename))
                if self._problem_type is None:
                    # This is the first plan we found.
                    self._problem_type = problem_type
                else:
                    # Check if info from this plan matches previous info.
                    if self._problem_type != problem_type:
                        bogus_plan("problem type has changed")
                    ## The assumption that the last plan is the cheapest is not valid here 
                    #if cost >= self._plan_costs[-1]:
                    #    bogus_plan("plan quality has not improved")                
                self._plan_costs.append(cost)
                if self._compute_best_known:
                    ## Updating the best known cost bound (for top-k planner only, at this point)
                    if new_plans_min_cost is None:
                        new_plans_min_cost = cost
                    else:
                        new_plans_min_cost = min(new_plans_min_cost, cost)
                    if self._best_known_bound is None:
                        self._best_known_bound = cost
        if self._compute_best_known and new_plans_min_cost is None:
            return 0
        ## The bound can only improve
        if self._compute_best_known and self._best_known_bound > new_plans_min_cost:
            logging.info("Best known bound is %s, while new plans minimal cost is %s" % (self._best_known_bound, new_plans_min_cost) )
            bogus_plan("new plan found is cheaper than the known bound")
        if self._compute_best_known:
            self._best_known_bound = new_plans_min_cost
        return self.get_plan_counter() - num_plans_so_far

    def get_local_plans(self):
        """Yield all plans that match the given plan prefix."""
        for counter in itertools.count(start=1):
            if counter > len(self._plan_costs):
                break
            plan_filename = self._get_local_plan_file(counter)
            if os.path.exists(plan_filename):
                yield plan_filename
            else:
                break

    def get_local_plans_upto_bound(self, bound):
        """Yield all plans that match the given plan prefix and are under the cost bound."""
        for counter in itertools.count(start=1):
            if counter > len(self._plan_costs):
                break
            if bound < self._plan_costs[counter-1]:
                continue
            plan_filename = self._get_local_plan_file(counter)
            if os.path.exists(plan_filename):
                yield plan_filename
            else:
                break

    def get_local_plans_for_cost(self, cost):
        """Yield all plans that match the given plan prefix and are under the cost bound."""
        for counter in itertools.count(start=1):
            if counter > len(self._plan_costs):
                break
            if cost == self._plan_costs[counter-1]:
                plan_filename = self._get_local_plan_file(counter)
                if os.path.exists(plan_filename):
                    yield plan_filename
                else:
                    break

    def get_best_local_plans(self):
        """Yield all plans that match the given plan prefix and are under the cost bound."""
        return self.get_local_plans_upto_bound(self._best_known_bound)

    def delete_existing_plans(self):
        """Delete all plans that match the given plan prefix."""
        logging.info("Deleting existing plans")
        for plan in self.get_local_plans():
            logging.info("Deleting plan file: %s" % plan)
            os.remove(plan)

    def delete_additional_plans(self):
        """Delete relevant, irrelevant and unfiltered plans from previous executions"""
        logging.info("Deleting existing additional plans")
        if os.path.exists(self._rplans_folder):
            for f in os.listdir(self._rplans_folder):
                os.remove(os.path.join(self._rplans_folder, f))
        if os.path.exists(self._iplans_folder):
            for f in os.listdir(self._iplans_folder):
                os.remove(os.path.join(self._iplans_folder, f))
        if os.path.exists(self._unfiltered_plans_folder):
            for f in os.listdir(self._unfiltered_plans_folder):
                os.remove(os.path.join(self._unfiltered_plans_folder, f))
        if os.path.exists(self._final_plans_folder):
            for f in os.listdir(self._final_plans_folder):
                file = os.path.join(self._final_plans_folder, f)
                if not os.path.isdir(file):
                    os.remove(file)

    def create_plan_folders(self):
        if not os.path.isdir(get_base_dir() + '/results/'):
            os.mkdir(get_base_dir() + '/results/')
 
        folders = [self._final_plans_folder, self._rplans_folder, self._iplans_folder, self._unfiltered_plans_folder]
        for folder in folders:
            if os.path.exists(folder):
                shutil.rmtree(folder)
            os.mkdir(folder) 

    def create_task_details(self, args):
        """
        line 0: domain_filename
        line 1: problem_filename
        line 2: number_of_plans (k)
        """
        task_details_filename = os.path.join(self.get_plans_folder(), 'task_details.txt')
        # create task details file
        with open(task_details_filename, "a") as t:
            t.write(os.getcwd() + "\n")
            t.write(args.domain + "\n")
            t.write(args.problem + "\n")
            t.write(str(args.number_of_plans) + "\n")
    
    def get_task_details_filename(self):
        return os.path.join(self.get_plans_folder(), 'task_details.txt')

    def _get_local_plan_file(self, number):
        return self._get_plan_file(number, subfolder=None)

    def _get_done_plan_file(self, number):
        return self._get_plan_file(number, "done")

    def _get_tmp_plan_file(self, number):
        return self._get_plan_file(number, "tmp")

    def _get_plan_file(self, number, subfolder=None):
        name = "%s.%d" % (self._plan_prefix, number)
        if subfolder:
            return os.path.join(self._local_folder, subfolder, name)
        else:
            return os.path.join(self._local_folder, name)

    def report_number_of_plans(self, best_plans):
        if best_plans:
            num_best_plans = self.get_plan_counter_upto_best_known_bound()
            num_plans_total = self.get_plan_counter()

            logging.info("Number of best plans: %s, total plans: %s" % (num_best_plans, num_plans_total))
        else:
            num_plans_total = self.get_plan_counter()

            logging.info("Number of plans: %s" % num_plans_total)

    def report_number_of_valid_plans(self):
        num_total_valid_plans = self.get_number_valid_plans(True)
        logging.info("Number of valid plans: %s" % num_total_valid_plans)

    def map_plans_back(self):
        def map_back_plan(name):
            lines = []
            with open(name, 'r') as f:
                content = f.readlines()
                for line in content:            
                    stripped_line = line.strip()
                    if not stripped_line:
                        continue
                    if stripped_line.startswith("(") and stripped_line.endswith(")"):
                        ## Removing the added part
                        a = stripped_line[:-1].split("__###__")[0]
                        lines.append(a + ")\n")
                        continue
                    lines.append(line)

            with open(name, 'w') as f:
                f.writelines(lines)
        for counter in itertools.count(start=1):
            plan_filename = self._get_local_plan_file(counter)
            if os.path.exists(plan_filename):
                map_back_plan(plan_filename)
            else:
                break

    def plans_to_json(self, filename):
        def read_plan_actions(name):
            lines = []
            with open(name, 'r') as f:
                content = f.readlines()
                for line in content:
                    stripped_line = line.strip()
                    if not stripped_line:
                        continue
                    if stripped_line.startswith("(") and stripped_line.endswith(")"):
                        ## Removing the added part
                        a = stripped_line[1:-1].split("__###__")[0]
                        lines.append(a)
                last_line = content[-1]
                match = _PLAN_INFO_REGEX.match(last_line)
                cost = None
                if match:
                    cost = int(match.group(1))
            return lines, cost
        plans = []
        for counter in itertools.count(start=1):
            plan_filename = self._get_local_plan_file(counter)
            if os.path.exists(plan_filename):
                actions, cost = read_plan_actions(plan_filename)
                plans.append( { "cost" : cost, "actions" : actions } )
            else:
                break

        with open(filename, 'w') as f:
            json.dump({ "plans" : plans }, f, indent=4)


    def copy_found_plans_back(self):
        copy_plans.copy_found_plans_back(self._local_folder)

    def delete_found_plans(self):
        copy_plans.delete_found_plans(self._local_folder)

    def os_clean_all(self):
        copy_plans.os_clean_all(self._local_folder)

    def get_plans_folder(self):
        return self._local_folder

    def forbid_plan(self, plan_file, task_manager):
        if not os.path.exists(plan_file):
            logging.info("File %s is not found" % plan_file)
            exit(1)
        
        num_previous_plans = self.get_plan_counter() 
        num_remaining_plans = 3
        curr_task_name = task_manager.get_current_task_path()
        external_plan_file = plan_file

        command = f"./fast-downward.py '{curr_task_name}' \
                                        --internal-previous-portfolio-plans {num_previous_plans} \
                                        --search 'forbid_iterative( reformulate = FORBID_MULTIPLE_PLANS, \
                                                                    reduce_plan_orders=NAIVE_ALL_DFS_NODUP, dump=false, \
                                                                    number_of_plans={num_remaining_plans}, \
                                                                    change_operator_names=true, \
                                                                    external_plan_file='{external_plan_file}')'"

        os.system(command)

        logging.info(f"Forbidding {plan_file}")
        logging.debug("Running " + str(command))

        reformulated_outputs = [name for name in os.listdir(self._local_folder) if name.startswith('reformulated_output')]
        index = "0"
        print(reformulated_outputs)
        if reformulated_outputs:
            for sas in reformulated_outputs:
                sas = sas.split('.')
                if len(sas) == 3:
                    if int(sas[-1]) > int(index):
                        index = sas[-1]
        if os.path.exists(self._local_folder + "/reformulated_output.sas." + index):
            os.remove(self._local_folder + "/reformulated_output.sas." + index)

        if os.path.exists(get_base_dir() + '/reformulated_output.sas'):
            shutil.move(get_base_dir() + '/reformulated_output.sas', self._local_folder + "/reformulated_output.sas." + str(int(index)+1))
        task_manager._task_counter += 1

        os.remove(plan_file)
        
