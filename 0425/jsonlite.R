# install.packages("jsonlite")
library(jsonlite)

url_inflation = 'https://kosis.kr/openapi/Param/statisticsParameterData.do?method=getList&apiKey=YTYzYTU3OTc1MmRhNzk2YTFlNWIzOTlhNmFlZmM5YjM=&itmId=T+&objL1=T10&objL2=&objL3=&objL4=&objL5=&objL6=&objL7=&objL8=&format=json&jsonVD=Y&prdSe=M&startPrdDe=196501&endPrdDe=202403&orgId=101&tblId=DT_1J22003'
data_inflation = fromJSON(url_inflation)

# install.packages("lubridate")

library(lubridate)

data_inflation %>% 
  filter(C1_NM == '전국') %>%
  mutate(PRD_DE = paste0(PRD_DE, '0101')) %>%
  mutate(PRD_DE = as_date(PRD_DE)) %>%
  mutate(DT = as.numeric(DT)) %>%
  ggplot(aes(x = PRD_DE, y = DT)) +
  geom_line()
