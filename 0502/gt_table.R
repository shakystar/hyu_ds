library(gt)

sp500

start_date <- "2010-06-07"
end_date <- "2010-06-14"

sp500_select <- sp500 %>%
  dplyr::filter(date >= start_date & date <= end_date) %>%
  dplyr::select(-adj_close) 

sp500_select

sp500_select %>%
  gt()

gt_table = 
  sp500_select %>%
  gt() %>%
  tab_header(
    title = "S&P 500",
    subtitle = glue::glue("{start_date} to {end_date}")
  ) %>%
  fmt_date(columns = date, date_style = "wd_m_day_year") %>%
  fmt_number(columns = volume, suffixing = TRUE)

gt_table

up_arrow <- "<span style=\"color:red\">&#9650;</span>"
down_arrow <- "<span style=\"color:blue\">&#9660;</span>"

gt_table %>%
  text_transform(
    locations = cells_body(
      columns = close,
      rows = close > open
    ),
    fn = function(x) paste(x, up_arrow)
  ) %>%
  text_transform(
    locations = cells_body(
      columns = close,
      rows = close < open
    ),
    fn = function(x) paste(x, down_arrow)
  ) %>%
  cols_label_with(
    columns = everything(),
    fn = ~ paste0(toupper(substr(., 1, 1)), substr(., 2, nchar(.)))
  )