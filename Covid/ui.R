library(shiny)
library(shinydashboard)
library(ggplot2)
library(readr)

dashboardPage(title="US COVID-19 Cases by State",
    # Header
    dashboardHeader(title = "US COVID-19 Cases"),
    
    dashboardSidebar(
        selectInput("state", "Select State:",
                    choices = NULL),
        dateRangeInput("range", "Date range:",
                       start = "2020-01-22",
                       end = Sys.Date()-1) #I'm in Korean Time zone
    ),
    dashboardBody(
        # fluidRow(
        #     box(textOutput("title"))
        # ),
        
        fluidRow(
            infoBoxOutput("poscases",width=6),
            infoBoxOutput("totalhos", width=6)
        )
    )
)



