library(tidyverse)
library(shiny)
library(CodeClanData)
library(shinythemes)

game_sales <- game_sales %>%
    mutate(score = if_else(user_score >= 7, "Above 7", "Below 7"))

shinyUI(fluidPage(
    
    theme = shinytheme("simplex"),
    
    titlePanel("Video game scores by user"),
    br(),
    
    fluidRow(
        
        column(6,
               checkboxGroupInput("rating", 
                                  label = h4("ESRB game rating"), 
                                  choices = c("Early Childhood" = "E",
                                              "Everyone 10+" = "E10+",
                                              "Mature" = "M",
                                              "Teen" = "T"
                                            ),
                                  selected = 1
                )
        ),
        
        column(6,
               selectInput("platform",
                           h4("Console the game runs on"),
                           unique(game_sales$platform)
               )
        )
    ),
    
    actionButton("update",
                 "Update"
    ),
    
    plotOutput("graph"
    )
))
