# RUSBoost SVM with Radial Basis Function Kernel

RUSBoost SVM with Radial Basis Function Kernel

## Usage

``` r
rus_boost_svm_rbf(
  mode = "unknown",
  engine = "ebmc",
  num_learners = NULL,
  imb_ratio = NULL
)
```

## Arguments

- mode:

  classification

- engine:

  ebmc's rus which uses e1701's svm

- num_learners:

  how many weak learners should be ensembled via boosting

- imb_ratio:

  major-minor class imbalance ratio
