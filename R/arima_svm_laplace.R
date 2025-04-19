# ARIMA SVM LAPLACIAN -----------

#' General Interface for "Support Vector Machine" ARIMA Regression Models
#'
#' `arima_svm_laplace()` is a way to generate a _specification_ of a time series model
#'  that uses SVMs to improve modeling errors (residuals) on Exogenous Regressors.
#'  It works with both "automated" ARIMA (`auto.arima`) and standard ARIMA (`arima`).
#'  The main algorithms are:
#'  - Auto ARIMA + SVM Errors (engine = `auto_arima_svm_laplace`, default)
#'  - ARIMA + SVM Errors (engine = `arima_svm_laplace`)
#' @param mode A single character string for the type of model.
#'  The only possible value for this model is "regression".
#' @param sample_size  number for the number (or proportion) of data that is exposed to the fitting routine.
#' @param seasonal_period A seasonal frequency. Uses "auto" by default.
#'  A character phrase of "auto" or time-based phrase of "2 weeks"
#'  can be used if a date or date-time variable is provided.
#'  See Fit Details below.
#' @param non_seasonal_ar The order of the non-seasonal auto-regressive (AR) terms. Often denoted "p" in pdq-notation.
#' @param non_seasonal_differences The order of integration for non-seasonal differencing. Often denoted "d" in pdq-notation.
#' @param non_seasonal_ma The order of the non-seasonal moving average (MA) terms. Often denoted "q" in pdq-notation.
#' @param seasonal_ar The order of the seasonal auto-regressive (SAR) terms. Often denoted "P" in PDQ-notation.
#' @param seasonal_differences The order of integration for seasonal differencing. Often denoted "D" in PDQ-notation.
#' @param seasonal_ma The order of the seasonal moving average (SMA) terms. Often denoted "Q" in PDQ-notation.
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param margin A positive number for the epsilon in the SVM insensitive
#'  loss function (regression only)
#' @param laplace_sigma sigma parameter for laplacian
#' @export
arima_svm_laplace <- \(mode = "regression",
                       seasonal_period = NULL,
                       non_seasonal_ar = NULL, non_seasonal_differences = NULL, non_seasonal_ma = NULL,
                       seasonal_ar = NULL, seasonal_differences = NULL, seasonal_ma = NULL,
                       cost = NULL, margin = NULL, laplace_sigma = NULL) {

  args <- list(

    # ARIMA
    seasonal_period           = rlang::enquo(seasonal_period),
    non_seasonal_ar           = rlang::enquo(non_seasonal_ar),
    non_seasonal_differences  = rlang::enquo(non_seasonal_differences),
    non_seasonal_ma           = rlang::enquo(non_seasonal_ma),
    seasonal_ar               = rlang::enquo(seasonal_ar),
    seasonal_differences      = rlang::enquo(seasonal_differences),
    seasonal_ma               = rlang::enquo(seasonal_ma),

    # SVM
    cost                      = rlang::enquo(cost),
    margin                    = rlang::enquo(margin),
    laplace_sigma             = rlang::enquo(laplace_sigma)
  )

  parsnip::new_model_spec(
    "arima_svm_laplace",
    args     = args,
    eng_args = NULL,
    mode     = mode,
    method   = NULL,
    engine   = NULL
  )

}

#' @export
print.arima_svm_laplace <- function(x, ...) {
  cat("Time Series Model w/ SVM Error Specification (", x$mode, ")\n\n", sep = "")
  parsnip::model_printer(x, ...)

  if(!is.null(x$method$fit$args)) {
    cat("Model fit template:\n")
    print(parsnip::show_call(x))
  }

  invisible(x)
}

