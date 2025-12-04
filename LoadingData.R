# --- Load Data ---
# Install packages if not already installed
if (!require(readr)) install.packages("readr")
library(readr)

# Loading Data
file_path <- file.choose()

# Understand extension
file_extension <- tools::file_ext(file_path)

# Ask if you want to skip lines
skip_lines <- as.integer(readline(prompt = "Do you want to skip any lines before the data? If yes, specify the number of lines to skip (otherwise, enter 0): "))

# Load based on file type
if (file_extension %in% c("csv", "CSV")) {
  data <- read.csv(file_path)
} else if (file_extension %in% c("txt", "TXT", "csl", "CSL", "tsv", "TSV")) {
  data <-
    read_delim(file_path, delim = "\t", skip = skip_lines)

} else {
  stop("Unsupported file format. Please use CSV, CSL, TXT, or TSV.")
}

# View the first few rows of the data
head(data)