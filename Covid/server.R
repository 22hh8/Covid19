library(shiny)
library(shinydashboard)
library(scales)
library(tidyverse)
library(readr)
library(DT)


shinyServer(function(input,output,session) {
    
    df <- reactiveFileReader(
            intervalMillis = 20000,
            session = session,
            filePath = "https://covidtracking.com/data/download/all-states-history.csv",
            readFunc = read_csv)
    
    observeEvent(input$state,{
        updateSelectInput(session,"state",choices = c(unique(df()$state)))
    }, once=TRUE)
    
    #output$title <- renderText({input$state})

    output$poscases <- renderValueBox({
        df1 <- df() %>% filter(state == input$state, date >= input$range[1], date <= input$range[2]) %>% 
            select(positiveIncrease) %>% summarise(totalPos = sum(positiveIncrease,na.rm = TRUE))
        
        valueBox(
            # add commas to separate
            value = number(df1$totalPos, big.mark = ","),
            subtitle = "Total Number of Positive Cases",
            
        )
    })
    
    output$totalhos <- renderValueBox({
        df1 <- df() %>% filter(state == input$state, date >= input$range[1], date <= input$range[2]) %>% 
            select(hospitalizedIncrease)%>% summarise(totalHos = sum(hospitalizedIncrease,na.rm = TRUE)) 
        valueBox(
            # add commas to separate
            value = if_else(df1$totalHos == 0, "N/A",number(df1$totalHos,big.mark = ",")),            
            subtitle = "Total Number of People Hospitalized",
            
        )
    })
    
    
    
})