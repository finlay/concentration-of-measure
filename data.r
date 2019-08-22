library(data.table)

## Randomly generate normally distributed matrix

cols <- 100
rows <- 1e3

make.lengths <- function(cols, rows) {
    mat <- matrix(rnorm(cols * rows), ncol=cols)
    #mat <- matrix(runif(cols * rows, min=-1, max=1), ncol=cols)
    lengths <- apply(mat, 1, norm, type='2')
    return(lengths/sqrt(cols))
}

lengths <- lapply(1:cols, function(c) make.lengths(c, rows))

dat <- do.call('rbind', lapply(1:cols, function(c) {
                             data.frame(cols=c, length=lengths[[c]])}))

setDT(dat)

saveRDS(file='data.rds', dat)

