#' @title Predict Response
#'
#' @description Predicts the response for a given sample.
#' @param object The output of L0Learn.fit or L0Learn.cvfit
#' @param ... ignore
#' @param newx A matrix on which predictions are made. The matrix should have p columns.
#' @param lambda The value of lambda to use for prediction. A summary of the lambdas in the regularization
#' path can be obtained using \code{print(fit)}.
#' @param gamma The value of gamma to use for prediction. A summary of the gammas in the regularization
#' path can be obtained using \code{print(fit)}.
#' @return A Matrix of class \code{dgeMatrix}, which contains the model
#' predictions. If both lambda and gamma are not supplied, then a matrix of
#' predictions for all the solutions in the regularization path is returned.
#' If lambda is supplied but gamma is not, the smallest value of gamma is used.
#' In case of logistic regression, probability values are returned.
#' @method predict L0Learn
#' @examples
#' # Generate synthetic data for this example
#' data <- GenSynthetic(n=100,p=20,k=10,seed=1)
#' X = data$X
#' y = data$y
#'
#' # Fit an L0L2 Model with 3 values of Gamma ranging from 0.0001 to 10, using coordinate descent
#' fit <- L0Learn.fit(X,y, penalty="L0L2", nGamma=3, gammaMin=0.0001, gammaMax = 10)
#' print(fit)
#' # Apply the fitted model with lambda=2.45513e-02 and gamma=0.0001 on X to predict the response
#' predict(fit, newx = X, lambda=2.45513e-02, gamma=0.0001)
#' # Apply the fitted model on X to predict the response for all the solutions in the path
#' predict(fit, newx = X)
#'
#' @export
predict.L0Learn <- function(object,newx,lambda=NULL,gamma=NULL, ...)
{
		beta = coef.L0Learn(object, lambda, gamma)
		if (object$settings$intercept){
				# add a column of ones for the intercept
				x = cbind(1,newx)
		}
		else{
				x = newx
		}
		prediction = x%*%beta
		#if (object$loss == "Logistic" || object$loss == "SquaredHinge"){
		#		prediction = sign(prediction)
		#}
		if (object$loss == "Logistic"){
				prediction = 1/(1+exp(-prediction))
		}
		prediction
}

#' @rdname predict.L0Learn
#' @method predict L0LearnCV
#' @export
predict.L0LearnCV <- function(object,newx,lambda=NULL,gamma=NULL, ...)
{
    predict.L0Learn(object$fit,newx,lambda,gamma, ...)
}
