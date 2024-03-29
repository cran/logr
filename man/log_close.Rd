% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logr.R
\name{log_close}
\alias{log_close}
\title{Close the log}
\usage{
log_close()
}
\value{
None
}
\description{
The \code{log_close} function closes the log file.
}
\details{
The \code{log_close} function terminates logging. The function also prints
the log footer.  The log footer contains a
date-time stamp of when the log was closed.
}
\examples{
# Create temp file location
tmp <- file.path(tempdir(), "test.log")

# Open log
lf <- log_open(tmp)

# Send message to log
log_print("High Mileage Cars Subset")

# Perform operations
hmc <- subset(mtcars, mtcars$mpg > 20)

# Print data to log
log_print(hmc)

# Close log
log_close()

# View results
writeLines(readLines(lf))
}
\seealso{
\code{\link{log_open}} to open the log, and \code{\link{log_print}}
for printing to the log.
}
