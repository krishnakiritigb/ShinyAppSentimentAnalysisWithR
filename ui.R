#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# loading the required libraries.

library(shiny)
library(shinythemes)
library(shinyWidgets)
library(plotly)

# Define UI for application that draws a histogram

fluidPage(

    # Application title
    titlePanel("Sentiment Analysis Using British Airways Reviews"),

    tabsetPanel(
      tabPanel("About",br(),
               textOutput('aboutText')
      ),
      tabPanel("Data Description", br(),mainPanel(
        tableOutput("table")
      )),
      tabPanel("Classifying the user input review", br(),
               sidebarLayout(
                 sidebarPanel(
                   HTML("<h3>User Review</h3>"),
                   textInput("userReview", label ="Enter your review:"),
                   selectInput("userRating", label = "Rating:", 
                               choices = c(1:10), 
                               selected = 1),
                   selectInput("userTripVerfied", label = "Trip Status:", 
                               choices = list(TRUE, FALSE), 
                               selected = TRUE),
                   actionButton("submitbutton", "Submit", class = "btn btn-primary")
                   ),

                   # Classifier Output
                   mainPanel(
                     tags$label(h3('Status/Output')), # Status/Output Text Box
                     verbatimTextOutput('contents'),
                     tableOutput('prediction') # Prediction results table
                   )
               )
      ),
      #Graphs, word frequency bar graph, bar chart, pie chart, histogram.
      tabPanel("Data Visualisations", br(),
               navlistPanel(
                 tabPanel("Word Frequency", 
                          sidebarLayout(
                            sidebarPanel(
                              sliderInput(
                                "wordFrequency",
                                       "Number of Words:",
                                       min = 1,
                                       max = 15,
                                        value=10
                                )
                       ),
                       mainPanel(
                           plotlyOutput("wordFreq")
                       )
                   )),
                 tabPanel("Bar Chart", mainPanel(
                   plotOutput("barChart")
                 )),
                 tabPanel("Pie Charts", 
                          sidebarLayout(
                            sidebarPanel(
                              sliderInput(
                                "ratingCount",
                                "Rating level:",
                                min = 1,
                                max = 10,
                                value=5
                              )
                            ),
                          mainPanel(
                   plotlyOutput('pieChart')))),
                 tabPanel("Histogram", 
                          sidebarLayout(
                            sidebarPanel(
                              selectInput(
                                "booleanTrip",label="Trip Status",
                                choices = list(TRUE, FALSE), 
                                selected = TRUE
                              )
                            ),
                            mainPanel(
                              plotOutput('histogramPlot')))),
                 ),
               )
      ),
)
