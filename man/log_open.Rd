% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logr.R
\name{log_open}
\alias{log_open}
\title{Open a log}
\usage{
log_open(
  file_name = "",
  logdir = TRUE,
  show_notes = TRUE,
  autolog = NULL,
  compact = FALSE,
  traceback = TRUE,
  header = TRUE,
  stdout = FALSE,
  line_size = 80
)
}
\arguments{
\item{file_name}{The name of the log file.  If no path is specified, the
working directory will be used.  As of v1.2.7, the name and path of the
program or script will be used as a default if the \code{file_name} parameter
is not supplied.}

\item{logdir}{Send the log to a log directory.  If the log
directory does not exist, the function will create it.  Valid values are
TRUE, FALSE, or a quoted directory name. The default is TRUE.  The default
log directory is named "log".}

\item{show_notes}{If true, will write notes to the log.  Valid values are
TRUE and FALSE. Default is TRUE.}

\item{autolog}{Whether to turn on autolog functionality.  Autolog
automatically logs functions from the dplyr, tidyr, and sassy family of
packages. To enable autolog, either set this parameter to TRUE or
set the "logr.autolog" option to TRUE. A FALSE value on this parameter
will override the global option.  The global option
will override a NULL on this parameter. Default is that autolog is
disabled.}

\item{compact}{When the compact option is TRUE, \strong{logr} will
minimize the number of blank spaces in the log.  This option generates
the same logging information, but in less space. The "logr.compact" global
option does the same thing.}

\item{traceback}{By default, if there is an error in the program
being logged, \strong{logr} will print a traceback of the error. You may
turn this feature off by setting the \code{traceback} parameter to FALSE.}

\item{header}{Whether or not to print the log header.  Value values
are TRUE and FALSE.  Default is TRUE.}

\item{stdout}{If TRUE, the log will print to stdout instead of a file.
Default is FALSE, which means the log will normally print to a file.
This behavior can also be set with the global option
\code{globals("logr.stdout" = TRUE)}.}

\item{line_size}{The maximum character width for a line in the log. If the
line exceeds the maximum width, the line will be broken and wrapped to the
next line.  Default is 80 characters.}
}
\value{
The path of the log.
}
\description{
A function to initialize the log file.
}
\details{
The \code{log_open} function initializes and opens the log file.
This function must be called first, before any logging can occur.
The function determines the log path, attaches event handlers,
clears existing log files, and initiates a new log.

The \code{file_name} parameter may be a full path, a relative path, or
a file name.  An relative path or file name will be assumed to be relative
to the current working directory.  If the \code{file_name} does
not have a '.log' extension, the \code{log_open} function will add it.

As of v1.2.7, if the \code{file_name} parameter is not supplied,
the function will use the program/script name as the default
log file name, and the program/script path as the default path.

If requested in the \code{logdir} parameter, the \code{log_open}
function will write to a subdirectory of the path specified in the
\code{file_name}.  If the subdirectory does not exist,
the function will create it.  By default, the subdirectory is named "log".
If you want to name it something else, pass the desired name
as a quoted string on the \code{logdir} parameter.  If you don't want
to send the log to a subdirectory, set \code{logdir} to FALSE.

The log file will be initialized with a header that shows the log file name,
the current working directory, the current user, and a timestamp of
when the \code{log_open} function was called.

All errors, the last warning, and any \code{log_print} output will be
written to the log.  The log file will exist in the location specified in the
file_name parameter, and will normally have a '.log' extension.

If errors or warnings are generated, a second file will
be written that contains only error and warning messages.  This second file
will have a '.msg' extension and will exist in the specified log directory.
If the log is clean, the msg file will not be created.
The purpose of the msg file is to give the user a visual indicator from
the file system that an error or warning occurred.  This indicator
msg file is useful when running programs in batch.

To use \strong{logr}, call \code{log_open}, and then make calls to
\code{log_print} as needed to print variables or data frames to the log.
The \code{log_print} function can be used in place of a standard
\code{print} function.  Anything printed with \code{log_print} will
be printed to the log, and to the console if working interactively.

This package provides the functionality of \code{sink}, but in much more
user-friendly way.  Recommended usage is to call \code{log_open} at the top
of the script, call \code{log_print} as needed to log interim state,
and call \code{log_close} at the bottom of the script.

Logging may be controlled globally using the "logr.on" option.  This option
accepts a TRUE or FALSE value. If the option is set to FALSE, \strong{logr}
will print to the console, but not to the log.
Example: \code{options("logr.on" = TRUE)}

Notes may be controlled globally using the "logr.notes" option.  This option
also accepts a TRUE or FALSE value, and determines whether or not to print
notes in the log.  The global option will override the \code{show_notes}
parameter on the \code{log_open} function.
Example: \code{options("logr.notes" = FALSE)}

Version v1.2.0 of the \strong{logr} package introduced \strong{autolog}.
The autolog feature provides automatic logging for \strong{dplyr},
\strong{tidyr}, and the \strong{sassy} family of packages.  To use autolog,
set the \code{autolog} parameter to TRUE, or set the global option
\code{logr.autolog} to TRUE.  To maintain backward compatibility with
prior versions, autolog is disabled by default.

The "compact" parameter will remove all the blank lines between log
entries.  The downside of a compact log is that it makes the log
harder to read.  The benefit is
that it will take up less space.  The global option "logr.compact" will
achieve the same result.

If an error is encountered, a traceback of the error message is printed
to the log and message files by default. This traceback helps in finding
the source of the error, particularly in situations where you have deeply
nested functions. If you wish to turn the traceback off, set
the \code{traceback} parameter of the \code{log_open} function to FALSE.
You may also use the global option \code{logr.traceback} to control printing
of this information.
}
\examples{
library(logr)

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
\code{\link{log_print}} for printing to the log (and console),
and \code{\link{log_close}} to close the log.
}
