returnStatistics <- function(control = 0){
  testData = createData(sampleSize = 20, family = poisson(), overdispersion = control, 
                        randomEffectVariance = 0)
  fittedModel <- glm(observedResponse ~ Environment1, data = testData, family = poisson())
  res <- simulateResiduals(fittedModel = fittedModel, n = 250)
  out <- c(testUniformity(res, plot = FALSE)$p.value, testDispersion(res, plot = FALSE)$p.value)
  return(out)
}

# testing a single return
returnStatistics()

# running benchmark
out = runBenchmarks(returnStatistics, nRep = 5)

# plotting results depend on whether a vector or a single value is provided for control
plot(out)

# running benchmark parallel
# out = runBenchmarks(returnStatistics, nRep = 50, parallel = TRUE)

# include control values
# out = runBenchmarks(returnStatistics, controlValues = c(0,0.5,1), nRep = 5)


# Alternative plot function using vioplot, provides nicer pictures 

# plot.DHARMaBenchmark <- function(x, ...){
#   
#   if(length(x$controlValues)== 1){
#     vioplot::vioplot(x$simulations[,x$nSummaries:1], las = 2, horizontal = T, side = "right", 
#                      areaEqual = F,
#                      main = "p distribution under H0",
#                      ylim = c(-0.15,1), ...)
#     abline(v = 1, lty = 2)
#     abline(v = c(0.05, 0), lty = 2, col = "red")
#     text(-0.1, x$nSummaries:1, labels = x$summaries$propSignificant[-1])
#     
#   }else{
#     res = x$summaries$propSignificant
#     matplot(res$controlValues, res[,-1], type = "l", main = "Power analysis", ylab = "Power", ...)
#     legend("bottomright", colnames(res[,-1]), col = 1:x$nSummaries, lty = 1:x$nSummaries, lwd = 2)    
#     
#   }
# }
