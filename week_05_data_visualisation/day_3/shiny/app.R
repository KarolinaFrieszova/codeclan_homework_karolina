
library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinythemes)

olympics_overall_medals <- CodeClanData::olympics_overall_medals

ui <- fluidPage(
    theme = shinytheme("united"),
    
    titlePanel("Five Country Medal Comparison"),
    
    tabsetPanel(
        tabPanel("Graph",
                 plotOutput("medal_plot"),
                 
                 fluidRow(
                     
                     column(6,
                            radioButtons("season",
                                         tags$h4("Summer or Winter Olympics?"),
                                         choices = c("Summer", "Winter")
                            )
                     ),
                     column(6,
                            radioButtons("medal",
                                         tags$h4("Compare Which Medals?"),
                                         choices = c("Gold", "Silver", "Bronze")
                            )
                     )
                 )
        ),
        
        tabPanel("Website",
                 tags$a("The Olympic Website", href = "https://www.olympic.org/")
        )
    )
    
    
)




server <- function(input, output) {
    
    
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = team, y = count, fill = medal) +
            geom_col() +
            scale_fill_manual(values = c("Gold" = "#cca300",
                                         "Silver" = "#c0c0c0",
                                         "Bronze" = "#cc6600")
                              )+
            theme_bw()
        
    })
}

shinyApp(ui = ui, server = server)