library(ggplot2)


tibble::tribble(
  ~color, ~palette,
  "#2e2933", "base",
  "#837591", "base",
  "#e9ebe5", "base",
  "#cf597e", "diverging",
  "#e88471", "diverging",
  "#eeb479", "diverging",
  "#e9e29c", "diverging",
  "#9ccb86", "diverging",
  "#39b185", "diverging",
  "#009392", "diverging",
  "#f7feae", "sequential",
  "#b7e6a5", "sequential",
  "#7ccba2", "sequential",
  "#46aea0", "sequential",
  "#089099", "sequential",
  "#00718b", "sequential",
  "#045275", "sequential",
) |>
  dplyr::mutate(
    color_palette_rank = dplyr::row_number(),
    .by = palette
  ) |>
  ggplot(aes(
    x = color_palette_rank,
    y = forcats::fct_rev(palette),
    fill = color
  )) +
  geom_tile(width = 1) +
  scale_fill_identity() +
  coord_equal()
