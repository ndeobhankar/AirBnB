#
# This is a shiny app by Niraj Deobhankar. Instead of creating three different files, only one file is created.
#

library(shiny)
library(dplyr)
library(ggplot2)

#Read data
Host_ <- read.table(file='D:/R_Bootcamp/R_DSTI_Project/Niraj_DSTI/Webapp.csv')

# Define UI for application that draws Relation between Price and Area for 
#different property types and room types of AirBnB data
ui <- fluidPage(

    # Application title
    titlePanel("Relation between Price and Area for different property types and room types"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("host_response_time", label = "Host Response Time:", 
                      choices = list("within an hour", "within a day", "within a few hours",
                                     "a few days or more"), 
                      selected = "within an hour"),
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Host")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  data <- reactive({
    req(input$host_response_time)
    Host_ %>% filter(host_response_time %in% input$host_response_time)
  })  
  
  output$Host <- renderPlot({
        
    ggplot(data()) +
      geom_point(aes(x = host_response_rate, y = host_acceptance_rate))+
      facet_wrap( ~ host_is_superhost)+
      ggtitle("Relation between Response rate and Acceptance Rate") +
      xlab("Response Rate") + ylab("Acceptance Rate")
    
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
