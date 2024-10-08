% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/svm_fourier.R
\name{svm_fourier}
\alias{svm_fourier}
\title{Fourier Support Vector Machine}
\usage{
svm_fourier(
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  margin = NULL,
  sigma = NULL
)
}
\arguments{
\item{mode}{regression or classification}

\item{engine}{kernlab ksvm}

\item{cost}{A positive number for the cost of predicting a sample within
or on the wrong side of the margin}

\item{margin}{A positive number for the epsilon in the SVM insensitive
loss function (regression only)}

\item{sigma}{a sigma parameter for fourier kernels}
}
\description{
fourier kernel for support vector machines
}
