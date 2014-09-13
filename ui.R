library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(
        h3("Value Based Triangle Testing")),
  
  # Side Bar Panel for Inputs
  sidebarPanel(
          
          h5("Enter Inputs"),
          
          numericInput("nCorrect", 
                       "Correct:",  
                       value = 40),
          
          numericInput("nTotal", 
                       "Total Judgements:",  
                       value = 100),
          
          numericInput("units", 
                       "Units (Volume):",  
                       value = 10000),
          
          numericInput("profitPerUnit", 
                       "Profit Per Unit:",  
                       value = 1),
          
          numericInput("savingsPerUnit", 
                       "Savings Per Unit:",  
                       value = 0.1),
          
          sliderInput("pr", 
                      "Proportion of Detectors Who Reject:",  
                      value = 0.25,
                      min=0,
                      max=1,
                      step=0.05)
          
          
  ),
  
  # Show Plot
  mainPanel( 
          
          tabsetPanel(  
                  
                  tabPanel("Directions",
                           
                           tags$strong("Background"),
                           tags$br(),tags$br(),
                           tags$p("Triangle tests are used by consumer packaged goods companies to help determine if changes to a product are detectable.  For example, if a company
                                  changes an ingredient, the process, or the package (to reduce costs), it may wish to determine if consumers notice.  
                                  Triangle participants receive 2 samples that are the same, and 1 that is different, or 'odd'.  They are then asked to identify the odd sample.
                                  The number of people who correctly identify the odd sample helps determine if the change can be detected."),
                           tags$br(),
                           
                           tags$strong("Enter Inputs in Side Panel"),
                           tags$br(),tags$br(),
                           tags$ol(
                                   tags$li("Correct: # of Test Participants Who Correctly ID the Odd Sample"), 
                                   tags$li("Total Judgements: # of Total Test Participants"), 
                                   tags$li("Units: Number Packages, LBS, Etc Currently Sold"),
                                   tags$li("Profit Per Unit: $$$ Profit Per Unit Sold"),
                                   tags$li("Savings Per Unit: $$$ Saved Per Unit if Change Implemented"),
                                   tags$li("Proportion of Detectors Who Reject: % of People Who Truly Detect a Difference AND Will No Longer Purchase Due to the Change")
                                   
                           ),
                           
                           tags$br(),
                           tags$strong("Observe Outputs in Plot and Table Summary Tabs (Above)"),
                           tags$br(),tags$br(),
                           tags$ol(
                                   tags$li("Plot: Displays Likelihood vs. Possible Monetary Values to the Company.  The Area Shaded Red Represents a Loss ($) to the Company."), 
                                   tags$li("Table Summary: Displays Expected Value (Most Likely $ Value) with Approximate 95% Lower and Upper Confidence Levels.")
                                   
                           )
                           
                  ),
                  tabPanel("Plot", plotOutput("myPlot")),
                  tabPanel("Table Summary", tableOutput("dfOut"))
    
                  
          ),
          tags$br(),
          helpText(a("Click Me", href="http://rpubs.com/statsmith/valuebasedtrianglepres", target="_blank"))
         
    )
  ))