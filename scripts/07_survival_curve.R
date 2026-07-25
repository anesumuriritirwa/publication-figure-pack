#Kaplan–Meier curves with survival and survminer are a standard manuscript-friendly pattern for time-to-event plots.
library(readr)
library(survival)
library(survminer)

dir.create("figures", showWarnings = FALSE)

df <- read_csv("data/survival_data.csv", show_col_types = FALSE)

fit <- survfit(Surv(time, status) ~ group, data = df)

p <- ggsurvplot(
  fit,
  data = df,
  risk.table = TRUE,
  pval = TRUE,
  conf.int = FALSE,
  palette = c("#4C78A8", "#E45756"),
  legend.title = "",
  legend.labs = c("Control", "Treatment"),
  xlab = "Time",
  ylab = "Survival probability",
  ggtheme = theme_minimal(base_size = 12)
)

ggsave("figures/survival_template.png", plot = p$plot, width = 7, height = 5, dpi = 300)