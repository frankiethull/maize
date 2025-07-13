# {maize} package


# maize <img src="man/figures/logo.png" align="right" height="139" alt="" />

{maize} 🌽 is an extension library for kernels & support vector machines
adding onto the tidymodels ecosystem. Many of the kernels are ported
from {kernlab}, additional kernels have been added directly to maize
transposed from
[Python](https://github.com/gmum/pykernels/blob/master/pykernels/regular.py)
and
[Julia](https://juliagaussianprocesses.github.io/KernelFunctions.jl/stable/kernels/)
packages.

The {parsnip} package offers three SVM kernel options: linear, radial
basis function, and polynomial. Building on this, {maize} introduces
additional kernels and supports a wider range of SVM engines. Beyond
kernel & SVM expansion to {parsnip}, {maize} also adds SVM capabilities
across other tidymodels libraries. These additions include extra
pre-processing steps for {recipes}, one-class novelty detection for
{applicable}, calibration and conformal inference tools for {probably},
and a {corrr}-like interface for kernel canonical correlation analysis.

## Installation

You can install the development version of maize from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("frankiethull/maize")
```

## engines

#### {kernlab}

SVMs with Specialty Kernels. Contains additional regression and
classification techniques such as LS-SVMs.

<div id="fytoutjbgi" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| {kernlab} bindings🌽 |  |  |  |
|:---|:---|:---|:---|
| extension | maize | engine | mode |
| {parsnip} | svm_laplace | kernlab::ksvm | regression & classification |
| {parsnip} | svm_tanh | kernlab::ksvm | regression & classification |
| {parsnip} | svm_bessel | kernlab::ksvm | regression & classification |
| {parsnip} | svm_anova_rbf | kernlab::ksvm | regression & classification |
| {parsnip} | svm_spline | kernlab::ksvm | regression & classification |
| {parsnip} | svm_cossim | kernlab::ksvm | regression & classification |
| {parsnip} | svm_cauchy | kernlab::ksvm | regression & classification |
| {parsnip} | svm_tanimoto | kernlab::ksvm | regression & classification |
| {parsnip} | svm_sorenson | kernlab::ksvm | regression & classification |
| {parsnip} | svm_tstudent | kernlab::ksvm | regression & classification |
| {parsnip} | svm_fourier | kernlab::ksvm | regression & classification |
| {parsnip} | svm_wavelet | kernlab::ksvm | regression & classification |
| {parsnip} | svm_string | kernlab::ksvm | classification |
| {parsnip} | lssvm_laplace | kernlab::lssvm | classification |
| {parsnip} | rvm_laplace | kernlab::rvm | regression |
| {parsnip} | kqr_laplace | kernlab::kqr | regression |

</div>

#### {mildsvm}

Multi-Instance Learners with SVMs. In particular, MIL with ordinal
outcomes using One-vs-All.

<div id="vhntduvkuv" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| {mildsvm} bindings🌽 |                 |                      |                |
|:---------------------|:----------------|:---------------------|:---------------|
| extension            | maize           | engine               | mode           |
| {parsnip}            | misvm_orova_rbf | mildsvm::misvm_orova | classification |

</div>

#### {ebmc}

Bagging and Boosting weak learners via Random Under Sampling for binary
classification.

<div id="bbueuxzfqf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| {ebmc} bindings🌽 |                       |             |                       |
|:------------------|:----------------------|:------------|:----------------------|
| extension         | maize                 | engine      | mode                  |
| {parsnip}         | bag_svm_laplace       | ebmc::ub    | binary-classification |
| {parsnip}         | rus_boost_svm_laplace | ebmc::rus   | binary-classification |
| {parsnip}         | ada_boost_svm_laplace | ebmc::adam2 | binary-classification |

</div>

### recipes

Steps for feature engineering data via kernel related methods.

<div id="chbdubgdiy" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| pre-processors🌽 |  |  |  |
|:---|:---|:---|:---|
| extension | maize | engine | mode |
| {recipes} | step_kpca_laplace | kernlab::kpca | transformation steps |
| {recipes} | step_kpca_tanh | kernlab::kpca | transformation steps |
| {recipes} | step_kha_laplace | kernlab::kha | transformation steps |
| {recipes} | step_kha_tanh | kernlab::kha | transformation steps |
| {recipes} | step_kfa_laplace | kernlab::kfa | transformation steps |
| {recipes} | step_kfm_nystrom | mildsvm::kfm_nystrom | transformation steps |

</div>

### probably

Point calibration and conformal quantile regression with SVMs (QRSVM)
for prediction intervals.

<div id="uzfygnrepk" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| post-processors🌽 |  |  |  |
|:---|:---|:---|:---|
| extension | maize | engine | mode |
| {probably} | int_conformal_quantile_svm | qrsvm::qrsvm | prediction intervals |
| {probably} | cal_estimate_svm | kernlab::ksvm | calibrator |

</div>

### modeltime

A special implementation of SVMs for time series regression. ARIMA &
AutoARIMA with SVM Errors are registered in maize. The *harvestime*
vignette showcases how-to-use ARIMA-SVMs & Recursive SVMs.

<div id="kdaxuuhyzx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| {modeltime} bindings🌽 |  |  |  |
|:---|:---|:---|:---|
| extension | maize | engine | mode |
| {modeltime} | arima_svm_laplace | forecast::Arima + maize::svm_laplace | regression |

</div>

### applicable

One-Class SVMs for novelty detection

<div id="ttkrjriqsw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| applicability🌽 |  |  |  |
|:---|:---|:---|:---|
| extension | maize | engine | mode |
| {applicable} | apd_svm_novel_detection | kernlab::ksvm | one-SVC novelty detection |

</div>

### corrr

Inspired by corrr, returns a tidy data frame class (kcor_df) for Kernel
Canonical Correlation Analysis:

<div id="tsyeflobat" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| KCCA🌽 |  |  |  |
|:---|:---|:---|:---|
| extension | maize | engine | mode |
| {corrr} | kcca_correlate | kernlab::kcca | kernel canonical correlation analysis |

</div>
