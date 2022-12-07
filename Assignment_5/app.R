#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
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

# Define UI for application 
source("ui.R")

# Define Server logic
source("server.R")

# Run the application 
shinyApp(ui = ui, server = server)

rsconnect::setAccountInfo(name='womenshealth', 
                          token='766E313306714232614E9F52E3B4C389',
                          secret='h7CtmQ4Fd0tGDfqjJlhWfU9ZlTiUGnAfcrK276YE')
