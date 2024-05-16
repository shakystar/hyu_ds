# install.packages("tidyr")

library(tidyr)
table4a

#---------------------------------------------------------------
long = table4a %>% pivot_longer(names_to = 'years', values_to = 'cases', -country)
print(long)

back2wide = long %>% pivot_wider(names_from = 'years', values_from = 'cases')
print(back2wide)

#---------------------------------------------------------------
table3

table3 %>%
  separate(rate, into = c("cases", "population"))

table3 %>%
  separate(rate, into = c("cases", "population"), remove = FALSE)

#---------------------------------------------------------------
table5

table5 %>%
  unite(new, century, year, sep = "")

#---------------------------------------------------------------
score = tribble(
  ~ person, ~ Math, ~ Computer,
  "Henry",  1,         7,
  NA,       2,         10,
  NA,       NA,        9,
  "David",  1,         4)
score

score %>%
  fill(person, Math)

score %>% replace_na(replace = list(person = "unknown", Math = 0))

