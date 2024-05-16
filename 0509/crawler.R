library(httr)
library(rvest)

url = 'https://quotes.toscrape.com/'
quote = GET(url)

print(quote)

quote_html = read_html(quote)

print(quote_html)

quote_div = quote_html %>%
  html_nodes('div.quote') %>%
  html_nodes('span.text')

print(quote_div)

quote_text = quote_div %>%
  html_text()

print(quote_text)

quote_who = quote_html %>%
  html_nodes('div.quote') %>%
  html_nodes('span') %>%
  html_nodes('small.author') %>%
  html_text()

print(quote_who)

quote_link = quote_html %>%
  html_nodes('div.quote') %>%
  html_nodes('span') %>%
  html_nodes('a') %>%
  html_attr('href')

print(quote_link)

quote_link = paste0('https://quotes.toscrape.com', quote_link)

quote_link

quote_df = data.frame(
  'quote' = quote_text,
  'author' = quote_who,
  'link' = quote_link
)

library(gt)

quote_df %>% gt()



























