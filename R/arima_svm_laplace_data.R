
# https://github.com/business-science/modeltime/blob/master/R/parsnip-arima_boost_data.R

make_arima_svm_laplace <- function() {

  parsnip::set_new_model("arima_svm_laplace")
  parsnip::set_model_mode("arima_svm_laplace", "regression")

  # auto_arima_svm_laplace ----

  # * Model ----
  parsnip::set_model_engine("arima_svm_laplace", mode = "regression", eng = "auto_arima_svm_laplace")
  parsnip::set_dependency("arima_svm_laplace", "auto_arima_svm_laplace", "forecast")
  parsnip::set_dependency("arima_svm_laplace", "auto_arima_svm_laplace", "modeltime")
  parsnip::set_dependency("arima_svm_laplace", "auto_arima_svm_laplace", "kernlab")
  parsnip::set_dependency("arima_svm_laplace", "auto_arima_svm_laplace", "maize")

  # * Args - ARIMA ----
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "auto_arima_svm_laplace",
    parsnip      = "seasonal_period",
    original     = "period",
    func         = list(pkg = "modeltime", fun = "seasonal_period"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "auto_arima_svm_laplace",
    parsnip      = "non_seasonal_ar",
    original     = "max.p",
    func         = list(pkg = "modeltime", fun = "non_seasonal_ar"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "auto_arima_svm_laplace",
    parsnip      = "non_seasonal_differences",
    original     = "max.d",
    func         = list(pkg = "modeltime", fun = "non_seasonal_differences"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "auto_arima_svm_laplace",
    parsnip      = "non_seasonal_ma",
    original     = "max.q",
    func         = list(pkg = "modeltime", fun = "non_seasonal_ma"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "auto_arima_svm_laplace",
    parsnip      = "seasonal_ar",
    original     = "max.P",
    func         = list(pkg = "modeltime", fun = "seasonal_ar"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "auto_arima_svm_laplace",
    parsnip      = "seasonal_differences",
    original     = "max.D",
    func         = list(pkg = "modeltime", fun = "seasonal_differences"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "auto_arima_svm_laplace",
    parsnip      = "seasonal_ma",
    original     = "max.Q",
    func         = list(pkg = "modeltime", fun = "seasonal_ma"),
    has_submodel = FALSE
  )

  # * Args - SVM Laplace ----
  parsnip::set_model_arg(
    model = "arima_svm_laplace",
    eng = "auto_arima_svm_laplace",
    parsnip = "cost",
    original = "cost",
    func = list(pkg = "dials", fun = "cost", range = c(-10, 5)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "arima_svm_laplace",
    eng = "auto_arima_svm_laplace",
    parsnip = "margin",
    original = "margin",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "arima_svm_laplace",
    eng = "auto_arima_svm_laplace",
    parsnip = "laplace_sigma",
    original = "laplace_sigma",
    func = list(pkg = "dials", fun = "rbf_sigma"),
    has_submodel = FALSE
  )

  # * Encoding ----
  parsnip::set_encoding(
    model   = "arima_svm_laplace",
    eng     = "auto_arima_svm_laplace",
    mode    = "regression",
    options = list(
      predictor_indicators = "none",
      compute_intercept    = FALSE,
      remove_intercept     = FALSE,
      allow_sparse_x       = FALSE
    )
  )

  # * Fit ----
  parsnip::set_fit(
    model         = "arima_svm_laplace",
    eng           = "auto_arima_svm_laplace",
    mode          = "regression",
    value         = list(
      interface = "data.frame",
      protect   = c("x", "y"),
      func      = c(fun = "auto_arima_svm_laplace_fit_impl"),
      defaults  = list(NULL)
    )
  )

  # * Predict ----
  parsnip::set_pred(
    model         = "arima_svm_laplace",
    eng           = "auto_arima_svm_laplace",
    mode          = "regression",
    type          = "numeric",
    value         = list(
      pre       = NULL,
      post      = NULL,
      func      = c(fun = "predict"),
      args      =
        list(
          object   = rlang::expr(object$fit),
          new_data = rlang::expr(new_data)
        )
    )
  )


  # arima_svm_laplace ----


  # * Model ----
  parsnip::set_model_engine("arima_svm_laplace", mode = "regression", eng = "arima_svm_laplace")
  parsnip::set_dependency("arima_svm_laplace", "arima_svm_laplace", "forecast")
  parsnip::set_dependency("arima_svm_laplace", "arima_svm_laplace", "kernlab")
  parsnip::set_dependency("arima_svm_laplace", "arima_svm_laplace", "modeltime")
  parsnip::set_dependency("arima_svm_laplace", "arima_svm_laplace", "maize")

  # * Args - ARIMA ----
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "arima_svm_laplace",
    parsnip      = "seasonal_period",
    original     = "period",
    func         = list(pkg = "modeltime", fun = "seasonal_period"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "arima_svm_laplace",
    parsnip      = "non_seasonal_ar",
    original     = "p",
    func         = list(pkg = "modeltime", fun = "non_seasonal_ar"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "arima_svm_laplace",
    parsnip      = "non_seasonal_differences",
    original     = "d",
    func         = list(pkg = "modeltime", fun = "non_seasonal_differences"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "arima_svm_laplace",
    parsnip      = "non_seasonal_ma",
    original     = "q",
    func         = list(pkg = "modeltime", fun = "non_seasonal_ma"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "arima_svm_laplace",
    parsnip      = "seasonal_ar",
    original     = "P",
    func         = list(pkg = "modeltime", fun = "seasonal_ar"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "arima_svm_laplace",
    parsnip      = "seasonal_differences",
    original     = "D",
    func         = list(pkg = "modeltime", fun = "seasonal_differences"),
    has_submodel = FALSE
  )
  parsnip::set_model_arg(
    model        = "arima_svm_laplace",
    eng          = "arima_svm_laplace",
    parsnip      = "seasonal_ma",
    original     = "Q",
    func         = list(pkg = "modeltime", fun = "seasonal_ma"),
    has_submodel = FALSE
  )

  # * Args - SVM Laplace ----
  parsnip::set_model_arg(
    model = "arima_svm_laplace",
    eng = "arima_svm_laplace",
    parsnip = "cost",
    original = "cost",
    func = list(pkg = "dials", fun = "cost", range = c(-10, 5)),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "arima_svm_laplace",
    eng = "arima_svm_laplace",
    parsnip = "margin",
    original = "margin",
    func = list(pkg = "dials", fun = "svm_margin"),
    has_submodel = FALSE
  )

  parsnip::set_model_arg(
    model = "arima_svm_laplace",
    eng = "arima_svm_laplace",
    parsnip = "laplace_sigma",
    original = "laplace_sigma",
    func = list(pkg = "dials", fun = "rbf_sigma"),
    has_submodel = FALSE
  )


  # * Encoding ----
  parsnip::set_encoding(
    model   = "arima_svm_laplace",
    eng     = "arima_svm_laplace",
    mode    = "regression",
    options = list(
      predictor_indicators = "none",
      compute_intercept    = FALSE,
      remove_intercept     = FALSE,
      allow_sparse_x       = FALSE
    )
  )

  # * Fit ----
  parsnip::set_fit(
    model         = "arima_svm_laplace",
    eng           = "arima_svm_laplace",
    mode          = "regression",
    value         = list(
      interface = "data.frame",
      protect   = c("x", "y"),
      func      = c(fun = "arima_svm_laplace_fit_impl"),
      defaults  = list(NULL)
    )
  )

  # * Predict ----
  parsnip::set_pred(
    model         = "arima_svm_laplace",
    eng           = "arima_svm_laplace",
    mode          = "regression",
    type          = "numeric",
    value         = list(
      pre       = NULL,
      post      = NULL,
      func      = c(fun = "predict"),
      args      =
        list(
          object   = rlang::expr(object$fit),
          new_data = rlang::expr(new_data)
        )
    )
  )

}
