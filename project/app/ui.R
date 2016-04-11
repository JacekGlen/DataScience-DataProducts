# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(rCharts)

shinyUI(
  navbarPage("Storm Data Viewer",
             tabPanel("Plot",
                      sidebarPanel(
                        sliderInput("range", 
                                    "Range:", 
                                    min = 1950, 
                                    max = 2011, 
                                    value = c(2000, 2011)
                                    ),
                        uiOutput("evtypeControls"),
                        actionButton(inputId = "select_all", label = "Select all"),
                        actionButton(inputId = "clear_all", label = "None",)
                      ),
                      
                      mainPanel(
                        tabsetPanel(

                          # Data by state
                          tabPanel("Impact by state",
                                   column(7,
                                          plotOutput("populationImpactByState")
                                   )
                                   
                          ),
                          
                          # Time series data
                          tabPanel("Charts",
                                   h4('Number of events by year', align = "center"),
                                   showOutput("eventsByYear", "nvd3"),
                                   h4('Population impact by year', align = "center"),
                                   showOutput("populationImpact", "nvd3"),
                                   h4('Economic impact by year', align = "center"),
                                   showOutput("economicImpact", "nvd3")
                          ),
                          

                          # Data 
                          tabPanel("Raw Data",
                                   dataTableOutput(outputId="table"),
                                   downloadButton('downloadData', 'Download')
                          )
                        )
                      )
                      
             ),
             
             tabPanel("Help",
                      mainPanel(
                        includeMarkdown("About.md")
                      )
             )
  )
)