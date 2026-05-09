#!/usr/bin/env python3
import re
import numpy as np
import matplotlib.pyplot as plt
import csv

input_file = "Period_outclk.csv"
output_file = "Extract_outclk.csv"
#pattern = r"\d+\.\d+e[+-]?\d+"
pattern = r"3.\d+e-09"

matches = []
with open(input_file, "r") as file:
    for line in file:
        matches.extend(re.findall(pattern, line))
        #print(matches)

if matches:
    data = [float(match)*1e9 for match in matches]
else:
    print("data error")
    exit()

with open(output_file, "w") as file:
    file.write("\n".join(map(str, data)))

mean = np.mean(data)
#Period jitter
data = data - mean
#Cycle-to-Cycle jitter
#data = np.diff(data)
variance = np.std(data)
max_abs_val = np.max(np.abs(data))
max_val = np.max(data) - np.min(data)

plt.figure(figsize=(10, 6))
plt.hist(data, bins = 500, edgecolor = 'black', alpha = 0.7)

stats_text = (
    f"Mean = {mean:.3f} (ns)\n"
    f"RMS = {std_dev:.3f} (ns)\n"
    f"P-P = {max_val:.3f} (ns)"
)

plt.text(-0.1, 10, stats_text, fontsize = 10, bbox = dict(facecolor = "white", alpha = 0.8))

plt.title("Histogram of Period Jitter", fontsize = 14)
#plt.title("Histogram of Cycle-to-Cycle Jitter", fontsize = 14)
plt.xlabel("Jitter (ns)", fontsize = 12)
plt.ylabel("Hits", fontsize = 12)
plt.grid(axis = "y", linestyle = "--", alpha = 0.7)
#plt.tight_layout(rect = [0, 0, 0.7, 0.8])
plt.savefig("Firure.png")
plt.show()
