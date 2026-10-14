# Kernel Canonical Correlation Analysis

Computes the canonical correlation analysis in feature space. Kernel
Canonical Correlation Analysis (KCCA) is a non-linear extension of CCA.
Given two random variables (or datasets), KCCA aims at extracting the
information which is shared by the two random variables (or datasets).
more information found at
[`kernlab::kcca()`](https://rdrr.io/pkg/kernlab/man/kcca.html)

## Usage

``` r
kcca_correlate(x, y = NULL, kernel = "rbfdot", gamma = 0.1, num_comp = 10, ...)
```

## Arguments

- x:

  variable or dataframe

- y:

  variable or dataframe

- kernel:

  a kernel to use

- gamma:

  regularization parameter

- num_comp:

  number of components

- ...:

  pass through args for kcca function

## Value

A kernel canonical correlation analysis data frame `kcor_df`
