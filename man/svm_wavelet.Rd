% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/svm_wavelet.R
\name{svm_wavelet}
\alias{svm_wavelet}
\title{Wavelet Support Vector Machine}
\usage{
svm_wavelet(
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  margin = NULL,
  sigma = NULL,
  a = 1,
  c = NULL,
  h = NULL
)
}
\arguments{
\item{mode}{regression or classification}

\item{engine}{kernlab ksvm}

\item{cost}{A positive number for the cost of predicting a sample within
or on the wrong side of the margin}

\item{margin}{A positive number for the epsilon in the SVM insensitive
loss function (regression only)}

\item{sigma}{sigma parameter for svm wavelet kernel}

\item{a}{scale adjustment parameter for wavelet kernels (temp name)}

\item{c}{dist adjustment parameter for wavelet kernels can be NULL (temp name)}

\item{h}{wavelet function for wavelet kernel, default wavelet if NULL (temp name)}
}
\description{
wavelet kernel for support vector machines
}
