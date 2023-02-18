library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "journal"),
  titlePanel("COVID-19 Tracker  Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "countrydropdown",
        label = "Country Dropdown",
        choices = list(1,2,3,4,5,6,7,8)
      ),
      sliderInput(
        inputId = "gdpslider",
        label = "GDP Slider",
        min = 0,
        max = 10,
        value = 5
      ),
      sliderInput(
        inputId = "popdenslider",
        label = "Population Density slider",
        min = 0,
        max = 10,
        value = 5
      ),
    ),
    mainPanel(
      plotOutput(outputId = "distplot")
      
      )
  )
)

server <- function(input, output, session) {
  thematic::thematic_shiny()
  output$distplot <- renderPlot({
    # generate bins
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$gdpslider + 1)
    
    # draw the histogram with the specified number of bins
    hist(x,
         breaks = bins, col = "darkgray", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times"
    )
  })
}

shinyApp(ui, server)
