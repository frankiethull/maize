
.onLoad <- function(libname, pkgname) {
# kernlab engines + maize kernels ----

  # SVMs
  make_svm_laplace()
  make_svm_tanh()
  make_svm_bessel()
  make_svm_anova_rbf()
  make_svm_spline()
  make_svm_cossim()
  make_svm_cauchy()
  make_svm_tanimoto()
  make_svm_sorensen()
  make_svm_tstudent()
  make_svm_fourier()
  make_svm_wavelet()
  make_svm_string()

  # RVMs
  make_rvm_laplace()

  # KQRs
  make_kqr_laplace()

  # LSSVMs
  make_lssvm_laplace()

# ebmc random-under-sampling (rus) engines ----

  # bagged  SVMs
  make_bag_svm_rbf()

  # boosted SVMs
  make_rus_boost_svm_rbf()
  make_ada_boost_svm_rbf()

# mildsvm engines   ----

  # multi-instance SVMs
  make_misvm_orova_rbf()

}
