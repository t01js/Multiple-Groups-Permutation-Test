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
   data <- c(rnorm(50, mean = 0, sd = 1), rnorm(50, mean = 2, sd = 1), rnorm(50, mean = 5, sd = 1))
   groups <- rep(1:3, each = 50)
   results <- permKsamp(data, groups, nsamp = 10000)
