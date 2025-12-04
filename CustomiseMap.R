# Ensure necessary libraries are installed and loaded
if (!require(pheatmap)) install.packages("pheatmap")
library(pheatmap)

# --- 5A. Setup Customization Options ---

# Ask user if they want to transpose the heatmap
transpose_choice <- readline(prompt = "Do you want to transpose the heatmap (swap X and Y)? (yes/no): ")

# Ask user for font sizes
font_row <- as.numeric(readline(prompt = "Enter font size for row labels (e.g., 10): "))
font_col <- as.numeric(readline(prompt = "Enter font size for column labels (e.g., 10): "))
main_fontsize <- as.numeric(readline(prompt = "Enter overall font size (e.g., 13): "))

# Define a custom color palette
custom_colors <- colorRampPalette(c("blue", "white", "red"))(100)

# set heading
header <- readline(prompt = "Enter custom header (or press enter to not have a header): ")


# Use scaled expression values from Script 4
matrix_to_plot <- expression_values_scaled

if (tolower(transpose_choice) == "yes") {
  matrix_to_plot <- t(matrix_to_plot)
  cat("Matrix transposed.\n")
} else {
  cat("Matrix kept in original orientation.\n")
}

# --- 5C. Plot the Heatmap ---

heatmap_plot <- pheatmap(matrix_to_plot,
                         clustering_distance_rows = "euclidean",
                         clustering_distance_cols = "euclidean",
                         clustering_method = "average",
                         display_numbers = FALSE,
                         color = custom_colors,
                         fontsize_row = font_row,
                         fontsize_col = font_col,
                         fontsize = main_fontsize,
                         main = header,
                         cellwidth = 20,       # Width of cells
                         cellheight = 20,      # Height of cells
                         border_color = NA,    # No border color
                         legend = TRUE,
                         angle_col = 45        # Tilt X-axis labels for readability
)
