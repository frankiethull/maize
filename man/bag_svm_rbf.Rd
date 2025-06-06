% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bag_svm_rbf.R
\name{bag_svm_rbf}
\alias{bag_svm_rbf}
\title{RUS Bagged SVM with Radial Basis Function Kernel}
\usage{
bag_svm_rbf(
  mode = "unknown",
  engine = "ebmc",
  num_learners = NULL,
  imb_ratio = NULL
)
}
\arguments{
\item{mode}{classification}

\item{engine}{ebmc's ub which uses e1701's svm}

\item{num_learners}{how many weak learners should be ensembled via bagging}

\item{imb_ratio}{major-minor class imbalance ratio}
}
\description{
RUS Bagged SVM with Radial Basis Function Kernel
}
