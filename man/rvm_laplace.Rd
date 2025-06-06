% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rvm_laplace.R
\name{rvm_laplace}
\alias{rvm_laplace}
\title{Laplacian Relevance Vector Machine (Experimental RVM)}
\usage{
rvm_laplace(
  mode = "unknown",
  engine = "kernlab",
  alpha = NULL,
  var = NULL,
  laplace_sigma = NULL
)
}
\arguments{
\item{mode}{regression only for RVM}

\item{engine}{kernlab rvm}

\item{alpha}{(alpha) The initial alpha value or vector.
Can be either a vector of length equal to the number of data points or a single number.}

\item{var}{(var) the initial noise variance}

\item{laplace_sigma}{sigma parameter for laplacian}
}
\description{
laplacian kernel
}
