#!/usr/bin/Rscript
# Usage: cat names.txt | Rscript sekigae.r

frame <- read.table('stdin', stringsAsFactors = F)

names <- frame[, 1][sample(1:6, size = 6)]

dim(names) = c(2, 3)
rownames(names) <- c("front", "back")
colnames(names) <- c("1", "2", "3")

print(names)

