a = 'learning to create'
b = 'character strings'
paste(a, b)
paste('pi is', pi)
paste('I', 'love', 'R', sep = ',')
paste0('I', 'love', 'R')

# install.packages("stringr")

library(stringr)
str_c('Learning', 'to', 'use', 'the', 'stringr', 'package', sep = ' ')

text = c('Learning', 'to', NA, 'use', 'the', NA, 'stringr', 'package')
str_length(text)

x = 'Learning to use the stringr package'
str_sub(x, start = 1, end = 15)
str_sub(x, start = -7, end = -1)

# str trim 함수까진 필요없다고 넘어가넹

str_pad('beer', width = 10, side = 'left')
str_pad('beer', width = 10, side = 'left', pad = '!')


# install.packages("glue")

library(glue)

name = '이현열'
birth = '1987'

glue('나의 이름은 {name}이며, {birth}년에 태어났습니다.')
