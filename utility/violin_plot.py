from math import comb
from posixpath import split
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.ticker import ScalarFormatter, NullLocator, FixedLocator
import seaborn as sns
import matplotlib.patches as mpatches
from matplotlib.patches import Patch
from matplotlib.lines import Line2D
import matplotlib.font_manager as font_manager

def relevant_plans_violin_plot():
    # Reading CSV into pandas dataframe
    results = pd.read_csv('action-filtering-iterative.csv')

    # Extracting relevant plans found per instance
    relevant_plans = results["relevant_plans"]

    # Create a figure instance
    fig = plt.figure()

    # Create an axes instance
    ax = fig.add_axes([0.1,0.07,0.85,0.85])

    # Setting custom y axis labels
    plt.gca().yaxis.set_major_locator(FixedLocator([s for s in range(0, 1000+1, 100)]))
    ax.axes.get_xaxis().set_visible(False)

    # Create the boxplot
    bp = ax.violinplot(relevant_plans)

    color = "tab:red"

    # Make all the violin statistics marks red:
    for partname in ('cmaxes', 'cmins', 'cbars'):
        vp = bp[partname]
        vp.set_edgecolor(color)
        vp.set_linewidth(1)

    # Make the violin body blue with a red border:
    for vp in bp['bodies']:
        vp.set_facecolor(color)
        vp.set_edgecolor(color)
        vp.set_linewidth(1)
        vp.set_alpha(0.5)

    plt.show()

# def split_violin_plots():
#     # Reading CSV into pandas dataframe
#     _action_filtering = pd.read_csv('action-filtering-iterative.csv')
#     _action_filtering = _action_filtering.sort_values(by=["domain", "problem", "k"])

#     _action_filtering = _action_filtering.loc[:, _action_filtering.columns.intersection(['relevant_plans'])]
#     _action_filtering["original"] = False
#     _action_filtering = _action_filtering.rename(columns={"relevant_plans": "plans"})


#     _basic_fi = pd.read_csv('basic-forbiditerative.csv')
#     _basic_fi = _basic_fi.sort_values(by=["domain", "problem", "k"])   

#     _basic_fi = _basic_fi.loc[:, _basic_fi.columns.intersection(['processed_plans'])]
#     _basic_fi["original"] = True
#     _basic_fi = _basic_fi.rename(columns={"processed_plans": "plans"})
    
#     global_results = _basic_fi.append(_action_filtering)
#     global_results["num_plans"] = 1

#     ax = sns.violinplot(y="plans", x="num_plans", data=global_results, split=True, hue="original", inner=None)

#     plt.show()

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


labels = []
def add_label(violin, label):
    color = violin["bodies"][0].get_facecolor().flatten()
    labels.append((mpatches.Patch(color=color), label))


def set_color(plt, color):
    # Make all the violin statistics marks red:
    for partname in ('cmaxes', 'cmins', 'cbars'):
        vp = plt[partname]
        vp.set_edgecolor(color)
        vp.set_linewidth(1)
    # Make the violin body blue with a red border:
    for vp in plt['bodies']:
        vp.set_facecolor(color)
        vp.set_edgecolor(color)
        vp.set_linewidth(1)
        vp.set_alpha(0.5)
    

def combined_violin_plots():
    # Reading CSV into pandas dataframe
    basic_forbiditerative = pd.read_csv('/home/miguel/Escritorio/test_condor/basic-forbiditerative-irrelevant-plans.csv')
    basic_forbiditerative = complete_missing_exps(basic_forbiditerative)

    # Get maximum value of relevant plans
    # index_max = basic_forbiditerative["relevant_plans"].idxmax()
    # print(basic_forbiditerative.iloc[index_max,:7])

    # Medians
    found_plans_median = basic_forbiditerative["processed_plans"].median()
    relevant_plans_median = basic_forbiditerative["relevant_plans"].median()
    print("Found plans median: " + str(found_plans_median))
    print("Relevant plans median: " + str(relevant_plans_median))

    # Extracting relevant plans and found plans found per instance
    relevant_plans = basic_forbiditerative.loc[(basic_forbiditerative["domain"] == "kitchen")]["relevant_plans"].tolist()
    relevant_plans = list(map(int, relevant_plans))

    found_plans = basic_forbiditerative.loc[(basic_forbiditerative["domain"] == "kitchen")]["processed_plans"].tolist()

    # Create a figure instance
    fig, ax = plt.subplots()
    # Create an axes instance
    # ax = fig.add_axes([0.1,0.07,0.85,0.85])

    # Setting custom y axis labels
    # plt.gca().yaxis.set_major_locator(FixedLocator([s for s in range(0, 1000+1, 100)]))
    # ax.axes.get_xaxis().set_visible(False)

    color_bp = "tab:gray"
    color_rp = "tab:red"

    # Creating legend elements
    legend_elements = [Patch(facecolor=color_rp, label='Relevant plans'),
                        Patch(facecolor=color_bp, label='Found plans')]
    ax.legend(handles=legend_elements, loc='center right')

    # Create the boxplot
    bp = ax.violinplot(found_plans)
    bp = set_color(bp, color_bp)

    rp = ax.violinplot(relevant_plans)
    rp = set_color(rp, color_rp)

    plt.xticks(ticks=[])
    plt.show()


def mean_incremental_plot():
    basic_forbiditerative = pd.read_csv('/home/miguel/Escritorio/test_condor/basic-forbiditerative-irrelevant-plans.csv')
    basic_forbiditerative = complete_missing_exps(basic_forbiditerative)
    found_plans = basic_forbiditerative.loc[(basic_forbiditerative["domain"] == "blocks")].groupby("k")["processed_plans"].mean()
    relevant_plans = basic_forbiditerative.loc[(basic_forbiditerative["domain"] == "blocks")].groupby("k")["relevant_plans"].mean()
    # Create a figure instance
    fig, ax = plt.subplots()
    ax.plot(found_plans, label="Found plans", color="tab:blue")
    ax.plot(relevant_plans, label="Relevant plans", color="tab:red")
    plt.legend()
    plt.show()


def bar_plots():
    basic_forbiditerative = pd.read_csv('/home/miguel/Escritorio/test_condor/basic-forbiditerative-irrelevant-plans.csv')
    # basic_forbiditerative = complete_missing_exps(basic_forbiditerative)
    found_plans = basic_forbiditerative.groupby("k")["processed_plans"].mean()
    relevant_plans = basic_forbiditerative.groupby("k")["relevant_plans"].mean()

    # Create a figure instance
    fig, ax = plt.subplots()

    ax.bar(["1","5","10","50","100","500","1000"], found_plans, label="Found plans", color="tab:blue")
    ax.bar(["1","5","10","50","100","500","1000"], relevant_plans, label="Relevant plans", color="tab:red")
    # ax.plot(relevant_plans, label="Relevant plans", color="tab:red")
    plt.legend()
    plt.show()

# mean_incremental_plot()
# bar_plots()
combined_violin_plots()
