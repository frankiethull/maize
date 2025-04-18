# {maize} package


# maize <img src="man/figures/logo.png" align="right" height="139" alt="" />

{maize} 🌽 is an extension library for kernels & support vector machines
in tidymodels! The package consists of additional kernel bindings that
are not available in the {parsnip} or {recipes} package. Many of the
kernels are ported from {kernlab}, additional kernels have been added
directly to maize transposed from
[Python](https://github.com/gmum/pykernels/blob/master/pykernels/regular.py)
and
[Julia](https://juliagaussianprocesses.github.io/KernelFunctions.jl/stable/kernels/)
packages.

{parnsip} has three kernels available: linear, radial basis function, &
polynomial. {maize} extends to further kernels, other engines, and adds
steps for {recipes}:

### `engines`

#### {kernlab}

SVMs with Specialty Kernels. Contains additional regression and
classification techniques such as LS-SVMs.

<div id="rfcfytmvhq" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
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

<div id="seiurtpvrv" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| {mildsvm} bindings🌽 |                 |                      |                |
|:---------------------|:----------------|:---------------------|:---------------|
| extension            | maize           | engine               | mode           |
| {parsnip}            | misvm_orova_rbf | mildsvm::misvm_orova | classification |

</div>

#### {ebmc}

Bagging and Boosting weak learners via Random Under Sampling for binary
classification.

<div id="vznscddjus" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| {ebmc} bindings🌽 |                       |             |                       |
|:------------------|:----------------------|:------------|:----------------------|
| extension         | maize                 | engine      | mode                  |
| {parsnip}         | bag_svm_laplace       | ebmc::ub    | binary-classification |
| {parsnip}         | rus_boost_svm_laplace | ebmc::rus   | binary-classification |
| {parsnip}         | ada_boost_svm_laplace | ebmc::adam2 | binary-classification |

</div>

### `recipes`

Steps for feature engineering data via kernel related methods.

<div id="yrkttmflfl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
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

### `probably`

Point calibration and conformal quantile regression with SVMs (QRSVM)
for prediction intervals.

<div id="bphvtauxfu" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  &#10;  

| post-processors🌽 |  |  |  |
|:---|:---|:---|:---|
| extension | maize | engine | mode |
| {probably} | int_conformal_quantile_svm | qrsvm::qrsvm | prediction intervals |
| {probably} | cal_estimate_svm | kernlab::ksvm | calibrator |

</div>
