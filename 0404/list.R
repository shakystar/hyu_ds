l = list(1:3,
         'a',
         c(TRUE, FALSE, TRUE),
         c(2.5, 4.2))
str(l)


l2 = list(1:3, 
          list(letters[1:5], 
               c(TRUE, FALSE, TRUE)))
str(l2)

l3 = list(1:3, 'a', c(TRUE, FALSE, TRUE))
l4 = append(l3, list(c(2.5, 4.2)))
print(l4)

