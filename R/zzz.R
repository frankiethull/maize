
.onLoad <- function(libname, pkgname) {
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
}
