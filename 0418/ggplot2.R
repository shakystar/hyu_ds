# install.packages("ggplot2")
# install.packages("dplyr")

library(ggplot2)
data(diamonds)
head(diamonds)

# Data, Aesthetics
ggplot(data = diamonds, aes(x = carat, y = price))
library(magrittr)
diamonds %>% 
  ggplot(aes(x = carat, y = price))
# Data, Aesthetics, Geometrics
ggplot(data = diamonds, aes(x = carat, y = price)) + 
  geom_point()

diamonds %>%  ggplot(aes(x = carat, y = price)) +
  geom_point(aes(color = cut, shape = cut))

# Facets
diamonds %>%  ggplot(aes(x = carat, y = price)) +
  geom_point() +
  facet_grid(cut ~ .)

diamonds %>%  ggplot(aes(x = carat, y = price)) + 
  geom_point() + 
  facet_grid(color ~ cut)

# Statistics
library(dplyr)

diamonds %>%
  group_by(color) %>%
  summarize(carat = mean(carat)) %>%
  ggplot(aes(x = color, y = carat)) +
  geom_col()

# Coordinates
diamonds %>%  ggplot(aes(x = carat, y = price)) +
  geom_point(aes(color = cut)) +
  coord_cartesian(xlim = c(0, 3), ylim = c(0, 20000))

diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_boxplot(aes(group = cut))

diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_boxplot(aes(group = cut)) +
  coord_flip()

# Theme
diamonds %>%  
  ggplot(aes(x = carat, y = price)) +
  geom_point(aes(color = cut)) +
  theme_bw() +
  labs(title = 'Relation between Carat & Price',
       x = 'Carat', y = 'Price($)') +
  theme(legend.position = 'bottom',
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()
  ) +  scale_y_continuous(
    labels =function(x) {
      paste0('$',
             format(x, big.mark = ','))
    })