#' @export
#' @importFrom stats update
update.arima_svm_laplace <- function(object,
                               parameters = NULL, seasonal_period = NULL,
                               non_seasonal_ar = NULL, non_seasonal_differences = NULL, non_seasonal_ma = NULL,
                               seasonal_ar = NULL, seasonal_differences = NULL, seasonal_ma = NULL,
                               cost = NULL, margin = NULL, laplace_sigma = NULL, ...) {

  eng_args <- parsnip::update_engine_parameters(object$eng_args, fresh, ...)

  if (!is.null(parameters)) {
    parameters <- parsnip::check_final_param(parameters)
  }

  args <- list(

    # ARIMA
    seasonal_period           = rlang::enquo(seasonal_period),
    non_seasonal_ar           = rlang::enquo(non_seasonal_ar),
    non_seasonal_differences  = rlang::enquo(non_seasonal_differences),
    non_seasonal_ma           = rlang::enquo(non_seasonal_ma),
    seasonal_ar               = rlang::enquo(seasonal_ar),
    seasonal_differences      = rlang::enquo(seasonal_differences),
    seasonal_ma               = rlang::enquo(seasonal_ma),

    # SVM Laplace
    cost                      = rlang::enquo(cost),
    margin                    = rlang::enquo(margin),
    laplace_sigma             = rlang::enquo(laplace_sigma)
  )

  args <- parsnip::update_main_parameters(args, parameters)

  if (fresh) {
    object$args <- args
    object$eng_args <- eng_args
  } else {
    null_args <- purrr::map_lgl(args, parsnip::null_value)
    if (any(null_args))
      args <- args[!null_args]
    if (length(args) > 0)
      object$args[names(args)] <- args
    if (length(eng_args) > 0)
      object$eng_args[names(eng_args)] <- eng_args
  }

  parsnip::new_model_spec(
    "arima_svm_laplace",
    args     = object$args,
    eng_args = object$eng_args,
    mode     = object$mode,
    method   = NULL,
    engine   = object$engine
  )
}


