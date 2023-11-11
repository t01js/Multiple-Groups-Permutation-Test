# Permutation Test for Multiple Groups

## Initial Definitions

- **x:** A numeric vector containing the data to be analyzed.

- **grupos:** A vector indicating which group each observation in the vector `x` belongs to.

- **myfun:** The statistic of interest for the permutation test. By default, the mean (`mean`) is used, but you can specify another function.

- **nsamp:** The number of permutations to be performed. A higher number improves precision but also increases computation time.

- **alternativa:** A vector specifying the alternative for the permutation test for each group. It can be "bilateral," "unil.inferior," or "unil.superior" for each respective group.

- **seed:** Seed for result reproducibility. If not provided, results may vary between runs.

## `permKsamp` Function

```R
# Install and load the 'permute' library if not already installed
if (!requireNamespace("permute", quietly = TRUE)) {
  install.packages("permute")
}

# Load the 'permute' library
library(permute)

# Function to calculate the difference of medians for two groups
median_difer <- function(x, grupos) {
  mediana = tapply(x, grupos, median)
  diferencia = mediana[1] - mediana[2]
  names(diferencia) = "Median Difference"
  diferencia
}

# Define your function for the difference of means
meandif <- function(x, grupos) {
  medias = tapply(x, grupos, mean)
  dif = medias[1] - medias[2]
  names(dif) = "Mean Difference"
  dif
}

# Define your function to perform the permutation test for four groups
perm4samp <- function(x, grupos, myfun, nsamp = 10000, alternativa = c("bilateral", "unil.inferior", "unil.superior"), seed = NULL) {
  theta.hat = myfun(x, grupos)
  N = length(x)
  
  if (!is.null(seed)) set.seed(seed) 
  gmat = replicate(nsamp, sample.int(N, N, replace = FALSE))
  theta.mc = apply(gmat, 2, function(g, x, z) { myfun(x, z[g]) }, x = x, z = grupos)
  theta.mc.c = theta.mc - mean(theta.mc)
  theta.hat.c = theta.hat - mean(theta.mc)
  
  hist(theta.mc.c, main = 'Histogram of Permutation Differences', ylab = 'Frequencies', col = "#faedcd")
  abline(v = theta.hat.c, col = "red", lwd = 3)
  
  if (alternativa[1] == "unil.inferior") {
    aslperm = sum(theta.mc.c <= theta.hat.c) / nsamp
  } else if (alternativa[1] == "unil.superior") {
    aslperm = sum(theta.mc.c >= theta.hat.c) / nsamp
  } else {
    aslperm = sum(abs(theta.mc.c) >= abs(theta.hat.c)) / nsamp
  }
  
  # Return the results
  list(theta.hat = theta.hat, theta.mc = theta.mc, nsa = aslperm, seed = seed)
}

# Perform the permutation test for the two cases
# Case 1: Difference of means
resultados_perm_means <- perm4samp(x = data$variable1, grupos = data$variable2, myfun = meandif)

# Case 2: Difference of medians
resultados_perm_medians <- perm4samp(x = data$variable1, grupos = data$variable2, myfun = median_difer)

