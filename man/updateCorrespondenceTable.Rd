\name{updateCorrespondenceTable}
\alias{updateCorrespondenceTable}
\title{Update the correspondence table between statistical classifications A and B when A has been updated to version A*.}
\usage{
updateCorrespondenceTable(A, B, AStar, AB, AAStar, CSVout = NULL, Reference = "none",
MismatchToleranceB = 0.2, MismatchToleranceAStar = 0.2)
}
\description{
Update the correspondence table between statistical classifications A and B when A has been updated to version A*.
}
\arguments{
\item{A}{A string of the type \code{character} containing the name of a csv file that contains the original classification A.}
\item{B}{A string of the type \code{character} containing the name of a csv file that contains classification B.}
\item{AStar}{A string of the type \code{character} containing the name of a csv file that contains the updated version A*.}
\item{AB}{A string of the type \code{character} containing the name of a csv file that contains the previous correspondence table A:B.}
\item{AAStar}{A string of the type character containing the name of a csv file that contains the \emph{concordance table} A:A*, which contains the mapping between the codes of the two versions of the classification.}
\item{CSVout}{The preferred name for the \emph{output csv files} that will contain the updated correspondence table and information about the classifications involved. The valid values are \code{NULL} or strings of type \code{character}. If the selected value is \code{NULL}, the default, no output file is produced. If the value is a string, then the output is exported into two csv files whose names contain the provided name (see "Value" below).}
\item{Reference}{The reference classification among A and B. If a classification is the reference to the other, and hence \emph{hierarchically superior} to it, each code of the other classification is expected to be mapped to at most one code of the reference classification. The valid values are \code{"none"}, \code{"A"}, and \code{"B"}. If the selected value is \code{"A"} or \code{"B"}, a "Review" flag column is included in the output (see "Explanation of the flags" below).}
\item{MismatchToleranceB}{The maximum acceptable proportion of rows in the updated correspondence table which contain no code of the target classification B, among those which contain a code of A, of A*, or of both. The default value is \code{0.2}. The valid values are real numbers in the interval [0, 1].}
\item{MismatchToleranceAStar}{The maximum acceptable proportion of rows in the updated correspondence table which contain no code of the updated classification A*, among those which contain a code of A, of B, or of both. The default value is \code{0.2}. The valid values are real numbers in the interval [0, 1].}
}


\details{
Package requirements:
\itemize{
\item NOTE: Please note that the \code{readr} package must be installed before using \code{correspondenceTables}.
}

File and file name requirements:
\itemize{
\item The files that correspond to arguments \code{A},  \code{B}, \code{AStar}, \code{AB}, \code{AAStar} must be in \emph{csv format with comma as delimiter}. If full paths are not provided, then these files must be available in the working directory. No two filenames provided must be identical.

\item If any of the two files where the output will be stored is read protected (for instance because it is open elsewhere) an error message will be reported and execution will be halted.
}

Classification table requirements:
\itemize{
\item The files that correspond to arguments \code{A},  \code{B} and \code{AStar} must contain at least one column and at least two rows. The first column contains the codes of the respective classification. The first row contains column headers. The name of the first column is the name of the respective classification (e.g., "CN 2021").

\item The classification codes contained in a classification file (expected in its first column as mentioned above) must be unique. No two identical codes are allowed in the column.

\item If any of the files that correspond to arguments \code{A},  \code{B} and \code{AStar} has additional columns the first one of them is considered as containing the labels of the respective classification codes.
}

Correspondence and concordance table requirements:
\itemize{
\item The files that correspond to arguments \code{AB} and \code{AAStar} must contain at least two columns and at least two rows. The first column of the file that corresponds to \code{AB} contains the codes of classification A. The second column contains the codes of classification B. Similar requirements apply to the file that corresponds to \code{AAStar}. The first row of each of these files contains column headers. The names of the first two columns are the names of the respective classifications.

\item The pairs of classification codes contained in the concordance and the correspondence table files (expected in their first two columns as mentioned above) must be unique. No two identical pairs of codes are allowed in the first two columns.
}

Interdependency requirements:
\itemize{
\item At least one code of classification A must appear in both the file of concordance table A:A* and the file of correspondence table A:B.

\item	At least one code of classification A* must appear in both the file of classification A* and the file of concordance table A:A*.

\item	At least one code of classification B must appear in both the file of classification B and the file of correspondence table A:B.
}

Mismatch tolerance:
\itemize{
\item The ratio that is compared with \code{MismatchToleranceB} has as numerator the number of rows of the updated correspondence table which contain a code for A, for A*, or for both, but no code for B and as denominator the number of rows which contain a code for A, for A*, or for both (regardless of whether there is a code for B or not). If the ratio exceeds \code{MismatchToleranceB} the execution of the function is halted.

\item The ratio that is compared with \code{MismatchToleranceAStar} has as numerator the number of rows of the updated correspondence table which contain a code for A, for B, or for both, but no code for A* and as denominator the number of rows which contain a code for A, for B*, or for both (regardless of whether there is a code for A* or not). If the ratio exceeds \code{MismatchToleranceAStar} the execution of the function is halted.
}

If any of the conditions required from the arguments is violated an error message is produced and execution is stopped.
}

