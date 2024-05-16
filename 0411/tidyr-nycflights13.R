# install.packages("nycflights13")

library(dplyr)
library(nycflights13)
flights
# data(flights)

#---------------------------------------------------------------
flights %>% select(year, month, day)
flights %>% select(year:day)
flights %>% select(-(year:day))
flights %>% select(starts_with("dep"))
flights %>% select(ends_with("delay"))
flights %>% select(contains("_")) %>% select(-(air_time))

#---------------------------------------------------------------
flights %>% rename(tail_num = tailnum) %>% select(tail_num)

#---------------------------------------------------------------
flights %>% filter(month == 3, day == 1)
# filter(flights, month == 3, day == 1)
flights %>% filter((month == 3) & (day >= 30))

#---------------------------------------------------------------
flights %>% summarize(max(dep_time)) # NA가 있으면 계산 자체가 안된대요
flights %>% summarize(max(dep_time, na.rm = TRUE))
flights %>% summarize(max_dep = max(dep_time, na.rm = TRUE),
                      min_dep = min(dep_time, na.rm = TRUE))
#---------------------------------------------------------------
by_day = flights %>% group_by(year, month, day)
by_day
by_day %>%  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>% ungroup()

#---------------------------------------------------------------
flights %>% group_by(dest) %>%  summarize(
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
)

#---------------------------------------------------------------
flights %>% arrange(year, month, day)
flights %>% arrange(desc(dep_delay))

#---------------------------------------------------------------
flights2 = flights %>%
  select(year:day, hour, tailnum, carrier)

flights2
airlines

flights2 %>%  left_join(airlines, by = "carrier")

#---------------------------------------------------------------
flights_sml = flights %>%  select(
  year:day,
  ends_with("delay"),
  distance,
  air_time
)

flights_sml %>%  mutate(
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60)

flights_sml %>% mutate(
  dep_delay = dep_delay * 60
)

flights_sml %>%  mutate(
  across(c('dep_delay', 'arr_delay'), ~ .x * 60)
)
#---------------------------------------------------------------





