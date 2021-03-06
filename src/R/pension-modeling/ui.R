library(shiny)
library(ggplot2)

start_year = 2014

ui <- shinyUI(fluidPage(
  
  titlePanel(p("Illinois Pension Modeling",align="center")),br(),
  
  sidebarPanel(
    #selectInput('proposal',"Proposal",choices=c("Rauner June 2015"=1,"Madigan July 2015"=2,"Rahm August 2015"=3,"Federal Bailout"=4), selected=1),hr(),
    sliderInput('npers',"Years in Forecast",10,100,30,step=5),
    sliderInput('ror',"Rate of Return",0,10,5,step=0.5),
    sliderInput('ben',"Benefit Growth Rate", 0, 10, 3,step=0.5),
    sliderInput('cont',"Contribution Rate", 0, 10, 2, step=0.5),
    sliderInput('salary',"Salary Growth Rate", 0, 10, 3.5, step=0.5),
    sliderInput('inf',"Inflation Rate",0,10,3,step=0.5),
    sliderInput('rr',"Replacement Rate",0, 2, 0, step=0.05),
    sliderInput('tfr',"Target Funding Ratio", 0, 120, 100,step=5),
    width = 3
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Wealth",br(),hr(),h3(textOutput('pensionAssets')),h3(textOutput('fundingRatio'))
               ,h3(textOutput('contributionTarget'))
               ,hr(),br(),h3("Pension Wealth by Year",align='center')
               ,plotOutput('wealthPlot')
               # By component of wealth distribution show the flows
               ,br(),br(),h3("Wealth Flows by Year",align='center')
               ,plotOutput('wealthflowPlot')
               ),
      tabPanel("Population",br(),
               uiOutput("timeSlider"),hr(),
               h3("Active Population Distribution",align="center"),
               plotOutput('active_plot'),br(),
               h3("Beneficiary Population Distribution",align="center"),
               plotOutput('beneficiary_plot'),br(),
               h3("New Beneficiary Population Distrubition",align="center"),
               plotOutput('new_beneficiary_plot'),br(),
               # plotOutput('salary_plot'),br(),
               h3("Benefits Distribution",align="center"))
               # plotOutput('ben_plot'),br(),br())
      ,tabPanel("Valuation Details",br(),h3("Results of Actuarial Valuation", align="center"),
               br(),tableOutput('details'),align="center")
      ,tabPanel("Downloads",br(),selectInput('forecastData',"Select Forecast",choices=c("Annuitant Forecast" = 1, "Avg Annuitant Benefits" = 2, "Actives Forecast" = 3, "New Beneficiaries" = 4),selected=1),br(),
                downloadButton('downloadData','Download'))
    )
  )
))
