# Wavelet Support Vector Machine

wavelet kernel for support vector machines

## Usage

``` r
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

- sigma:

  sigma parameter for svm wavelet kernel

- a:

  scale adjustment parameter for wavelet kernels (temp name)

- c:

  dist adjustment parameter for wavelet kernels can be NULL (temp name)

- h:

  wavelet function for wavelet kernel, default wavelet if NULL (temp
  name)
