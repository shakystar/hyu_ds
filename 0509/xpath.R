library(rvest)
library(httr)

url = 'http://www.yes24.com/Product/Goods/117293655'

data = GET(url)

data_sales = data %>%
  read_html() %>%
  html_nodes(xpath = '//*[@id="yDetailTopWrap"]/div[2]/div[1]/span[3]/span[3]')

print(data_sales)

data_sales %>%
  html_text() %>%
  readr::parse_number()

