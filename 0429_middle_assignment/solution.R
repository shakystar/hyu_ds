library(jsonlite)
library(lubridate)
library(magrittr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(forcats)

url_birth_marriage = 'https://kosis.kr/openapi/Param/statisticsParameterData.do?method=getList&apiKey=YTYzYTU3OTc1MmRhNzk2YTFlNWIzOTlhNmFlZmM5YjM=&itmId=T12+T41+&objL1=ALL&objL2=&objL3=&objL4=&objL5=&objL6=&objL7=&objL8=&format=json&jsonVD=Y&prdSe=Y&startPrdDe=1990&endPrdDe=2023&orgId=101&tblId=DT_1B8000H'
url_mother_age_avg = 'https://kosis.kr/openapi/Param/statisticsParameterData.do?method=getList&apiKey=YTYzYTU3OTc1MmRhNzk2YTFlNWIzOTlhNmFlZmM5YjM=&itmId=T20+&objL1=ALL&objL2=&objL3=&objL4=&objL5=&objL6=&objL7=&objL8=&format=json&jsonVD=Y&prdSe=Y&startPrdDe=1993&endPrdDe=2022&orgId=101&tblId=DT_1B81A20'
url_mother_age_group = 'https://kosis.kr/openapi/Param/statisticsParameterData.do?method=getList&apiKey=YTYzYTU3OTc1MmRhNzk2YTFlNWIzOTlhNmFlZmM5YjM=&itmId=T1+&objL1=0+&objL2=00+&objL3=ALL&objL4=&objL5=&objL6=&objL7=&objL8=&format=json&jsonVD=Y&prdSe=Y&startPrdDe=1981&endPrdDe=2022&orgId=101&tblId=DT_1B80A01'

data_bm = fromJSON(url_birth_marriage)
data_maa = fromJSON(url_mother_age_avg)
data_mag = fromJSON(url_mother_age_group)

# 저출산율 문제를 확인하기 위해 출산율이 얼마나 하락했는지 알고자 한다. 전국 기준 합계출산율 추이 나타내라. (y = 1에 수평선도 추가)
# data_bm, x = PRD_DE, y = DT

data_bm %>%
  filter(C1_NM == "전국") %>%
  filter(ITM_NM == "합계출산율") %>%
  # mutate(PRD_DE = paste0(PRD_DE, '0101')) %>%
  # mutate(PRD_DE = as_date(PRD_DE)) %>%
  mutate(DT = as.numeric(DT)) %>%
  ggplot(aes(x = PRD_DE, y = DT, group = 1)) +
  geom_line() +
  geom_hline(yintercept = 1, color = 'red', linetype = 2)


# 시도별로 출산율에는 어떤 차이가 있는지 확인하고자 한다. 최근 년도 기준 각 시도별 출생률 막대그래프로 나타내라.
# data_bm, y = DT,x = 각 지역, y, x 플립

data_bm %>%
  filter(C1_NM != "전국" & C1_NM != "국외") %>%
  filter(ITM_NM == "합계출산율") %>%
  # filter(PRD_DE == "2023") %>%
  filter(PRD_DE == max(PRD_DE)) %>%  # PRD_DE의 최대값을 조건으로 사용, YYYY라서 문제 없음
  mutate(DT = as.numeric(DT)) %>%
  mutate(C1_NM = fct_reorder(C1_NM, DT)) %>%
  ggplot(aes(x = C1_NM, y = DT)) +
  geom_col() +
  labs(x = "시도", y = "출생률") +
  coord_flip()


# 저출산율 못지않게 저혼인율도 심각한 문제다.  각 시도별 조혼인율 시계열 그래프를 시도별로 분할해서 그려라.
# data_bm

data_bm %>%
  filter(C1_NM != "전국" & C1_NM != "국외") %>%
  filter(ITM_NM == "조혼인율 (천명당)") %>%
  mutate(DT = as.numeric(DT)) %>%
  group_by(C1_NM) %>%
  ggplot(aes(x = PRD_DE, y = DT, group = 1)) +
  geom_line() +
  facet_wrap(~ C1_NM, ncol = 5)
    
# 저출산 중 첫번째 원인은 남녀의 결혼 연령이 늦어짐에 따라 출산 연령도 늦어지는 것으로 꼽는다. 모의 첫째 아 평균 출산 연령을 시계열로 나타내라.
# data_maa

data_maa %>%
  filter(DT != "-") %>%
  mutate(DT = as.numeric(DT)) %>%
  ggplot(aes(x = PRD_DE, y = DT, group = C1_NM, colour = C1_NM)) +
  geom_line() +
  geom_point()

# 외동이 늘어나고 있는지를 살펴보고자 한다. 연도별 출생아 수의 비율을 나타내어라.
# data_mag

year_children = data_mag %>%
  filter(C3_NM != "총계") %>%
  group_by(PRD_DE) %>%
  mutate(DT = as.numeric(DT)) %>%
  mutate(ratio = DT / sum(DT)) %>%
  select(PRD_DE, C3_NM, ratio) %>%
  pivot_wider(names_from = C3_NM, values_from = ratio)

# 위에서 구한 결과를 시각화로 나타내고자 한다. 출생숫자별 비중을 시계열로 나타내라.
# data_mag

data_mag %>%
  filter(C3_NM != "총계") %>%
  group_by(PRD_DE) %>%
  mutate(DT = as.numeric(DT)) %>%
  mutate(ratio = DT / sum(DT)) %>%
  select(PRD_DE, C3_NM, ratio) %>%
  ggplot(aes(x = PRD_DE, y = ratio, group = C3_NM, color = C3_NM)) +
  geom_line() +
  geom_point()

