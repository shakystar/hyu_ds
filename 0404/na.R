x = c(1:4, NA, 6:7, NA)
x
is.na(x)


df = data.frame (col1 = c (1:3, NA),
                 col2 = c ("this", NA,"is", "text"),
                 col3 = c (TRUE, FALSE, TRUE, TRUE),
                 col4 = c (2.5, 4.2, 3.2, NA)
)
df
is.na(df)

y = c(1, 3, NA, 4)
mean(y)
mean(y, na.rm = TRUE)

df = data.frame (col1 = c (1:4),
                 col2 = c ("this", NA,"is", "text"),
                 col3 = c (TRUE, FALSE, TRUE, TRUE),
                 col4 = c (2.5, 4.2, 3.2, 5.0)
)
df
na.omit(df)

x = c(1:4, NA, 6:7, NA)
x[is.na(x)] = mean(x, na.rm = TRUE)
x