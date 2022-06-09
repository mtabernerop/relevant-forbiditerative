import os, sys
import numpy as np

"""
VERIFY DIFFERENT PLANS

Auxiliary script to verify that plans in argv[1] are different
"""

directory = sys.argv[1]

for file1 in os.listdir(directory):
    for file2 in os.listdir(directory):
        if os.path.isfile(directory + "/" + file1) and os.path.isfile(directory + "/" + file2):
            if file1 != file2:
                with open(directory + '/' + file1, 'r') as f1, open(directory + '/' + file2, 'r') as f2:
                    text1 = f1.readlines();
                    text2 = f2.readlines();
                    if np.array_equal(text1, text2):
                        print(f"{file1} and {file2} are equal")
                        exit(-1)
                        
print("All plans are different")