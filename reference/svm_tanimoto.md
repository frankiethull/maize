# Tanimoto Support Vector Machine

tanimoto kernel for support vector machines which is used as a graph
kernel for chemical informatics

## Usage

``` r
svm_tanimoto(mode = "unknown", engine = "kernlab", cost = NULL, margin = NULL)
```

## Arguments

- mode:

  regression or classification

- engine:

  kernlab ksvm

- cost:

  A positive number for the cost of predicting a sample within or on the
  wrong side of the margin

- margin:

  A positive number for the epsilon in the SVM insensitive loss function
  (regression only)
