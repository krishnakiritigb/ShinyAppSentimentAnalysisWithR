# ShinyAppSentimentAnalysisWithR
This project is an interactive R Shiny web application that performs sentiment analysis on airline reviews. Motivated by inconsistencies between customer ratings and written reviews, the app classifies user-submitted or dataset-based reviews of British Airways into positive or negative sentiment.


# Sentiment Analysis on British Airways Reviews  

An interactive **R Shiny** web application that performs **sentiment analysis** on British Airways customer reviews. The model uses a **Support Vector Machine (SVM)** classifier to categorize reviews as **positive** or **negative**, helping travelers make informed decisions.  

---

## Background  

Sentiment Analysis is a sub-domain of **Natural Language Processing (NLP)** that applies machine learning and computational linguistic tools to identify the **feeling or emotion** behind text. It is also known as **opinion mining**.  

The primary goal is to analyze whether a review expresses:  
- 😊 Positive sentiment  
- 😠 Negative sentiment  
- 😐 Neutral sentiment  

The dataset (sourced from **Kaggle**) contains British Airways reviews, including **titles, reviews, ratings, trip verification, and more**. This project focuses on classifying reviews into positive or negative sentiment.  

---

##  Dataset  

**Source**: [Kaggle – British Airways Reviews](https://www.kaggle.com/)  

Key columns used in this analysis:  

| Column              | Type         | Description                                                                 |
|---------------------|--------------|-----------------------------------------------------------------------------|
| Title               | Nominal      | Short text describing the review.                                           |
| Rating              | Quantitative | Customer rating (1–10 scale).                                               |
| Review_date         | Date         | Date on which the review was published.                                     |
| Review              | Nominal      | Written review text.                                                        |
| Trip_Verified       | Boolean      | Whether the reviewer actually traveled with BA (True/False).                |
| Aircraft            | Quantitative | Aircraft type (e.g., Boeing-777).                                           |
| Type_of_traveller   | Categorical  | Category of the traveler.                                                   |
| Seat_type           | Categorical  | Economy, Premium Economy, Business, or First Class.                         |
| Route               | Nominal      | Flight route (origin, layovers, destination).                               |
| Date_flown          | Date         | Date of travel.                                                             |
| Seat_comfort        | Quantitative | Rating of seat comfort.                                                     |
| Cabin_staff_service | Quantitative | Rating of cabin staff.                                                      |
| Food_and_beverages  | Quantitative | Rating of food & drinks.                                                    |
| Ground_service      | Quantitative | Rating of airport ground services.                                          |
| Value_for_money     | Quantitative | Rating for money spent vs service quality.                                  |
| Wifi_and_connectivity | Quantitative | Rating for in-flight Wi-Fi.                                               |
| Recommend           | Boolean      | Whether the traveler recommends the airline.                                |

---

##  Model – Support Vector Machine (SVM)  

We used **Support Vector Machine (SVM)** as the classifier.  

- **Supervised learning algorithm** trained on labeled data (positive/negative reviews).  
- Finds a **hyperplane** that best separates the two classes.  
- Supports both **linear and nonlinear classification** using kernels (linear, polynomial, RBF, sigmoid).  
- Optimized with **hyperparameter tuning** and tested for accuracy.  

**Steps Involved**  
1. Data Preprocessing  
2. Feature Selection  
3. Training Data Selection  
4. Model Training  
5. Model Evaluation  
6. Hyperparameter Tuning  
7. Prediction  

---

## Purpose  

The main objective is to build a system that can:  

- Classify reviews as **positive** or **negative**, regardless of numeric rating inconsistencies.  
- Help travelers decide if the **flying experience is worth the cost**.  
- Provide airlines (like British Airways, Uber, DoorDash, etc.) with tools to **filter fake/misaligned reviews** and improve their services.  

Example anomaly:  
A user wrote, *“Worst flight ever”* but still gave a rating of **8/10**. Such inconsistencies can affect decision-making. Our classifier corrects this by focusing on **review text + rating authenticity**.  

---

## Shiny App Structure  

The app consists of multiple pages with the following functionality:  

1. **About** – Purpose of the project.  
2. **Data Description** – Shows dataset details and columns.  
3. **Review Classification** – User inputs a review, and the model predicts **positive** or **negative** sentiment.  
4. **Visualizations** – Interactive charts:  
   - Review ratings distribution  
   - Word frequency  
   - Bar chart, pie chart, histogram (based on trip status)  

---

## Live Demo  

 Hosted App: [Shiny App Link](https://kiritigb0784325.shinyapps.io/TermProject/)  

---

## References  

1. [Pluralsight – Machine Learning Text Data Using R](https://www.pluralsight.com/guides/machine-learning-text-data-using-r)  
2. [Intro to Shiny Layouts](https://www.bioinformatics.babraham.ac.uk/shiny/Intro_to_Shiny_course/examples/04.1_layouts/)  
3. [Kaggle – Sentiment Analysis Tutorial in R](https://www.kaggle.com/code/rtatman/tutorial-sentiment-analysis-in-r/notebook)  

---

## Future Improvements  

- Extend to **other airlines** datasets.  
- Experiment with **other classifiers** (Naive Bayes, Logistic Regression, Neural Networks).  
- Build a **generalized review sentiment dashboard** for multiple domains (flights, hotels, products).  

---

##  Tech Stack  

- **Language**: R  
- **Framework**: Shiny  
- **ML Libraries**: caret, e1071  
- **Visualization**: ggplot2  

---

## Documentation
[Project Documentation](https://docs.google.com/document/d/1WPrZn-2k77Cy9NKoktPjpAAx1atetotBH9tsRoT06LI/edit?usp=sharing)
