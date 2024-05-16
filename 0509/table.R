library(rvest)
library(httr)

url = 'https://en.wikipedia.org/wiki/List_of_UFC_champions'
data_ufc = GET(url)

champion_list = data_ufc %>%
  read_html() %>%
  html_table()

champion_list[[1]]
