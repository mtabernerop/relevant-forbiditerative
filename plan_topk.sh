#!/bin/bash

# Three possible executions:
# 1) ./plan_topk.sh <domain> <instance> <time_bound> --reordering <reordering (default NAIVE_ALL_DFS_NODUP)>
# 2) ./plan_topk.sh <domain> <instance> <time_bound> --symmetries <TRUE/FALSE (default TRUE)>
# 3) ./plan_topk.sh <domain> <instance> <time_bound> --reordering <reordering (default NAIVE_ALL_DFS_NODUP)> --symmetries <true/false (default TRUE)>

if [ "$#" -lt 4 ] || [ "$#" -gt 8 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

OVERALL_TL=""
if [ "$#" -gt 3 ]; then
    OVERALL_TL="--overall-time-limit $4"
fi

REORDERING=""
SYMMETRIES="--symmetries" # default value = true
if [ "$#" -ge 5 ]; then
    case "$5" in
        --reordering) REORDERING="$5 $6";;
        --symmetries)
            case "$6" in
                True|true|TRUE) SYMMETRIES="$5" ;;
                False|false|FALSE) SYMMETRIES="" ;;
                *)
                    echo "Illegal symmetries parameter"
                    exit 1 ;;
            esac ;;
        *)
            echo "Invalid argument: $5"
            exit 1 ;;
    esac
fi

if [ "$#" -ge 7 ]; then
    REORDERING="$5 $6"
    case "$8" in
        True|true|TRUE) SYMMETRIES="$7";;
        False|false|FALSE) SYMMETRIES="";;
        *)
            echo "Illegal symmetries parameter"
            exit 1 ;;
    esac
fi

SOURCE="$( dirname "${BASH_SOURCE[0]}" )"
$SOURCE/plan.py --planner topk --domain $1 --problem $2 --number-of-plans $3 $OVERALL_TL $REORDERING $SYMMETRIES --use-local-folder --clean-local-folder #--keep-intermediate-tasks #  #--plans-as-json 

