from __future__ import print_function

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

if __name__ == "__main__":
    domain = sys.argv[1]
    problem = sys.argv[2]
    plan_filename = sys.argv[3]
    cost = sys.argv[4]
    number_of_plans = sys.argv[5]

    # Obtaining folder names
    parser = PDDL_Parser()
    prob_dir, prob_filename = os.path.split(problem)
    prob_filename, prob_ext = os.path.splitext(prob_filename)
    _final_plans_folder = get_base_dir() + '/results/' + parser.get_domain_name(domain) + "-" + prob_filename + "-" + str(number_of_plans)
    _rplans_folder = _final_plans_folder + '/forced_relevant_plans'
    _iplans_folder = _final_plans_folder + '/filtered_plans'
    _unfiltered_plans_folder = _final_plans_folder + '/unfiltered_plans'

    # Result file
    result_filename = "is_relevant.txt"
    f = open(result_filename, "w")
         
    # mapping back reformulation additional information
    copy_plans.map_back_fast_downward_plan_file(plan_filename, plan_filename + ".map_back")

    # parsing domain and problem to enforce following relevant actions
    parse(domain, problem, plan_filename + ".map_back")
    follow_plan_domain = parse_follow_plan_filename(domain)   # new generated domain
    follow_plan_problem = parse_follow_plan_filename(problem) # new generated problem

    # Result file
    result_filename = "is_relevant.txt"
    f = open(result_filename, "w")
         
    # mapping back reformulation additional information
    copy_plans.map_back_fast_downward_plan_file(plan_filename, plan_filename + ".map_back")

    # parsing domain and problem to enforce following relevant actions
    parse(domain, problem, plan_filename + ".map_back")
    follow_plan_domain = parse_follow_plan_filename(domain)   # new generated domain
    follow_plan_problem = parse_follow_plan_filename(problem) # new generated problem

    pcargs = {}
    pcargs['domain_file'] = follow_plan_domain
    pcargs['problem_file'] = follow_plan_problem
    pcargs['k'] = number_of_plans
    pcargs["check-relevance"] = "false"
    pcargs['num_previous_plans'] = 0

    """
    -------------
    ALTERNATIVE 1
    -------------
    Manual fast-downward call
    """
    # enable the following options in order to use fast-downward with alias
    # pcargs['plan_file'] = 'sas_plan.1'
    # pcargs['alias'] = 'seq-sat-lama-2011'
    # os.system("./fast-downward.py --plan-file {plan_file} --alias {alias} {domain_file} {problem_file}".format(**pcargs))
    """
    -------------
    ALTERNATIVE 2
    -------------
    BaseCostOptimalPlanner / BaseSatisficingPlanner call
    """
    pc = BaseCostOptimalPlannerCall()
    command = pc.get_callstring(**pcargs)

    local_folder = _rplans_folder
    time_limit = limits.get_time_limit(None, 3000000) #TODO: verificar empíricamente si 5 minutos es suficiente para encontrar 1 plan

    try:
        _time1 = os.times()
        _time1 = _time1[0] + _time1[1] + _time1[2] + _time1[3] # _timers["external_planning"].start()
        make_call(command, time_limit, local_folder)
        _time2 = os.times()
        _time2 = _time2[0] + _time2[1] + _time2[2] + _time2[3] # _timers["external_planning"].stop()
        # print(f"{_time2 - _time1},", end="") # Uncomment if time is required
    except:
        raise
    
    # checking if a plan has been found by the independent planner
    if os.path.exists(f"{_rplans_folder}/sas_plan.1"):
        # sas_plan.1 > ra_plan.X
        ra_plan_filename = f"{_rplans_folder}/ra_plan.{get_plan_counter(_rplans_folder)+1}"
        os.rename(f"{_rplans_folder}/sas_plan.1", ra_plan_filename)
        # obtaining cost and problem type from relevant actions plan
        ra_cost, ra_problem_type = _parse_plan(ra_plan_filename)           

        # checking if the plan is valid (e.g. not incomplete)
        if ra_cost != None:
            # Plan found
            if ra_cost < int(cost):                
                # inform that the found plan is not relevant
                f.write("false")
            else:
                # inform that the found plan is relevant
                f.write("true")
    else:
        # inform that the plan could not be parsed
        f.write("unparsed")
        logging.error("Unsuccessful planning")

        print("#####################")
        os.system(f"cat {follow_plan_domain}")
        print("#####################")
        os.system(f"cat {follow_plan_problem}")
        print("#####################")
        exit(-1)

    os.remove(plan_filename + ".map_back")
    f.close()