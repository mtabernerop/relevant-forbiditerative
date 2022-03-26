from __future__ import print_function
from webbrowser import get

import timers
import shutil
import os, sys
import subprocess
import copy_plans
from driver import limits
from planner_call import BaseCostOptimalPlannerCall, BaseSatisficingPlannerCall, make_call, get_base_dir
from pddl_parser.PDDL import parse, PDDL_Parser
from iterative.plan_manager import _parse_plan
import logging

"""
---------------
CHECK RELEVANCE
---------------
Script that detects if a plan is relevant.

> Syscall: python check_relevance.py <domain> <problem> <plan> <cost> <number_of_plans>

> Output: <true/false>
          
          * True/False: returns whether <plan> is irrelevant (True) or relevant (False)
"""

def get_plan_counter(folder):
    return len([name for name in os.listdir(folder) if os.path.isfile(os.path.join(folder, name)) and "ra_plan" in name])

def parse_follow_plan_filename(name):
    directory, filename = os.path.split(name)
    filename, extension = os.path.splitext(filename)
    file = f'{directory}/{filename}-follow-plan.pddl'
    return file

def is_relevant(domain, problem, plan_filename, number_of_plans):
    cost, problem_type = _parse_plan(plan_filename)

    # Obtaining folder names
    prob_dir, prob_filename = os.path.split(problem)
    prob_filename, prob_ext = os.path.splitext(prob_filename)
         
    # mapping back reformulation additional information
    copy_plans.map_back_fast_downward_plan_file(plan_filename, plan_filename + ".map_back")

    # parsing domain and problem to enforce following relevant actions
    parse(domain, problem, plan_filename + ".map_back")
    follow_plan_domain = parse_follow_plan_filename(domain)   # new generated domain
    follow_plan_problem = parse_follow_plan_filename(problem) # new generated problem

    pcargs = {}
    pcargs['domain_file'] = follow_plan_domain
    pcargs['problem_file'] = follow_plan_problem

    """
    -------------
    ALTERNATIVE 1
    -------------
    Manual fast-downward call
    """
    # enable the following options in order to use fast-downward with alias
    pcargs['plan_file'] = '/home/miguel/Escritorio/University/TFG/planners/downward/sas_plan'
    pcargs['alias'] = 'seq-sat-lama-2011'
    os.system("/home/miguel/Escritorio/University/TFG/planners/downward/./fast-downward.py --plan-file {plan_file} --alias {alias} {domain_file} {problem_file}".format(**pcargs))

    # checking if a plan has been found by the independent planner
    if os.path.exists(f"/home/miguel/Escritorio/University/TFG/planners/downward/sas_plan.1"):
        # obtaining cost and problem type from relevant actions plan
        ra_cost, ra_problem_type = _parse_plan("/home/miguel/Escritorio/University/TFG/planners/downward/sas_plan.1")           

        # checking if the plan is valid (e.g. not incomplete)
        if ra_cost != None:
            # Plan found
            if ra_cost < int(cost):                
                # inform that the found plan is not relevant
                os.remove(plan_filename + ".map_back")
                os.remove(follow_plan_domain)
                os.remove(follow_plan_problem)
                return "False"
            else:
                # inform that the found plan is relevant
                os.remove(plan_filename + ".map_back")
                os.remove(follow_plan_domain)
                os.remove(follow_plan_problem)
                return "True"
    else:
        # inform that the plan could not be parsed
        logging.error("Unsuccessful planning")
        os.remove(plan_filename + ".map_back")
        os.remove(follow_plan_domain)
        os.remove(follow_plan_problem)
        return "Not filtered"


if __name__ == "__main__":
    import os

    relevant_plans = 0
    irrelevant_plans = 0
    unparsed_plans = 0

    if sys.argv[1].startswith("/"):
        TASKS_PATH = sys.argv[1]
    else:
        TASKS_PATH = os.path.join(os.getcwd(), sys.argv[1])

    print(TASKS_PATH)

    for plan in os.listdir(TASKS_PATH):
        if not os.path.isdir(os.path.join(TASKS_PATH, plan)):
            task = TASKS_PATH.split("/")[-1]
            task = task.split("-")

            domain_name = task[0]
            problem_name = task[1]
            number_of_plans = task[2]

            domain_filename = "/home/miguel/Escritorio/University/TFG/domains-raquel/" + domain_name + "/domain.pddl"
            problem_filename = "/home/miguel/Escritorio/University/TFG/domains-raquel/" + domain_name + "/instances/" + problem_name + ".pddl"
            plan = os.path.join(TASKS_PATH, plan)

            print("###################################################################")
            print("DOMAIN: " + domain_filename)
            print("PROBLEM: " + problem_filename)
            print("PLAN: " + plan)
            print("###################################################################")

            res = is_relevant(domain_filename, problem_filename, plan, number_of_plans)

            print("RESULT: " + res)
            print("###################################################################")

            if res == "True":
                relevant_plans += 1
            elif res == "False":
                irrelevant_plans += 1
            elif res == "Not filtered":
                unparsed_plans += 1

    print("Relevant plans: " + str(relevant_plans))
    print("Irrelevant plans: " + str(irrelevant_plans))
    print("Unparsed plans: " + str(unparsed_plans))