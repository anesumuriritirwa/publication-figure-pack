library(readr)
library(dplyr)
library(ggplot2)
library(patchwork)

dir.create("figures", showWarnings = FALSE)

volcano_df <- read_csv("data/volcano_data.csv", show_col_types = FALSE) %>%
  mutate(
    status = case_when(
      log2FC >= 1 & padj < 0.05 ~ "Up",
      log2FC <= -1 & padj < 0.05 ~ "Down",
      TRUE ~ "Not significant"
    ),
    neg_log10_padj = -log10(padj)
  )

box_df <- read_csv("data/boxplot_data.csv", show_col_types = FALSE)

p1 <- ggplot(volcano_df, aes(x = log2FC, y = neg_log10_padj, color = status)) +
  geom_point(alpha = 0.8, size = 2.2) +
  scale_color_manual(values = c(
    "Up" = "#D55E00",
    "Down" = "#0072B2",
    "Not significant" = "grey75"
  )) +
  labs(title = "A. Volcano plot", x = "log2FC", y = "-log10 adjusted p-value") +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "none"
  )

p2 <- ggplot(box_df, aes(x = group, y = value, fill = group)) +
  geom_boxplot(width = 0.65, alpha = 0.85, outlier.shape = NA) +
  geom_jitter(width = 0.12, size = 1.8, alpha = 0.7) +
  scale_fill_manual(values = c(
    "Control" = "#4C78A8",
    "Treatment" = "#E45756"
  )) +
  labs(title = "B. Grouped boxplot", x = NULL, y = "Measured value") +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "none"
  )

combined <- p1 + p2 + plot_layout(ncol = 2)

ggsave("figures/multi_panel_template.png", plot = combined, width = 12, height = 5, dpi = 300)