#' @export
#' @importFrom parsnip translate
translate.arima_svm_laplace <- function(x, engine = x$engine, ...) {

  # slightly cleaner code using
  arg_vals <- x$method$fit$args
  arg_names <- names(arg_vals)


  if (is.null(engine)) {
    message("Used `engine = 'auto_arima_svm_laplace'` for translation.")
    engine <- "auto_arima_svm_laplace"
  }

  # convert sigma and scale to a `kpar` argument.
  if (any(arg_names == "sigma")) {
    kpar <- rlang::expr(list())
    kpar$sigma <- arg_vals$sigma
    arg_vals$sigma <- NULL
    arg_vals$kpar <- kpar
  }

  x <- parsnip::translate.default(x, engine, ...)

  x
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ FIT BRIDGES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@---------------------
# fitting bridges for two sets of arimas:
# SVM ARIMA      : arima_svm_laplace_fit_impl
# SVM AutoARIMA  : auto_arima_svm_laplace_fit_impl
# code above and below is based on
# initial implementations via Matt Dancho {modeltime} and Max Kuhn {parsnip}

# AutoARIMA with SVM Errors -------------------------------

#' @export
auto_arima_svm_laplace_fit_impl <- function(x, y, period = "auto",
                                        max.p = 5, max.d = 2, max.q = 5,
                                        max.P = 2, max.D = 1, max.Q = 2,

                                        max.order = 5, d = NA, D = NA,
                                        start.p = 2,
                                        start.q = 2,
                                        start.P = 1,
                                        start.Q = 1,
                                        stationary = FALSE,
                                        seasonal = TRUE,
                                        ic = c("aicc", "aic", "bic"),
                                        stepwise = TRUE,
                                        nmodels = 94,
                                        trace = FALSE,
                                        approximation = (length(x) > 150 | frequency(x) > 12),
                                        method = NULL,
                                        truncate = NULL,
                                        test = c("kpss", "adf", "pp"),
                                        test.args = list(),
                                        seasonal.test = c("seas", "ocsb", "hegy", "ch"),
                                        seasonal.test.args = list(),
                                        allowdrift = TRUE,
                                        allowmean = TRUE,
                                        lambda = NULL,
                                        biasadj = FALSE,

                                        # SVM params
                                        cost           = 10,
                                        margin         = .1,
                                        laplace_sigma  = .5,
                                        ...) {

  # X & Y
  # Expect outcomes  = vector
  # Expect predictor = data.frame
  outcome    <- y
  predictor  <- x

  # INDEX & PERIOD
  # Determine Period, Index Col, and Index
  index_tbl <- modeltime::parse_index_from_data(predictor)
  period    <- modeltime::parse_period_from_index(index_tbl, period)
  idx_col   <- names(index_tbl)
  idx       <- timetk::tk_index(index_tbl)

  # XREGS
  # Clean names, get xreg recipe, process predictors
  xreg_recipe <- modeltime::create_xreg_recipe(predictor, prepare = TRUE, one_hot = FALSE)
  xreg_tbl    <- modeltime::juice_xreg_recipe(xreg_recipe, format = "tbl")

  # FIT
  outcome <- stats::ts(outcome, frequency = period)

  # auto.arima
  fit_arima   <- forecast::auto.arima(outcome,
                                      max.p = max.p, max.d = max.d, max.q = max.q,
                                      max.P = max.P, max.D = max.D, max.Q = max.Q,
                                      max.order = max.order, d = d, D = D,
                                      start.p = start.p, start.q = start.q,
                                      start.P = start.P, start.Q = start.Q,
                                      stationary = stationary, seasonal = seasonal,
                                      ic = ic, stepwise = stepwise,
                                      nmodels = nmodels, trace = trace,
                                      approximation = approximation,
                                      method = method, truncate = truncate,
                                      test = test, test.args = test.args,
                                      seasonal.test = seasonal.test, seasonal.test.args = seasonal.test.args,
                                      allowdrift = allowdrift, allowmean = allowmean,
                                      lambda = lambda, biasadj = biasadj
  )

  arima_residuals <- as.numeric(fit_arima$residuals)
  arima_fitted    <- as.numeric(fit_arima$fitted)

  # SVM
  if (!is.null(xreg_tbl)) {
    fitsvm_tbl <- xreg_tbl |>
      dplyr::mutate(
        arima_residuals = arima_residuals
      )

    fit_svm <-
    svm_laplace(cost = cost, margin = margin, laplace_sigma = laplace_sigma, ...) |>
    set_mode("regression") |>
    set_engine("kernlab") |>
    fit(arima_residuals ~ ., data = fitsvm_tbl)

    svm_fitted    <- predict(fit_svm, new_data = xreg_tbl)
  } else {
    fit_svm       <- NULL
    svm_fitted    <- rep(0, length(arima_residuals))
  }

  # RETURN A NEW MODELTIME BRIDGE

  # Class - Add a class for the model
  class <- "auto_arima_svm_laplace_fit_impl"

  # Models - Insert model_1 and model_2 into a list
  models <- list(
    model_1 = fit_arima,
    model_2 = fit_svm
  )

  # Data - Start with index tbl and add .actual, .fitted, and .residuals columns
  data <- index_tbl |>
    dplyr::mutate(
      .actual    =  y,
      .fitted    =  arima_fitted + svm_fitted,
      .residuals = .actual - .fitted
    )

  # Extras - Pass on transformation recipe
  extras <- list(
    xreg_recipe = xreg_recipe
  )

  # Model Description - Gets printed to describe the high-level model structure
  desc <- paste0(get_arima_description(fit_arima),
                 ifelse(is.null(fit_svm), "", " w/ SVM Errors"))

  # Create new model
  new_modeltime_bridge(
    class  = class,
    models = models,
    data   = data,
    extras = extras,
    desc   = desc
  )
}


#' @export
print.auto_arima_svm_laplace_fit_impl <- function(x, ...) {

  if (!is.null(x$desc)) cat(paste0(x$desc,"\n"))
  cat("---\n")
  cat("Model 1: Auto ARIMA\n")
  print(x$models$model_1)
  cat("\n---\n")
  cat("Model 2: SVM Errors\n\n")
  print(x$models$model_2)
  invisible(x)
}


# Standard ARIMA with SVM Errors -------------------------------

#' @export
arima_svm_laplace_fit_impl <- function(x, y, period = "auto",
                                   p = 0, d = 0, q = 0,
                                   P = 0, D = 0, Q = 0,
                                   include.mean = TRUE,
                                   include.drift = FALSE,
                                   include.constant,
                                   lambda = model$lambda,
                                   biasadj = FALSE,
                                   method = c("CSS-ML", "ML", "CSS"),
                                   model = NULL,

                                   # svm params
                                   cost = 10,
                                   margin = 1,
                                   laplace_sigma = .5,
                                   ...) {

  # X & Y
  # Expect outcomes  = vector
  # Expect predictor = data.frame
  outcome    <- y
  predictor  <- x

  # INDEX & PERIOD
  # Determine Period, Index Col, and Index
  index_tbl <- parse_index_from_data(predictor)
  period    <- parse_period_from_index(index_tbl, period)
  idx_col   <- names(index_tbl)
  idx       <- timetk::tk_index(index_tbl)

  # XREGS
  # Clean names, get xreg recipe, process predictors
  xreg_recipe <- create_xreg_recipe(predictor, prepare = TRUE)
  xreg_tbl    <- juice_xreg_recipe(xreg_recipe, format = "tbl")

  # FIT
  outcome <- stats::ts(outcome, frequency = period)

  # auto.arima
  fit_arima   <- forecast::Arima(outcome,
                                 order = c(p, d, q),
                                 seasonal = c(P, D, Q),
                                 include.mean = include.mean,
                                 include.drift = include.drift,
                                 include.constant = include.constant,
                                 lambda = model$lambda,
                                 biasadj = biasadj,
                                 method = method,
                                 model = model
  )

  arima_residuals <- as.numeric(fit_arima$residuals)
  arima_fitted    <- as.numeric(fit_arima$fitted)

  # svm
  if (!is.null(xreg_tbl)) {
    fitsvm_tbl <- xreg_tbl |>
      dplyr::mutate(
        arima_residuals = arima_residuals
      )

    fit_svm <-
      svm_laplace(cost = cost, margin = margin, laplace_sigma = laplace_sigma, ...) |>
      set_mode("regression") |>
      set_engine("kernlab") |>
      fit(arima_residuals ~ ., data = fitsvm_tbl)

    svm_fitted    <- predict(fit_svm, new_data = xreg_tbl)
  } else {
    fit_svm       <- NULL
    svm_fitted    <- rep(0, length(arima_residuals))
  }

  # RETURN A NEW MODELTIME BRIDGE

  # Class - Add a class for the model
  class <- "arima_svm_laplace_fit_impl"

  # Models - Insert model_1 and model_2 into a list
  models <- list(
    model_1 = fit_arima,
    model_2 = fit_svm
  )

  # Data - Start with index tbl and add .actual, .fitted, and .residuals columns
  data <- index_tbl |>
    dplyr::mutate(
      .actual    =  y,
      .fitted    =  arima_fitted + svm_fitted,
      .residuals = .actual - .fitted
    )

  # Extras - Pass on transformation recipe
  extras <- list(
    xreg_recipe = xreg_recipe
  )

  # Model Description - Gets printed to describe the high-level model structure
  desc <- paste0(get_arima_description(fit_arima),
                 ifelse(is.null(fit_svm), "", " w/ SVM Errors"))

  # Create new model
  new_modeltime_bridge(
    class  = class,
    models = models,
    data   = data,
    extras = extras,
    desc   = desc
  )

}

#' @export
print.arima_svm_laplace_fit_impl <- function(x, ...) {

  if (!is.null(x$desc)) cat(paste0(x$desc,"\n"))
  cat("---\n")
  cat("Model 1: Standard ARIMA\n")
  print(x$models$model_1)
  cat("\n---\n")
  cat("Model 2: SVM Errors\n\n")
  print(x$models$model_2)
  invisible(x)
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ PREDICTION BRIDGES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-----------------

#' @export
predict.auto_arima_svm_laplace_fit_impl <- function(object, new_data, ...) {
  arima_svm_predict_impl(object, new_data, ...)
}

#' @export
predict.arima_svm_laplace_fit_impl <- function(object, new_data, ...) {
  arima_svm_predict_impl(object, new_data, ...)
}

#' @export
arima_svm_predict_impl <- function(object, new_data, ...) {

  # PREPARE INPUTS
  arima_model   <- object$models$model_1
  svm_model     <- object$models$model_2
  idx_train     <- object$data |> timetk::tk_index()
  xreg_recipe   <- object$extras$xreg_recipe
  h_horizon     <- nrow(new_data)

  # XREG
  xreg_tbl    <- modeltime::bake_xreg_recipe(xreg_recipe, new_data, format = "tbl")

  # PREDICTIONS

  # arima, forecast::simulate() would be a neat feature
  preds_arima <- forecast::forecast(arima_model, h = h_horizon) |>
    tibble::as_tibble() |>
    purrr::pluck(1) |>
    as.numeric()

  # svm
  if (!is.null(xreg_tbl)) {
    preds_svm <- predict(svm_model, new_data = xreg_tbl, ...)
  } else {
    preds_svm <- rep(0, h_horizon)
  }

  # Return predictions as numeric vector
  preds <- preds_arima + preds_svm

  return(preds)

}
