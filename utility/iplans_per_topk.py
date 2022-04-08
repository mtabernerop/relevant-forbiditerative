from asyncio import tasks
import os
from numpy import NAN
import pandas as pd

PLANS_PATH = "/home/miguel/Escritorio/University/TFG/WS-ICAPS22-FinPlan/results/"
FILTERED_PLANS_PATH = "filtered_plans"

domains = ["blocks", "campus", "depots", "driverlog", "dwr", "ferry", "grid", "intrusiondetection", "kitchen", "logistics", "miconic", "rover", "satellite", "sokoban", "zenotravel"]
problems = list(range(0,20))
ks = [1,5,10,50,100,500,1000]
_ks = [1000,500,100,50,10,5,1]

irrelevant_plans_dict = dict()

for domain in domains:
    for problem in problems:
        for k in ks:
            task = f"{domain}-p{problem}-{k}"
            if os.path.exists(os.path.join(PLANS_PATH, domain, task)):
                num_irrelevant_plans = 0
                if os.path.exists(os.path.join(PLANS_PATH, domain, task, FILTERED_PLANS_PATH)):
                    for irrelevant_plan in os.listdir(os.path.join(PLANS_PATH, domain, task, FILTERED_PLANS_PATH)):
                        index = irrelevant_plan.split(".")[-1]
                        if int(index) <= int(k):
                            num_irrelevant_plans += 1
                irrelevant_plans_dict[task] = num_irrelevant_plans
            else:
                for _k in _ks:
                    _task = f"{domain}-p{problem}-{_k}"
                    if os.path.exists(os.path.join(PLANS_PATH, domain, _task)):
                        irrelevant_plans_dict[task] = k - _k + irrelevant_plans_dict[_task]
                        break


print(irrelevant_plans_dict)


CSV_PATH = "/home/miguel/Escritorio/test_condor/"
ACTION_FILTERING_CSV = os.path.join(CSV_PATH, "action-filtering-iterative.csv")
BASIC_FORBIDITERATIVE_CSV = os.path.join(CSV_PATH, "basic-forbiditerative.csv")

results = pd.read_csv(BASIC_FORBIDITERATIVE_CSV)

results["irrelevant_plans"] = 0

for index, row in results.iterrows():
    key = f"{row['domain']}-{row['problem'].split('.')[-2]}-{row['k']}"
    if key in irrelevant_plans_dict.keys():
        results.iloc[index, -1] = irrelevant_plans_dict[key]
    else:
        print(row)

print(results.head(10))



