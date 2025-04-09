#' Multiple Instance SVMs for Ordinal Outcome Data, One-Vs-All, with Radial Basis Function Kernel
#' @param mode classification
#' @param engine `mildsvm::misvm_orova()` which uses e1701's svm
#' @param cost A positive number for the cost of predicting a sample within
#'  or on the wrong side of the margin
#' @param rbf_sigma A positive number for radial basis function.
#' @export

misvm_orova_rbf <-
  function(mode = "unknown", engine = "ebmc",
           cost = NULL, rbf_sigma = NULL) {

    args <- list(
      cost       = enquo(cost),
      rbf_sigma  = enquo(rbf_sigma)
    )

    parsnip::new_model_spec(
      "misvm_orova_rbf",
      args = args,
      eng_args = NULL,
      mode = mode,
      user_specified_mode = !missing(mode),
      method = NULL,
      engine = engine,
      user_specified_engine = !missing(engine)
    )
  }

# ------------------------------------------------------------------------------

#' @method update misvm_orova_rbf
#' @rdname parsnip_update
#' @export
update.misvm_orova_rbf <-
  function(object,
           parameters = NULL,
           cost = NULL, rbf_sigma = NULL,
           fresh = FALSE,
           ...) {

    args <- list(
      cost      = enquo(cost),
      rbf_sigma = enquo(rbf_sigma)
    )

    parsnip::update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "misvm_orova_rbf",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
translate.misvm_orova_rbf <- function(x, engine = x$engine, ...) {
  x <- parsnip::translate.default(x, engine = engine, ...)

  # slightly cleaner code using
  arg_vals <- x$method$fit$args
  arg_names <- names(arg_vals)

  # # add checks to error trap or change things for this method
  # if (x$engine == "kernlab") {
  #
  #   # unless otherwise specified, classification models predict probabilities
  #   if (x$mode == "classification" && !any(arg_names == "prob.model"))
  #     arg_vals$prob.model <- TRUE
  #   if (x$mode == "classification" && any(arg_names == "epsilon"))
  #     arg_vals$epsilon <- NULL
  #
  # }

  x$method$fit$args <- arg_vals

  # worried about people using this to modify the specification
  x
}

# ------------------------------------------------------------------------------

#' @export
check_args.misvm_orova_rbf <- function(object, call = rlang::caller_env()) {
  invisible(object)
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# misvm_orova helpers --------------------------------------------------------------
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# mildsvm requires mi() or mild() wrappers in the formula and
# specials: bag_name, bag_label, and instance_name.
# Out of misvm, mismm, and misvm_orova,
# misvm_orova is the simplest to port and
# most flexible engine given ordinal outcomes.
# for the parsnip binding, it should feel like a normal classification engine.
# misvm_orova handles df class and setting levels internally for bag name and label.
# the others engines in mildsvm (misvm, mismm) are binary classifiers,
# other multiclass support requires "gurobi"'s MIQP solver. gurobi is NOT open source.
# gurobi dependent engines will not be ported to {maize}.
# but misvm_or*ova* engine supports "one-vs-all" multiclass outcome data with heuristics.
# below is a simple wrapper for misvm_orova for
# formula method handling the mi() specials for the user.
# TODO user specified mi() for bag name vs bag label and instance_name for mild() forms

#' @keywords internal
#' @param formula A formula
#' @param data A data.frame
#' @export
#' @rdname misvm_orova_rbf_helpers
misvm_orova_fit_spec <- \(formula, data, cost = NULL, sigma = NULL){

  # target from formula used as bag label and name
  tar <- all.vars(formula[[2]])

  # preds from formula
  preds <- all.vars(formula[[3]])

  # generalized mi formula
  mi_fx <- as.formula(paste("mildsvm::mi(", tar, ",", tar, ") ~", preds))

  # model fit
  model <- mildsvm::misvm_orova(mi_fx,
                                data    = data,
                                cost    = cost,
                                method  = "heuristic",
                                control = list(kernel = "radial",
                                               sigma  = sigma),
                                weights = NULL)

  return(model)
}

#' @keywords internal
#' @param object A model object
#' @param new_data A data.frame
#' @param type raw or class
#' @param ... ellipsis
#' @export
#' @rdname misvm_orova_rbf_helpers
misvm_predict_spec <- function(object, new_data, type, ...) {

  # odd behavior when truth col is missing,
  # need to predict for every row (?)
  preds <- data.frame()
  for (i in 1:nrow(new_data)){

    ipred <- mildsvm:::predict.misvm_orova(object   = object,
                                           new_data = new_data[i, ],
                                           type     = type,
                                           ...      = ...)
    preds <- rbind(preds, ipred)
  }
  return(preds)
}
