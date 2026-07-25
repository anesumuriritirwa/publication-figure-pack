library(readr)
library(dplyr)
library(tibble)
library(ComplexHeatmap)
library(circlize)
library(RColorBrewer)
library(grid)

dir.create("figures", showWarnings = FALSE)

expr <- read_csv("data/heatmap_matrix.csv", show_col_types = FALSE)
meta <- read_csv("data/heatmap_metadata.csv", show_col_types = FALSE)

mat <- expr %>%
  column_to_rownames("gene") %>%
  as.matrix()

mat_scaled <- t(scale(t(mat)))
mat_scaled[is.na(mat_scaled)] <- 0

meta <- meta %>%
  as.data.frame()
rownames(meta) <- meta$sample

meta <- meta[colnames(mat_scaled), , drop = FALSE]

ha <- HeatmapAnnotation(
  Group = meta$group,
  col = list(Group = c(Control = "#4C78A8", Treatment = "#E45756"))
)

col_fun <- colorRamp2(c(-2, 0, 2), c("#3B4CC0", "white", "#B40426"))

png("figures/heatmap_template.png", width = 1800, height = 2200, res = 300)

Heatmap(
  mat_scaled,
  name = "Z-score",
  top_annotation = ha,
  col = col_fun,
  show_row_names = TRUE,
  show_column_names = TRUE,
  row_names_gp = gpar(fontsize = 9),
  column_names_gp = gpar(fontsize = 10),
  cluster_rows = TRUE,
  cluster_columns = TRUE,
  column_title = "Expression Heatmap",
  heatmap_legend_param = list(title = "Scaled\nexpression")
)

dev.off()