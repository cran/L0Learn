## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  comment = "#>"
)

## ----echo = FALSE--------------------------------------------------------
# Thanks to Yihui Xie for providing this code
library(knitr)
hook_output <- knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
   lines <- options$output.lines
   if (is.null(lines)) {
     return(hook_output(x, options))  # pass to default hook
   }
   x <- unlist(strsplit(x, "\n"))
   more <- "..."
   if (length(lines)==1) {        # first n lines
     if (length(x) > lines) {
       # truncate the output, but add ....
       x <- c(head(x, lines), more)
     }
   } else {
     x <- c(more, x[lines], more)
   }
   # paste these lines together
   x <- paste(c(x, ""), collapse = "\n")
   hook_output(x, options)
 })

## ---- eval=FALSE---------------------------------------------------------
#  install.packages("L0Learn")

## ------------------------------------------------------------------------
set.seed(1) # fix the seed to get a reproducible result
X = matrix(rnorm(500*1000),nrow=500,ncol=1000)
B = c(rep(1,10),rep(0,990))
e = rnorm(500)
y = X%*%B + e

## ------------------------------------------------------------------------
library(L0Learn)

## ------------------------------------------------------------------------
fit <- L0Learn.fit(X, y, penalty="L0", maxSuppSize=20)

## ------------------------------------------------------------------------
print(fit)

## ----output.lines=15-----------------------------------------------------
coef(fit, lambda=0.0325142, gamma=0)

## ----output.lines=15-----------------------------------------------------
predict(fit, newx=X, lambda=0.0325142, gamma=0)

## ---- fig.height = 4, fig.width = 7, out.width="80%", dpi=300------------
plot(fit, gamma=0)

## ------------------------------------------------------------------------
fit <- L0Learn.fit(X, y, penalty="L0L2", nGamma = 5, gammaMin = 0.0001, gammaMax = 10, maxSuppSize=20)

## ----output.lines=30-----------------------------------------------------
print(fit)

## ----output.lines=15-----------------------------------------------------
coef(fit,lambda=0.0011539, gamma=10)

## ----eval=FALSE----------------------------------------------------------
#  predict(fit, newx=X, lambda=0.0011539, gamma=10)

## ------------------------------------------------------------------------
cvfit = L0Learn.cvfit(X, y, nFolds=5, seed=1, penalty="L0L2", nGamma=5, gammaMin=0.0001, gammaMax=0.1, maxSuppSize=50)

## ------------------------------------------------------------------------
lapply(cvfit$cvMeans, min)

## ---- fig.height = 4, fig.width = 7, out.width="80%", dpi=300------------
plot(cvfit, gamma=cvfit$fit$gamma[4])

## ------------------------------------------------------------------------
optimalGammaIndex = 4 # index of the optimal gamma identified previously
optimalLambdaIndex = which.min(cvfit$cvMeans[[optimalGammaIndex]])
optimalLambda = cvfit$fit$lambda[[optimalGammaIndex]][optimalLambdaIndex]
optimalLambda

## ----output.lines=15-----------------------------------------------------
coef(cvfit, lambda=optimalLambda, gamma=cvfit$fit$gamma[4])

## ------------------------------------------------------------------------
fit <- L0Learn.fit(X, y, penalty="L0", maxSuppSize=20, excludeFirstK=3)

## ---- fig.height = 4, fig.width = 7, out.width="80%", dpi=300------------
plot(fit, gamma=0)

## ------------------------------------------------------------------------
userLambda <- list()
userLambda[[1]] <- c(1, 1e-1, 1e-2, 1e-3, 1e-4)
fit <- L0Learn.fit(X, y, penalty="L0", autoLambda=FALSE, lambdaGrid=userLambda)

## ------------------------------------------------------------------------
print(fit)
