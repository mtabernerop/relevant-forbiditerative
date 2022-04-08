#!/usr/bin/env python
from __future__ import print_function

import os, sys
from pddl_parser.PDDL import parse, PDDL_Parser
from iterative.plan_manager import _parse_plan
import copy_plans
import pandas as pd

"""
---------------
CHECK RELEVANCE
---------------
Script that detects if a plan is relevant.
> Syscall: python check_relevance.py <domain> <problem> <plan> <cost> <number_of_plans>
> Output: <true/false>
          
          * True/False: returns whether <plan> is irrelevant (True) or relevant (False)
"""

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
    pcargs['plan_file'] = 'downward/sas_plan.1'
    pcargs['alias'] = 'seq-opt-lmcut'
    os.system("downward/./fast-downward.py --plan-file {plan_file} --alias {alias} {domain_file} {problem_file} >/dev/null 2>&1".format(**pcargs))

    # checking if a plan has been found by the independent planner
    if os.path.exists(f"downward/sas_plan.1"):
        # obtaining cost and problem type from relevant actions plan
        ra_cost, ra_problem_type = _parse_plan("downward/sas_plan.1")           

        # checking if the plan is valid (e.g. not irrelevant)
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
        print("Unsuccessful planning")
        os.remove(plan_filename + ".map_back")
        os.remove(follow_plan_domain)
        os.remove(follow_plan_problem)
        return "Not filtered"


def filter_plans(TASK_PATH):

    relevant_plans = 0
    irrelevant_plans = 0
    unparsed_plans = 0

    for plan in os.listdir(TASK_PATH):
        print("---" + plan)
        task = TASK_PATH.split("/")[-1]
        task = task.split("-")

        domain_name = task[0]
        problem_name = task[1]
        number_of_plans = task[2]

        domain_filename = "forbiditerative/domexps/" + domain_name + "/domain.pddl"
        problem_filename = "forbiditerative/domexps/" + domain_name + "/instances/" + problem_name + ".pddl"
        plan = os.path.join(TASK_PATH, plan)

        res = is_relevant(domain_filename, problem_filename, plan, number_of_plans)

        if res == "True":
            relevant_plans += 1
        elif res == "False":
            irrelevant_plans += 1
        elif res == "Not filtered":
            unparsed_plans += 1
            
    print(relevant_plans, irrelevant_plans, unparsed_plans)

    return irrelevant_plans

if __name__ == "__main__":
    
    irrelevant_plans_dict = dict()

    PLANS_PATH = "experiments/WS-ICAPS22-FinPlan/results/"
    domains = ["blocks", "campus", "depots", "driverlog", "dwr", "ferry", "grid", "intrusiondetection", "kitchen", "logistics", "miconic", "rover", "satellite", "sokoban", "zenotravel"]
    problems = list(range(0,20))
    ks = [1,5,10,50,100,500,1000]

    # current process
    process_number = int(sys.argv[1])

    irrelevant_plans_dict = dict()

    domain = domains[int(sys.argv[1])]
    for problem in problems:
        for k in ks:
            task = f"{domain}-p{problem}-{k}"
            print(task)
            if os.path.exists(os.path.join(PLANS_PATH, domain, task)):
                result = filter_plans(os.path.join(PLANS_PATH, domain, task))
                irrelevant_plans_dict[task] = result

    print(irrelevant_plans_dict)

    df = pd.DataFrame.from_dict(irrelevant_plans_dict, orient='index')

    out_folder = "results-fi-ia/results%s/" % process_number
    os.makedirs(out_folder)
    df.to_csv(os.path.join(out_folder, f"{domain}.csv"), index=True, header=False)