\value{

\code{updateCorrespondenceTable()} returns a list with two elements, both of which are data frames.

\itemize{
\item The first element is the updated correspondence table A*:B augmented with flags "CodeChange", "Review" (if applicable), "Redundancy", "NoMatchToAStar", "NoMatchToB", "NoMatchFromAStar", "NoMatchFromB", "LabelChange", and with all the additional columns of the \code{A},  \code{B}, \code{AStar}, \code{AB} and \code{AAStar} files.

\item The second element contains the names of the original classification A, the target classification B, and the updated version A*, as read from the top left-hand side cell of the respective input files.

\item If the value of argument \code{CSVout} is a string of type \code{character}, the elements of the list are exported into files of csv format. The name of the file for the first element is the value of argument \code{CSVout} and the name of the file for the second element is classificationNames_\code{CSVout}. For example, if \code{CSVout} = "updateCorrespondenceTable.csv", the elements of the list are exported into "updateCorrespondenceTable.csv" and "classificationNames_updateCorrespondenceTable.csv", respectively.

}
}

\section{Explanation of the flags}{
\itemize{
\item For each row of the updated correspondence table, the value of "CodeChange" is equal to \code{1} if the code of A contained in this row maps -in this or any other row of the table- to a different code of A*, and \code{0} otherwise. The value of "CodeChange" is empty if either the code of A, or the code of A*, or both are missing.

\item The "Review" flag is produced only if argument \code{Reference} has been set equal to "\code{A}" or "\code{B}". For each row of the updated correspondence table, if \code{Reference} = "\code{A}" the value of "Review" is equal to \code{1} if the code of B maps to more than one code of A*, and \code{0} otherwise. If \code{Reference} = "\code{B}" the value of "Review" is equal to \code{1} if the code of A* maps to more than one code of B, and \code{0} otherwise. The value of the flag is empty if either the code of A*, or the code of B, or both are missing.

\item For each row of the updated correspondence table, the value of "Redundancy" is equal to \code{1} if the row contains a combination of codes of A* and B that also appears in at least one other row of the updated correspondence table. The value of the flag is empty if both the code of A* and the code of B are missing.

\item For each row of the updated correspondence table, the value of "NoMatchToAStar" is equal to \code{1} if there is a code for A,  for B, or for both, but no code for A*. The value of the flag is \code{0} if there are codes for both A and A* (regardless of whether there is a code for B or not). Finally, the value of "NoMatchToAStar" is empty if neither A nor B have a code in this row.

\item For each row of the updated correspondence table, the value of "NoMatchToB" is equal to \code{1} if there is a code for A,  for A*, or for both, but no code for B. The value of the flag is \code{0} if there are codes for both A and B (regardless of whether there is a code for A* or not). Finally, the value of "NoMatchToB" is empty if neither A nor A* have a code in this row.

\item For each row of the updated correspondence table, the value of "NoMatchFromAStar" is equal to \code{1} if the row contains a code of A* that appears in the table of classification A* but not in the concordance table A:A*. The value of the flag is \code{0} if the row contains a code of A* that appears in both the table of classification A* and the concordance table A:A*. Finally, the value of the flag is empty if the row contains no code of A* or if it contains a code of A* that appears in the concordance table A:A* but not in the table of classification A*.

\item For each row of the updated correspondence table, the value of "NoMatchFromB" is equal to \code{1} if the row contains a code of B that appears in the table of classification B but not in the correspondence table A:B. The value of the flag is \code{0} if the row contains a code of B that appears in both the table of classification B and the correspondence table A:B. Finally, the value of the flag is empty if the row contains no code of B or if it contains a code of B that appears in the correspondence table A:B but not in the table of classification B.

\item For each row of the updated correspondence table, the value of "LabelChange" is equal to \code{1} if the labels of the codes of A and A* are different, and \code{0} if they are the same. Finally, the value of "LabelChange" is empty if either of the labels, or both labels, are missing. Lower and upper case are considered the same, and punctuation characters are ignored when comparing code labels.
}}

\section{Sample datasets included in the package}{

Running \code{browseVignettes("correspondenceTables")} in the console opens an html page in the user's default browser. Selecting HTML from the menu, users can read information about the use of the sample datasets that are included in the package.

If they wish to access the csv files with the sample data, users have two options:

\itemize{
\item Option 1: Unpack into any folder of their choice the tar.gz file into which the package has arrived. All sample datasets may be found in the "inst/extdata" subfolder of this folder.

\item Option 2: Go to the "extdata" subfolder of the folder in which the package has been installed in their PC's \code{R} library. All sample datasets may be found there.
 }}

\examples{
\dontrun{

## Application of function updateCorrespondenceTable() with CN 2021 being the
## original classification A, CPA 2.1 being the target classification B, CN 2022
## being the updated version A*, CN 2021:CPA 2.1 being the previous correspondence
## table A:B, and CN 2021:CN 2022 being the A:A* concordance table. The desired
## name for the csv file that will contain the updated correspondence table is
## "updateCorrespondenceTable.csv", the reference classification is B, and the
## maximum acceptable proportions of unmatched codes between the original
## classification A and the target classification B, and between the original
## classification A and the updated classification A* are 0.4 and 0.4, respectively.

## UPC <- updateCorrespondenceTable("CN2021.csv", "CPA21.csv", "CN2022.csv", "CN2021_CPA21.csv",
##                             "CN2021_CN2022.csv", "updateCorrespondenceTable.csv", "B", 0.4, 0.4)
}
}