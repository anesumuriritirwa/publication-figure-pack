library(readr)
library(dplyr)
library(ggplot2)

dir.create("figures", showWarnings = FALSE)

df <- read_csv("data/volcano_data.csv", show_col_types = FALSE) %>%
  mutate(
    status = case_when(
      log2FC >= 1 & padj < 0.05 ~ "Up",
      log2FC <= -1 & padj < 0.05 ~ "Down",
      TRUE ~ "Not significant"
    ),
    neg_log10_padj = -log10(padj)
  )

p <- ggplot(df, aes(x = log2FC, y = neg_log10_padj, color = status)) +
  geom_point(alpha = 0.8, size = 2.5) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "grey40") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "grey40") +
  scale_color_manual(values = c(
    "Up" = "#D55E00",
    "Down" = "#0072B2",
    "Not significant" = "grey75"
  )) +
  labs(
    title = "Volcano Plot",
    x = "log2 Fold Change",
    y = "-log10 adjusted p-value",
    color = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "top"
  )

ggsave("figures/volcano_template.png", plot = p, width = 7, height = 5, dpi = 300)