make_rvm_laplace <- function() {

  parsnip::set_new_model("rvm_laplace")

  parsnip::set_model_mode("rvm_laplace", "regression")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("rvm_laplace", "regression", "kernlab")
  parsnip::set_dependency("rvm_laplace", "kernlab", "kernlab")
  parsnip::set_dependency("rvm_laplace", "kernlab", "maize")

  parsnip::set_model_arg(
    model = "rvm_laplace",
    eng = "kernlab",
    parsnip = "alpha",
    original = "alpha",
    func = list(pkg = "maize", fun = "alpha", range = c(1, 5)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "rvm_laplace",
    eng = "kernlab",
    parsnip = "var",
    original = "var",
    func = list(pkg = "maize", fun = "var", range = c(.01, 100)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "rvm_laplace",
    eng = "kernlab",
    parsnip = "laplace_sigma",
    original = "sigma",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )

  parsnip::set_fit(
    model = "rvm_laplace",
    eng = "kernlab",
    mode = "regression",
    value = list(
      interface = "formula",
      data = c(formula = "x", data = "data"),
      protect = c("x", "data"),
      func = c(pkg = "kernlab", fun = "rvm"),
      defaults = list(kernel     = "laplacedot",
                      var.fix    = FALSE,
                      iterations = 100)
    )
  )

  parsnip::set_encoding(
    model = "rvm_laplace",
    eng = "kernlab",
    mode = "regression",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )



  parsnip::set_pred(
    model = "rvm_laplace",
    eng = "kernlab",
    mode = "regression",
    type = "numeric",
    value = list(
      pre = NULL,
      post = \(results, object) {
        results[,1]
      },
      func = c(pkg = "kernlab", fun = "predict"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data),
          type = "response"
        )
    )
  )

  parsnip::set_pred(
    model = "rvm_laplace",
    eng = "kernlab",
    mode = "regression",
    type = "raw",
    value = list(
      pre = NULL,
      post = NULL,
      func = c(pkg = "kernlab", fun = "predict"),
      args = list(object = quote(object$fit), newdata = quote(new_data))
    )
  )

}
