# Multi-Group Permutation Test (permKsamp)

## Overview
The `permKsamp` function is designed for conducting permutation tests on numeric data with multiple group assignments. This README provides a brief overview of the algorithm and its usage.

## How it Works
1. **Input Data:**
   - `x`: A numeric vector containing the data to be analyzed.
   - `grupos`: A vector indicating which group each observation in `x` belongs to.

2. **Parameters:**
   - `myfun`: The statistic of interest (default is mean).
   - `nsamp`: Number of permutations to be performed.
   - `alternativa`: Vector specifying the alternative for each group ("bilateral," "unil.inferior," or "unil.superior").
   - `seed`: Seed for result reproducibility.

3. **Algorithm Steps:**
   - Factorize groups to ensure correct identification of levels.
   - Calculate the statistic of interest for the observed data.
   - Generate permutations and calculate the statistic for each permutation.
   - Center observed and permuted statistics.
   - Visualize permutations through histograms with observed statistics marked in red.
   - Calculate the proportion of less extreme permutations for each group.

4. **Usage Example:**
   ```R
   set.seed(123)
   # Case 1: Difference of means
   resultados_perm_means <- perm4samp(x = heart$age, grupos = heart$cp, myfun = meandif)
   
   # Case 2: Difference of medians
   resultados_perm_medians <- perm4samp(x = heart$age, grupos = heart$cp, myfun = median_difer)
