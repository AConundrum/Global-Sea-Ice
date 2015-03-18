# Load libraries
library(shiny)
library(shinythemes)
# MAIN
shinyUI(fluidPage(theme=shinytheme("spacelab"),
     # Application title
     titlePanel("Global Sea Ice Extent"),
#     textOutput("text1"), # DEBUG
     fluidRow(
          column(width = 4,
#               h4("Using data from NSIDC, explore historical sea ice
#                    extent versus a daily expected value."),
#                 p("Use the 'Date' slider to view the desired year range."),
               sliderInput("yrs", h4("Year range:"), 1989,2015, c(2011,2015),
                             step=1, sep="", width="100%"),
               wellPanel(
                    radioButtons("radio", label = h4("Data set"),
                         choices = list("Arctic", "Antarctic", "Global")),
                    p("Note: the Global data set is calculated as, Global =
                      Arctic + Antarctic")
               ), # wellPanel
               wellPanel(
                    radioButtons("radio2", label = h4("Presentation"),
                              choices = list("Observed & Seasonal", "Anomaly")),
                    p("Note: The seasonal value is calculated from a time
                      series decomposition on the entire data set (1989-present)."), 
                    p("Anomaly is calculated as, Anomaly = Observed-Seasonal")
               ) # wellPanel
          ), # column 
          column(width = 8,
               plotOutput("plot")
          ) # column
     ) # fluidRow
)) # fluidPage, shinyUI