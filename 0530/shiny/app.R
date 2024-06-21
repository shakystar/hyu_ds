library(shiny)
library(DT)
library(ggplot2)
library(dplyr)
library(magrittr)

ui = fluidPage(

  titlePanel("mtcars"),
  sidebarLayout(

    sidebarPanel(
      checkboxGroupInput("cyl", label = '실린더를 선택하세요',
                         choices = mtcars[['cyl']] %>% unique() %>% sort(),
                         selected = mtcars[['cyl']] %>% unique() %>% sort() %>% .[1]),

      actionButton('go', label = '분석을 실행하세요!')

    ),

    mainPanel(
      dataTableOutput('mtcars_table'),
      plotOutput('mtcars_plot')
    )
  )
)

server = function(input, output, session) {

  sel_mtcars = eventReactive(input$go, {
    mtcars %>%
      select(mpg, cyl, wt) %>%
      filter(cyl %in% input$cyl)
  })

  output$mtcars_table = renderDataTable({

    sel_mtcars() %>%
      datatable()
  })

  output$mtcars_plot = renderPlot({

    sel_mtcars() %>%
      ggplot(aes(x = mpg, y = wt, color = factor(cyl))) +
      geom_point(size = 5)
  })
}

shinyApp(ui, server)


# ui = fluidPage(
#   selectInput("x", "X variable", choices = names(iris)),
#   selectInput("y", "Y variable", choices = names(iris)),
#   plotOutput("plot")
# )
# 
# server = function(input, output, session) {
#   output$plot = renderPlot({
#     ggplot(iris, aes_string(input$x, input$y)) +
#       geom_point()
#   })
# }
# 
# shinyApp(ui, server)