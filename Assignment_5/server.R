#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(shinythemes)
#-----------------# START DATA WRANGLING FOR INTRODUCTION TAB
co2_emissions_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
per_capita_df <- co2_emissions_df %>% 
  select(country, year, gdp, co2_per_capita, co2_per_gdp)

# What is the average value of co2 per capita across all the countries in 2020?
average_value <- per_capita_df %>% 
  filter(year == 2020) %>% 
  summarize(average_co2_per_capita = mean(co2_per_capita, na.rm = TRUE)) %>% 
  select(average_co2_per_capita)
  
# What country is co2 per capita the highest in 2020?
highest_co2_2020 <- per_capita_df %>% 
  filter(year == 2020) %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% 
  select(country)
# How much has average value of co2 per capita across all countries changed over the last year?
change_over_last_10_years <- per_capita_df %>% 
  filter(year %in% (2019:2020)) %>% 
  group_by(year) %>% 
  summarize(avg_co2_per_capita = mean(co2_per_capita, na.rm = TRUE)) %>% 
  mutate(change = avg_co2_per_capita - lag(avg_co2_per_capita)) %>% 
  select(change) %>% 
  drop_na()
#------------------------# END DATA WRANGLING FOR INTRO PAGE
#------------------------# START DATA WRANGLING FOR DATA VIZ TAB
last_50_years_per_capita_df <- per_capita_df %>% 
  filter(year %in% (1970:2020)) %>% 
  drop_na() 
#---------------------------# Define server logic required to draw scatterplot 
shinyServer(function(input, output) {
  output$selectCountry <- renderUI({
    selectInput("Country", "Choose a Country", choices = unique(last_50_years_per_capita_df$country))
  })
  output$selectXVariable  <- renderUI({
    selectizeInput("x", "Select the x variable:", choices = c("gdp", "year"), selected = "year")
  })
  output$selectYVariable <- renderUI({
    selectizeInput('y', 'Select the y variable', choices = c("co2_per_capita", "co2_per_gdp"), selected = "CO2 emissions per capita")
  })
  
  scatterplot <- reactive({
    plotCountry <- last_50_years_per_capita_df %>% 
      filter(country %in% input$Country)
    
    scatter_plot <- ggplot(plotCountry, aes_string(x =input$x, y = input$y)) +
        geom_point() +
        labs(
          x = input$x,
          y = input$y,
          title = "CO2 per capita and per GDP throughout multiple years")
  })
  
  output$co2_scatterplot <- renderPlotly({
    scatterplot()
  })
  output$table1 <- renderTable({
    table1 <- average_value
  })
  output$table2 <- renderTable({
    table2 <- highest_co2_2020
  })
  output$table3 <- renderTable({
    table3 <- change_over_last_10_years
  })
})
