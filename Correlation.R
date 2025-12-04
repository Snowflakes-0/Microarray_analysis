# --- 3. Correlation Analysis with GeneX (GOI) ---

# Ensure necessary libraries are loaded
if (!require(dplyr)) install.packages("dplyr")
library(dplyr)

# Set your Gene of Interest (GOI) variable (change "GeneX" to your actual column name)
GOI <- "AT3G63150"  # Replace with your actual GOI gene name

# Ensure the GOI is present in the dataset (genes are in rows)
if (!(GOI %in% rownames(data_clean))) {
  stop("GOI gene not found in dataset.")
}

# Transpose the data (genes in rows, samples in columns)
data_transposed <- t(data_clean)

# Compute the correlation matrix using Pearson correlation (for samples)
cor_matrix <- cor(data_transposed, use = "complete.obs", method = "pearson")

# Extract correlations with GOI (GeneX) from the matrix
GOI_Corr <- cor_matrix[, GOI]

# Filter correlations based on a threshold (e.g., > 0.8)
threshold <- 0.8  # Set the desired threshold for correlation
GOI_Corr_filtered <- GOI_Corr[abs(GOI_Corr) > threshold]

# Sort the filtered correlations in descending order
GOI_Corr_filtered_sorted <- sort(GOI_Corr_filtered, decreasing = TRUE)

# Display the filtered and sorted correlations
cat("Top Correlated Genes with", GOI, ":\n")
print(GOI_Corr_filtered_sorted)


# Ask if the user wants to save the results as a CSV file
save_results <- readline(prompt = "Do you want to save the results as a .csv file? (yes/no): ")

if (tolower(save_results) == "yes") {
  write.csv(GOI_Corr_filtered_sorted, file = "GOI_Correlation_Results.csv")
  cat("Results saved to 'GOI_Correlation_Results.csv'.\n")
} else {
  cat("Results not saved.\n")
}
