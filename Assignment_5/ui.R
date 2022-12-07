#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

page_one <- tabPanel(
  "Introduction",
  titlePanel(strong("CO2 emissions")),
    mainPanel(
      h4(strong("The Variables")),
      h5(strong("co2_per_capita:")),
      h5("Annual total production-based emissions of carbon dioxide (CO₂), excluding land-use change, measured in tonnes per person. This is based on territorial emissions, which do not account for emissions embedded in traded goods."),
      h5(strong("co2_per_gdp:")),
      h5("Annual total production-based emissions of carbon dioxide (CO₂), excluding land-use change, measured in kilograms per dollar of GDP (2011 international-$). Production-based emissions are based on territorial emissions, which do not account for emissions embedded in traded goods."),
      h4(strong("Values")),
      h5("What is the average value of co2 per capita across all the countries in 2020?"),
      tableOutput("table1"),
      h5("What country is co2 per capita the highest in 2020"),
      tableOutput("table2"),
      h5("How much has average value of co2 per capita across all countries changed over the last year?"),
      tableOutput("table3"),
    )
  )
page_two <- tabPanel(
  "Interactive Visualization ",
  titlePanel(strong("Scatterplot")),
  sidebarLayout(
    sidebarPanel(
      uiOutput("selectCountry"),
      uiOutput("selectXVariable"),
      uiOutput("selectYVariable")
    ),
    mainPanel(
      h2("Scatterplot for annual total production-based emissions of co2"),
      plotlyOutput("co2_scatterplot"),
      h4(strong("Data Analysis:")),
      h5("From the scatterplot we are able to compare the co2 emissions per capita and per gdp for multiple years and gdps.
         An interesting correlation was that for most countries there is correlation between an increase in gdp and an increase in co2 per capita.
         Another fact is that high co2 per capita and per gdp are correlated with more recent years."),
    )
  )
)
ui <- navbarPage(
  "CO2 Emissions",
  page_one,
  page_two
)

shinyUI(fluidPage(
  theme = shinytheme("darkly"),
  ui))
