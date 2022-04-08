import re
from matplotlib.pyplot import isinteractive
import pandas as pd


def complete_missing_exps(results):
    domains = ["blocks", "campus", "depots", "driverlog", "dwr", "ferry", "grid", "intrusiondetection", "kitchen", "logistics", "miconic", "rover", "satellite", "sokoban", "zenotravel"]
    problems = list(range(0,20))
    ks = [1000,500,100,50,10,5,1]
    for domain in domains:
        for problem in problems:
            for k in ks:
                row = results.loc[(results["domain"] == domain) & (results["problem"] == f"p{problem}.pddl") & (results["k"] == k)]
                if not row.empty:
                    if int(row["relevant_plans"]) < int(row["k"]):
                        row_copy = row.copy()
                        for add_k in ks:
                            if add_k > int(row["k"]):
                                row_copy["k"] = add_k
                                results = pd.concat([results, row_copy], ignore_index=True)
                                # print(f"{domain}-p{problem}.pddl-{add_k}")

    return results

                

def generate_table():
    # Reading results
    results = pd.read_csv("/home/miguel/Escritorio/test_condor/action-filtering-iterative.csv")
    results = complete_missing_exps(results)
    results["solved"] = False

    # Adding 'Solved' column
    for index, row in results.iterrows():
        if int(row["relevant_plans"]) == int(row["processed_plans"]):
            results.iloc[index,-1] = True

    # ----------
    # Number of instances
    # ----------
    num_instances = results.groupby(["domain"]).nunique()["problem"]

    # ----------
    # Median of relevant plans
    # ----------
    relevant_plans_median = results.groupby(["domain", "k"])["relevant_plans"].median()

    # ----------
    # Mode of relevant plans
    # ----------
    #TODO: multiple modes might exist
    relevant_plans_mode = results.groupby(["domain", "k"])["relevant_plans"].apply(lambda x: x.mode())
    # for index, value in relevant_plans_mode.items(): # Iterate over [<domain, k, num_mode>, mode]
    #     print(index, value)
    
    # ----------
    # Ratio of relevant plans over total processed plans
    # ----------
    relevant_plans = results.groupby(["domain", "k"])["relevant_plans"].sum() / results.groupby(["domain", "k"])["processed_plans"].sum()

    # ----------
    # Solved Top-k planning instances
    # ----------
    solved = results.groupby(["domain", "k"])['solved'].sum() / results.groupby(["domain", "k"])["solved"].count()

generate_table()