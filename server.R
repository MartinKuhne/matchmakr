# server.R
# Author: Martin Kuhne
# Summary: UI for matchmakr course project
# cf. https://class.coursera.org/devdataprod-006/

library(shiny)

ratings <- c("Boring", "Harmonious", "Invigorating", "Exciting", "Tumultuous", "Explosive", "Disastrous")

shinyServer(function(input, output)
{
    relationshipRating <- function()
    {
        selectedValues <- as.integer(reactiveValuesToList(input, all.names = FALSE))
        if (any(selectedValues == 0))
        {
            return("(select a value for all inputs to see your rating!)")
        }
        
        # super-scientific formula backed by minutes of research
        # match is between 0 and 6
        match <- (abs(as.integer(input$interest1) - as.integer(input$interest2))
               + abs(as.integer(input$reward1) - as.integer(input$reward2))
               + abs(as.integer(input$location1) - as.integer(input$location2)))

        # account for 1 based indices
        match <- match + 1
        
        paste("Scientific studies show your relationship will be", ratings[[match]], sep = " ")
    }

    output$rating <- 
    {
        renderText(relationshipRating())
    }
})