# --- Data Cleanup ---

# Check for missing values
sum(is.na(data))


library(dplyr)

# Remove the column by its number, in case it is NA 
#data_clean <- data %>% select(-1)

# Option 1: Remove rows with any NA values
data_clean <- na.omit(data)

# Option 2: (Optional) Replace NA with 0 or a specific value
#data_clean <- data
#data_clean[is.na(data_clean)] <- 0

# (Optional) Clean column names
if (!require(janitor)) install.packages("janitor")
library(janitor)

# Ask user if they want to change column names
change_colnames <- readline(prompt = "Do you want to change column names? (yes/no): ")

if (tolower(change_colnames) == "yes") {
  # Get new column names from user
  cat("Enter new column names separated by commas (e.g., col1, col2, col3):\n")
  new_colnames <- readline()
  
  # Split and assign new column names
  new_colnames <- unlist(strsplit(new_colnames, ","))
  colnames(data_clean) <- new_colnames
  
  cat("Column names have been updated!\n")
} else {
  # Clean column names if not changed
  data_clean <- clean_names(data_clean) # makes column names consistent: lower_case_with_underscores
}

# Convert tibble to traditional data frame (to allow setting row names)
data_clean <- as.data.frame(data_clean)

# Set the first column as row names
first_column <- data_clean[, 1]

# Check if first column has NA values or duplicates
if (any(is.na(first_column)) | any(duplicated(first_column))) {
  stop("First column has NA values or duplicates. Please clean the first column.")
}

# Set the first column as row names and remove it from the data
rownames(data_clean) <- first_column
data_clean <- data_clean[, -1]  # Remove the first column as it's now the row names

# Convert all character columns to factors (optional)
data_clean <- data_clean %>% 
  mutate(across(where(is.character), as.factor))

# Quick overview after cleaning
head(data_clean)