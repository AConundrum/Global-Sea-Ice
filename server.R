library(shiny)
library(ggplot2)
load("Ice.Rdata")
shinyServer(
     function(input, output){
          ########## Get
          yrs <- reactive({
               yrs <- c(as.Date(paste0(input$yrs[1], "-1-1")),
               as.Date(paste0(input$yrs[2], "-1-1")))
          }) # reactive
          ##########
          DD <- reactive({
               switch(input$radio,
                    Arctic = NHIce,
                    Antarctic = SHIce,
                    Global = WDIce)
          })
          ##########
          MM <- reactive({
               switch(input$radio2,
                      "Observed & Seasonal" = FALSE,
                      Anomaly = TRUE)
          })
          ##########
          TT <- reactive({
               switch(input$radio,
                      Arctic = "Arctic Sea-ice [thousand sq. km]",
                      Antarctic = "Antarctic Sea-ice [thousand sq. km]",
                      Global = "Global Sea-ice [thousand sq. km]")
          })
          ##########
          output$plot <- renderPlot({
               p <- ggplot(DD(), aes(x=Date))
               
               if (MM())
                    p <- p + geom_line(aes(y=Observed-Seasonal, color="Anomaly"))
               else {
                    p <- p + geom_line(aes(y=Observed, color="Observed"))
                    p <- p + geom_line(aes(y=Seasonal, color="Seasonal")) 
               } # else
#              p <- p + geom_point(color="firebrick", aes(y=Observed, color="Observed"))
               p <- p + xlim(yrs())
               p <- p + ggtitle(TT())
               p <- p + theme(plot.title = element_text(size=20, face="bold", vjust=2))
               p <- p + theme(axis.text.x=element_text(angle=50, size=16, vjust=0.5)) 
               p <- p + theme(legend.title=element_blank())
               p
          }) # renderPlot
          ##########
#          output$text1 <- renderText({
#               paste(OFFSET())
#          }) # renderText
          ##########
     } # function
) # shinyServer


#               p <- p + stat_smooth(aes(color="stat_smooth"))