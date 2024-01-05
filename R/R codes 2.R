library(tidyverse)

# Data preparation
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
# Inspect
set.seed(123)
sample_n(ToothGrowth, 6)

res <- var.test(len ~ supp, data = ToothGrowth)
res
