df = data.frame (col1 = 1:3,
                 col2 = c ("this", "is", "text"),
                 col3 = c (TRUE, FALSE, TRUE),
                 col4 = c (2.5, 4.2, pi))
str(df)

v1 = 1:3
v2 = c ("this", "is", "text")
v3 = c (TRUE, FALSE, TRUE)
data.frame(col1 = v1, col2 = v2, col3 = v3)

l = list(item1 = 1:3,
          item2 = c ("this", "is", "text"),
          item3 = c (2.5, 4.2, 5.1))
l

data.frame(l)
df

v4 = c ("A", "B", "C")
cbind(df, v4)

v5 = c (4, "R", F, 1.1)
rbind(df, v5)

df[2:3, ]
df[ , c('col2', 'col4')]
df[, 2]
df[, 2, drop = FALSE]

na.omit(df)
