#!/bin/bash

# $1 domain
# $2 problem
# $3 number of plans (k)
# $4 (optional, default NONE) reordering (NONE, NEIGHBOURS_INTERFERE, NAIVE_ALL_DFS_NODUP)

if [ "$#" -lt 3 ] || [ "$#" -gt 5 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

OVERALL_TL=""
if [ "$#" -eq 4 ]; then
    OVERALL_TL="--overall-time-limit $4"
fi

REORDERING=""
if [ "$#" -eq 5 ]; then
    OVERALL_TL="--overall-time-limit $4"
    REORDERING="--reordering $5"
fi

SOURCE="$( dirname "${BASH_SOURCE[0]}" )"
$SOURCE/plan.py --planner topk --domain $1 --problem $2 --number-of-plans $3 $OVERALL_TL $REORDERING --symmetries --use-local-folder --clean-local-folder #--keep-intermediate-tasks #  #--plans-as-json 

