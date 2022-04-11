import pandas as pd
import csv
import os, sys

GENERAL_RESULTS = sys.argv[1]
df = pd.read_csv(GENERAL_RESULTS)

domains = ["blocks", "campus", "depots", "driverlog", "dwr", "ferry", "grid", "intrusiondetection", "kitchen", "logistics", "miconic", "rover", "satellite", "sokoban", "zenotravel"]


for domain in domains:
    TO_APPEND = f"/home/miguel/Escritorio/test_condor/irrelevant_plans/{domain}/{domain}.csv"
    if not os.path.exists(TO_APPEND):
        print("File does not exist")
        continue
    to_append = pd.read_csv(TO_APPEND, header=None)

    with open(TO_APPEND, 'r') as infile:
        reader = csv.reader(infile)
        to_append = {rows[0]:rows[1] for rows in reader}

    # complete dict
    problems = list(range(0,20))
    ks = [1,5,10,50,100,500,1000]
    _ks = [1000,500,100,50,10,5,1]

    for problem in problems:
        for k in ks:
            task = f"{domain}-p{problem}-{k}"
            if not task in to_append.keys():
                for _k in _ks:
                    _task = f"{domain}-p{problem}-{_k}"
                    if _task in to_append.keys():
                        to_append[task] = to_append[_task]
                        break

    if len(to_append) == 140:
        for index, row in df.iterrows():
            if row["domain"] == domain:
                key = row["domain"] + "-" + row["problem"].split(".")[-2] + "-" + str(row["k"])
                df.iloc[index, 6] = int(to_append[key])
                df.iloc[index, 5] = int(df.iloc[index, 4]) - int(to_append[key])
                df.iloc[index, 7] = int(df.iloc[index, 5]) / int(df.iloc[index, 4]) if int(df.iloc[index, 4]) != 0 else 0
                df.iloc[index, 8] = int(df.iloc[index, 6]) / int(df.iloc[index, 4]) if int(df.iloc[index, 4]) != 0 else 0
        
    else:
        print(domain)
        print(len(to_append))
        print("ERROR")


df.to_csv(sys.argv[2], index=False, header=True)