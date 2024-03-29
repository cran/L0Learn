% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coef.R
\name{coef.L0Learn}
\alias{coef.L0Learn}
\alias{coef.L0LearnCV}
\title{Extract Solutions}
\usage{
\method{coef}{L0Learn}(object, lambda = NULL, gamma = NULL, ...)

\method{coef}{L0LearnCV}(object, lambda = NULL, gamma = NULL, ...)
}
\arguments{
\item{object}{The output of L0Learn.fit or L0Learn.cvfit}

\item{lambda}{The value of lambda at which to extract the solution.}

\item{gamma}{The value of gamma at which to extract the solution.}

\item{...}{ignore}
}
\value{
A sparse Matrix of class \code{dgCMatrix}, which contains the model
coefficients. If both lambda and gamma are not supplied, then a matrix of 
coefficients for all the solutions in the regularization path is returned. 
If lambda is supplied but gamma is not, the smallest value of gamma is used.
}
\description{
Extracts a specific solution in the regularization path.
}
\examples{
# Generate synthetic data for this example
data <- GenSynthetic(n=100,p=20,k=10,seed=1)
X = data$X
y = data$y

# Fit an L0L2 Model with 3 values of Gamma ranging from 0.0001 to 10, using coordinate descent
fit <- L0Learn.fit(X, y, penalty="L0L2", nGamma=3, gammaMin=0.0001, gammaMax = 10)
print(fit)
# Extract the coefficients of the solution at lambda = 2.45513e-02 and gamma = 0.0001
coef(fit, lambda=2.45513e-02, gamma=0.0001)
# Extract the coefficients of all the solutions in the path
coef(fit)

}
