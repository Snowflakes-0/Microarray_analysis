#correlation between two genes
GOI2 <- "AT1G27435"  # Replace with your actual GOI gene name

# Ensure the GOI is present in the dataset (genes are in rows)
if (!(GOI2 %in% rownames(data_clean))) {
  stop("GOI2 gene not found in dataset.")
}

CorrelationSpec <- cor_matrix[GOI2, GOI]

print(CorrelationSpec)

