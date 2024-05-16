# 파일 위치 확인하세요!
welfare = read.csv('welfare.csv')

library(magrittr)
library(dplyr)
library(ggplot2)
library(tidyr)

# welfare = welfare %>%
#   mutate(성별 = if_else(성별 == 1, '남', '여'))

welfare %>%
  select(성별) %>%
  table() %>%
  prop.table()

welfare %>%
  select(성별) %>%
  ggplot(aes(x = 성별)) +
  geom_bar()

welfare %>%
  select(월급) %>%
  summary()

# welfare = welfare %>%
#   mutate(월급 = ifelse(월급 == 0, NA, 월급))

welfare %>%
  filter(!is.na(월급)) %>%
  group_by(성별) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 성별, y = 평균월급)) +
  geom_col()

# welfare %>% str()

welfare = welfare %>%
  mutate(나이 = 2022 - 연도)

welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(나이) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 나이, y = 평균월급)) +
  geom_line() +
  geom_vline(xintercept = 45, color = 'red', linetype = 2) +
  geom_vline(xintercept = 60, color = 'red')

# welfare = welfare %>%
#   mutate(연령대 = if_else(나이 < 30, '초년', if_else(나이 <= 50, "중년", "노년")))

welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(연령대) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 연령대, y = 평균월급)) +
  geom_col() +
  scale_x_discrete(limits = c('초년', '중년', '노년'))

welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(성별, 연령대) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 연령대, y = 평균월급, fill = 성별)) +
  geom_col(position = 'dodge') +
  scale_x_discrete(limits = c('초년', '중년', '노년'))

welfare %>%
  filter(!is.na(월급)) %>%
  group_by(성별, 나이) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 나이, y = 평균월급, color = 성별)) +
  geom_line(linewidth = 1.4)

welfare = welfare %>%
  mutate(교육 = case_when(
    교육 == 1 ~ '1_미취학(만7세미만)',
    교육 == 2 ~ '2_무학(만7세이상)',
    교육 == 3 ~ '3_초등학교',
    교육 == 4 ~ '4_중학교',
    교육 == 5 ~ '5_고등학교',
    교육 == 6 ~ '6_전문대학',
    교육 == 7 ~ '7_대학교',
    교육 == 8 ~ '8_대학원(석사)',
    교육 == 9 ~ '9_대학원(박사)',
    TRUE ~ 'NA'
  )
  )

welfare %>%
  select(교육) %>%
  table() %>%
  prop.table() %>%
  round(., 4)

welfare %>%
  filter(!is.na(월급)) %>%
  group_by(교육) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 교육, y = 평균월급)) +
  geom_col()

welfare %>%
  mutate(나이대 = case_when(
    나이 <= 20 ~ '1_20세이하',
    나이 <= 30 ~ '2_21~30세',
    나이 <= 40 ~ '3_31~40세',
    나이 <= 50 ~ '4_41~50세',
    나이 <= 60 ~ '5_51~60세',
    TRUE ~ '6_60세이상'
  )
  ) %>%
  filter(!is.na(월급)) %>%
  group_by(나이대, 교육) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 교육, y = 평균월급)) +
  geom_col() +
  facet_grid( ~ 나이대)


welfare = welfare %>%
  mutate(지표 = if_else(between(나이, 15, 64), '생산가능인구',
                      if_else(나이 >= 65, '고령', '아동'))) %>%
  mutate(지역명 = case_when(
    지역 == 1 ~ '1_서울',
    지역 == 2 ~ '2_수도권(인천/경기) ',
    지역 == 3 ~ '3_부산/경남/울산',
    지역 == 4 ~ '4_대구/경북',
    지역 == 5 ~ '5_대전/충남',
    지역 == 6 ~ '6_강원/충북',
    지역 == 7 ~ '7_광주/전남/전북/제주도',
    TRUE ~ 'NA'
  ))

welfare %>%
  filter(!is.na(월급)) %>% 
  group_by(지역명) %>%
  summarize(평균월급 = median(월급)) %>%
  ggplot(aes(x = 지역명, y = 평균월급)) +
  geom_col()

welfare %>%
  group_by(지역명) %>%
  summarize(n = n()) %>%
  mutate(prop = n / sum(n))

welfare %>%
  filter(지표 != '아동') %>%
  group_by(지역명, 지표) %>%
  summarize(n = n()) %>%
  ungroup() %>%
  pivot_wider(names_from = '지표', values_from = n) %>%
  mutate(고령화수준 = 고령 / 생산가능인구) %>%
  ggplot(aes(x = 지역명, y = 고령화수준)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits=rev)




