import pandas as pd
import os

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

if __name__ == "__main__":
    # Reading results
    results = pd.read_csv("/home/miguel/Escritorio/test_condor/action-filtering-iterative.csv")
    results = complete_missing_exps(results)
    results.to_csv(os.path.join(os.getcwd(), "action-filtering-iterative.csv"), index=False, header=True)