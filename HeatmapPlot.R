# --- 4. Clustered Heatmap of Expression Values for GOI and GOI_Corr ---

# Ensure necessary libraries are installed and loaded
if (!require(pheatmap)) install.packages("pheatmap")
library(pheatmap)

# Get the top correlated genes with GOI (from the previous script)
# (Assuming GOI_Corr_filtered_sorted is available from script #3)

# Extract gene names of top correlated genes (based on filtered correlations)
top_genes <- names(GOI_Corr_filtered_sorted)

# Add GOI to the list of genes to include in the heatmap
top_genes <- c(GOI, top_genes)

# Ensure the dataset is transposed (genes in rows, samples in columns)
data_transposed <- t(data_clean)

# Select the expression values for the GOI and the top correlated genes
expression_values <- data_transposed[, top_genes]

# Ask user how they want to scale the data (log or z-score)
scaling_method <- readline(prompt = "Do you want to scale the data using log transformation or Z-score normalization? (log/z): ")

# Apply scaling based on user input
if (tolower(scaling_method) == "log") {
  # Apply log transformation (log2 + 1 to avoid issues with zero values)
  expression_values_scaled <- log2(expression_values + 1)
  cat("Log transformation applied.\n")
} else if (tolower(scaling_method) == "z") {
  # Apply Z-score normalization
  expression_values_scaled <- scale(expression_values)
  cat("Z-score normalization applied.\n")
} else {
  stop("Invalid input. Please choose 'log' or 'z'.")
}

# Generate a clustered heatmap with scaled data (based on chosen method)
pheatmap(expression_values_scaled, 
         clustering_distance_rows = "euclidean",  # Distance metric for row clustering
         clustering_distance_cols = "euclidean",  # Distance metric for column clustering
         clustering_method = "average",          # Clustering method
         display_numbers = FALSE,                 # Don't display numbers in cells
         color = colorRampPalette(c("blue", "white", "red"))(100),  # Color gradient
         main = paste("OPA1 Hs"),
         fontsize = 12)  # Adjust font size for better readability