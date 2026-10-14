# ANOVA RBF Support Vector Machine

anova rbf for support vector machines

## Usage

``` r
svm_anova_rbf(
  mode = "unknown",
  engine = "kernlab",
  cost = NULL,
  anova_rbf_sigma = NULL,
  degree = NULL,
  margin = NULL
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

- anova_rbf_sigma:

  sigma parameter for anova rbf

- degree:

  degree parameter for anova rbf

- margin:

  A positive number for the epsilon in the SVM insensitive loss function
  (regression only)
