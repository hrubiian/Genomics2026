# One-step publishing helper for RStudio.
#
#   source("publish.R")      # once per session (or add it to .Rprofile)
#   publish()                # render + commit + push
#   publish("week 2 update") # with your own commit message
#
# Equivalent to running ./publish.sh from RStudio's Terminal tab.

publish <- function(message = "Update site") {
  # Walk up from the working directory until _quarto.yml turns up.
  project <- normalizePath(getwd())
  repeat {
    if (file.exists(file.path(project, "_quarto.yml"))) break
    parent <- dirname(project)
    if (identical(parent, project)) {
      stop("Could not find _quarto.yml - open the Genomics project first.", call. = FALSE)
    }
    project <- parent
  }

  script <- file.path(project, "publish.sh")
  if (!file.exists(script)) {
    stop("publish.sh not found in ", project, call. = FALSE)
  }

  status <- system2("bash", c(shQuote(script), shQuote(message)))
  if (status != 0) {
    stop("Publishing failed - see the output above.", call. = FALSE)
  }
  invisible(TRUE)
}
