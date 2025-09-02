
#Loading the data pre-processing, and plotting libraries libraries.
library(shiny)
library(tidyverse)
library(tm)
library(caret)
library(e1071)
library(RTextTools)
library(SnowballC)
library(ggplot2)
library(plotly)



# Load data

df <- read.csv("british-airways.csv")

#Pre processing the data and tokenizing it.
tokenize <- function(text) {
  text <- tolower(text)
  text <- removePunctuation(text)
  text <- removeNumbers(text)
  text <- stripWhitespace(text)
  text <- removeWords(text, stopwords("english"))
  text <- stemDocument(text)
  return(text)
}
#Function to preprocess data, train model, and predict on user input
handleUserInput <- function(review, rating, verifiedStatus) {
  # Filter data based on verified status if its True
  filteredData <- df[df$trip_verified == TRUE, ]
  # Preprocessing the  data
  corpus <- Corpus(VectorSource(filteredData$review))
  corpus <- tm_map(corpus, content_transformer(tokenize))
  # Create document term matrix based on the corpus generated.
  dtm <- DocumentTermMatrix(corpus)
  # Split data into training and testing sets
  index <- createDataPartition(filteredData$rating, p = 0.7, list = FALSE)
  xTrain <- dtm[index, ]
  xTest <- dtm[-index, ]
  yTrain <- filteredData[index, "rating"]
  yTest <- filteredData[-index, "rating"]
  
  # Train model
  model <- svm(xTrain, yTrain, kernel = "linear")
  # Predict on user input
  userInput <- Corpus(VectorSource(review))
  userInput <- tm_map(userInput, content_transformer(tokenize))
  userInputDtm <- DocumentTermMatrix(userInput, control = list(dictionary = Terms(dtm)))
  userInputMatrix <- as.matrix(userInputDtm)
  prediction <- predict(model, userInputMatrix)
  outputDF <- as.data.frame(prediction)
  #checking it with 4.5 as most of the reviews are actually, with the right proportion
  #The rating is high even if it is a negative comment and vice versa ,so we consider
  #the most frequent rating in this case to decide.
  if(prediction >= 4.5){
    outputDF$Class <- "Positive Review"
  }else{
    outputDF$Class <- "Negative Review"
  }
  return(outputDF)
}

#function to find the user desired max words and plotting it.
generateBarChart <- function(data, maxWords) {
  data <- data %>%
    slice_max(freq, n = maxWords)
  plot_ly(data, x = ~word, y = ~freq, type = "bar") %>%
    layout(xaxis = list(title = "Word"), yaxis = list(title = "Frequency"))
}

#function to create the term matrix to plot the other graphs.
createDtm <- function() {
  corpus <- Corpus(VectorSource(df$review))
  corpus <- tm_map(corpus, content_transformer(tokenize))
  dtm <- DocumentTermMatrix(corpus)
  return(dtm)
}

# Define server function
shinyServer(function(input, output) {
  
  output$aboutText <- renderText({
    textAbout <- "As I am interested in travelling , I always wondered which flight to choose for, my travel.
    I tend to see and observe the reviews for various flights.
    But one of my dearest colleague has suggested me to choose a british airways for my travel.
    The Lounge access, food, hospitality and the seating, I always wanted to make sure on this,
    So I have gone through a plethora of website data to verify the same and I came across a very funny observation,
    the ratings given by the flyers and the review actually would not be matching and also some of the times, the person
    writing the review wouldn't even travel in the flight.So I wanted to see how many of the reviews were negative and how
    how many are positive and I have trained this model on a svm classifier,A support vector machine (SVM) is a deep learning technique 
    that uses supervised learning to classify or predict data groups. Supervised learning systems in AI and machine learning give both 
    input and desired output data, which are labelled for classification.This is trained on the british airways reviews dataset.To determine if 
    this airlines is a good choice, similarly we can do this with other airlines review data and also with several different classifiers.
    "
  })
  
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  #Dataset description table
  output$table <- renderTable({
    as.data.frame(head(df))
  })
  
  #Defining the prediction
  output$prediction <- renderTable({
    if (input$submitbutton>0) { 
      # Get user inputs
      review <- input$userInputReview
      rating <- input$userInputRating
      status <- input$userInputStatus
      
      # Make prediction
      prediction <- handleUserInput(review, rating, status)
      
      # Return prediction as text
      return(table(prediction))
    }
  })
  
  output$wordFreq <- renderPlotly({
    dtm <- createDtm()
    wordFreq <- data.frame(sort(colSums(as.matrix(dtm)), decreasing = TRUE))
    names(wordFreq) <- "freq"
    wordFreq$word <- rownames(wordFreq)
    generateBarChart(wordFreq, input$wordFrequency)
  })
  
  output$barChart <- renderPlot({
    ggplot(data = df, aes(x = factor(rating))) +
      geom_bar() +
      xlab("Rating") +
      ylab("Number of Reviews")
  })
  
  output$pieChart <- renderPlotly({
    ratings <- factor(df$rating, levels = c(1:input$ratingCount))
    ratingCounts <- table(ratings)
    ratingPercents <- round((ratingCounts / sum(ratingCounts)) * 100, 2)
    pieChart <- plot_ly(labels = levels(ratings), values = ratingCounts, type = "pie", 
                        textinfo = "label+percent", textposition = "outside", label = "Rating counts ")
    return(pieChart)
  })
  
  output$histogramPlot <- renderPlot({
    ggplot(df[df$trip_verified == input$booleanTrip, ], aes(x = rating)) +
      geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
      labs(x = "Rating", y = "Count", title = "Histogram of Ratings")
  })
})
