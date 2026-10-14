# Multiple Instance SVMs for Ordinal Outcome Data, One-Vs-All, with Radial Basis Function Kernel

Multiple Instance SVMs for Ordinal Outcome Data, One-Vs-All, with Radial
Basis Function Kernel

## Usage

``` r
misvm_orova_rbf(
  mode = "unknown",
  engine = "ebmc",
  cost = NULL,
  rbf_sigma = NULL
)
```

## Arguments

- mode:

  classification

- engine:

  [`mildsvm::misvm_orova()`](https://rdrr.io/pkg/mildsvm/man/misvm_orova.html)
  which uses e1701's svm

- cost:

  A positive number for the cost of predicting a sample within or on the
  wrong side of the margin

- rbf_sigma:

  A positive number for radial basis function.
