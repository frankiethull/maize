# ---------------------- Notes ------------------------------------------
# @@@@@@@@@@@@@ one-svc novelty detection from kernlab @@@@@@@@@@@@@@@@@@@
# based entirely from tidymodels/applicable for isolation anomaly detection
# repurposed for svm novelty detection
# https://github.com/tidymodels/applicable/blob/develop/R/isolation-score.R
# -----------------------------------------------------------------------

# -----------------------------------------------------------------------------
# ---------------------- Model function implementation ------------------------
# -----------------------------------------------------------------------------

score_apd_svm_novel_detection <- function(model, predictors) {
  check_kernlab()
  predicted_output <- kernlab::predict(model$model, data.matrix(predictors), type = "decision")
  predicted_output <- tibble::tibble(score = predicted_output[, 1])

  # Compute percentile of new SVM scores
  new_pctls <- applicable:::get_new_percentile(
    model$pctls$score,
    predicted_output$score,
    grid = model$pctls$percentile
  )
  predicted_output$score_pctl <- new_pctls
  predicted_output
}

# -----------------------------------------------------------------------------
# ------------------------ Model function bridge ------------------------------
# -----------------------------------------------------------------------------

score_apd_svm_novel_detection_bridge <- function(type, model, predictors) {

  predictions <- score_apd_svm_novel_detection(model, predictors)

  hardhat::validate_prediction_size(predictions, predictors)

  predictions
}

# -----------------------------------------------------------------------------
# ----------------------- Model function interface ----------------------------
# -----------------------------------------------------------------------------

#' Predict from a `apd_svm_novel_detection`
#'
#' @param object A `apd_svm_novel_detection` object.
#'
#' @param new_data A data frame or matrix of new samples.
#'
#' @param type A single character. The type of predictions to generate.
#' Valid options are:
#'
#' - `"numeric"` for numeric predictions.
#'
#' @param ... Not used, but required for extensibility.
#'
#' @details About the score
#'
#' @return
#'
#' A tibble of predictions. The number of rows in the tibble is guaranteed
#' to be the same as the number of rows in `new_data`. The `score` column is the
#' raw prediction from [kernlab::predict()] while `score_pctl`
#' compares this value to the reference distribution of the score created by
#' predicting the training set. A value of _X_ means that _X_ percent of the
#' training data have scores less than the predicted value.
#'
#' @seealso [apd_svm_novel_detection()]
#' @export
score.apd_svm_novel_detection <- function(object, new_data, type = "numeric", ...) {
  forged <- hardhat::forge(new_data, object$blueprint)
  rlang::arg_match(type, valid_novel_predict_types())
  score_apd_svm_novel_detection_bridge(type, object, forged$predictors)
}
# -----------------------------------------------------------------------------
# ----------------------- Helper functions ------------------------------------
# -----------------------------------------------------------------------------

valid_novel_predict_types <- function() {
  c("numeric")
}
