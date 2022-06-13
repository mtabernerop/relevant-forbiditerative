#!/bin/bash

# $1 domain
# $2 problem
# $3 number of plans
# $4 time limit <optional>
# $5 reordering {NONE, NEIGHBOURS_INTERFERE, NAIVE_ALL_DFS_NODUP (default)} <optional>
# $6 symmetries {false, true (default)} <optional>


if [ "$#" -lt 3 ] || [ "$#" -gt 6 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

OVERALL_TL="--overall-time-limit 100000000h"
if [ "$#" -ge 4 ]; then
    OVERALL_TL="--overall-time-limit $4"
fi

REORDERING="--reordering NAIVE_ALL_DFS_NODUP"
if [ "$#" -ge 5 ]; then
    REORDERING="--reordering $5"
fi

SYMMETRIES="--symmetries" # default value: true
if [ "$#" -ge 6 ]; then
    case "$6" in
        True|true|TRUE) SYMMETRIES="--symmetries";;
        False|false|FALSE) SYMMETRIES="";;
        *)
            echo "Illegal symmetries parameter"
            exit 1 ;;
    esac
fi

SOURCE="$( dirname "${BASH_SOURCE[0]}" )"
$SOURCE/plan.py --planner topk --domain $1 --problem $2 --number-of-plans $3 $OVERALL_TL $REORDERING $SYMMETRIES --use-local-folder --clean-local-folder #--keep-intermediate-tasks #  #--plans-as-json 


