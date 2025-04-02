make_kqr_laplace <- function() {

  parsnip::set_new_model("kqr_laplace")

  parsnip::set_model_mode("kqr_laplace", "regression")

  # ------------------------------------------------------------------------------

  parsnip::set_model_engine("kqr_laplace", "regression", "kernlab")
  parsnip::set_dependency("kqr_laplace", "kernlab", "kernlab")
  parsnip::set_dependency("kqr_laplace", "kernlab", "maize")

  parsnip::set_model_arg(
    model = "kqr_laplace",
    eng = "kernlab",
    parsnip = "cost",
    original = "C",
    func = list(pkg = "dials", fun = "cost", range = c(-10, 5)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "kqr_laplace",
    eng = "kernlab",
    parsnip = "tau",
    original = "tau",
    func = list(pkg = "maize", fun = "tau", range = c(.01, .99)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "kqr_laplace",
    eng = "kernlab",
    parsnip = "laplace_sigma",
    original = "sigma",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )


  parsnip::set_fit(
    model = "kqr_laplace",
    eng = "kernlab",
    mode = "regression",
    value = list(
      interface = "formula",
      data = c(formula = "x", data = "data"),
      protect = c("x", "data"),
      func = c(pkg = "kernlab", fun = "kqr"),
      defaults = list(kernel = "laplacedot")
    )
  )

  parsnip::set_encoding(
    model = "kqr_laplace",
    eng = "kernlab",
    mode = "regression",
    options = list(
      predictor_indicators = "none",
      compute_intercept = FALSE,
      remove_intercept = FALSE,
      allow_sparse_x = FALSE
    )
  )

  kqr_reg_post <- function(results, object) {
    results[,1]
  }
  parsnip::set_pred(
    model = "kqr_laplace",
    eng = "kernlab",
    mode = "regression",
    type = "numeric",
    value = list(
      pre = NULL,
      post = kqr_reg_post,
      func = c(pkg = "kernlab", fun = "predict"),
      args =
        list(
          object = quote(object$fit),
          newdata = quote(new_data)#,
          #type = "response"
        )
    )
  )

  parsnip::set_pred(
    model = "kqr_laplace",
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
