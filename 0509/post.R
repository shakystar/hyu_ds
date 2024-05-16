library(httr)
library(rvest)

url = 'https://www.dhlottery.co.kr/gameResult.do?method=byWin'

data_lotto = POST(
  url, 
  body = list(
    drwNo = "1009",
    dwrNoList = "1009"
  )
)

data_lotto_html = data_lotto %>% read_html()

data_lotto_html %>%
  html_nodes('.num.win') %>%
  html_text()

library(stringr)

data_lotto_html %>%
  html_nodes('.num.win') %>%
  html_text() %>%
  str_extract_all('\\d+') %>%
  unlist()