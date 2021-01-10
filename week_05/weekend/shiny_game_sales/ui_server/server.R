library(shiny)

shinyServer(function(input, output) {

  game_sales_filtered <- eventReactive(input$update, {
    game_sales %>% 
      filter(rating == input$rating) %>% 
      filter(platform == input$platform)
  })
  
  output$graph <- renderPlot({
    
    ggplot(game_sales_filtered())+
      aes(x = user_score, y = name, label = user_score)+
      geom_point(stat='identity', aes(col = score), size = 8)+
      scale_color_manual(name = "",
                         labels = c("Above 7", "Below 7"),
                         values = c("Above 7" = "#1b9e77", "Below 7" = "#d95f02"))+
      geom_text(color="white", size = 4)+
      labs(x = "\nUser score",
           y = "Game\n")+
      theme_bw()+
      theme(legend.position = "none")
  })

})


