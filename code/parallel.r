theList <- list(A=1:100, B=c(3, 7, 4), C=5, D=23:38)

library(purrr)
map(theList, sum)

library(doParallel)

detectCores()

cl <- makeCluster(3)
cl

registerDoParallel(cl)

foreach(a=theList) %dopar%
{
    sum(a)
}

startTime <- Sys.time()
foreach(a=theList, .combine=c) %dopar%
{
    sum(a)
}
endTime <- Sys.time()
endTime - startTime

# microbenchmark

foreach(a=theList, .combine=c, .multicombine=TRUE) %dopar%
{
    sum(a)
}

foreach(a=theList, .combine=c, .multicombine=TRUE, .inorder=FALSE) %dopar%
{
    sum(a)
}

foreach(a=theList, .packages=c('dplyr', 'purrr')) %dopar%
{
    sum(a)
}