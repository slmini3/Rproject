#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(jsonlite)
library(dplyr)
library(plyr)
library(ggplot2)

json_text2<-fromJSON("C://Users/user01/Documents/export.json")

filt2 <-ddply(json_text2,.(unitName,unitCode,routeName),summarise,amount=sum(as.numeric(trafficAmout)))
knitr::opts_chunk$set(fig.width = 5, fig.asp = 1/3)

par("mar")
par(mar=c(1,1,1,1))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("trafficAmount"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            helpText("고속도로"),
            selectInput(inputId="title",
                      label = "도로마다 검색",
                      choices = c("경부선","남해제2지선","광주대구선","중부내륙선","동해선","남해선A"
                                  ,"서울춘천선","중부선-대전통영선A","호남선지선","당진상주선"
                                  ,"서해안선","호남선A","영동선","평택-음성선","평택시흥선","중앙선지선"
                                  ,"영동선(동군포)","서천공주선","함양울산선","수도권제2순환선"
                                  ,"새만금포항선","평택화성선","대전남부순환선","용인서울선","중부내륙선지선A"),
                      selected = "경부선"),
            plotOutput("ggplot2")
        ),

        # Show a plot of the generated distribution
        mainPanel(DT::dataTableOutput("table"))
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$ggplot2 <- renderPlot({
        #hist(rnorm(input$num), main = input$title)
        result <- input$title
        
        data <- switch (result,
            "경부선" = filt2<-subset(filt2, routeName =="경부선"),
            "남해제2지선" = filt2<-subset(filt2, routeName =="남해제2지선"),
            "광주대구선" = filt2<-subset(filt2, routeName =="광주대구선"),
            "중부내륙선" = filt2<-subset(filt2, routeName =="중부내륙선"),
            "동해선" = filt2<-subset(filt2, routeName =="동해선"),
            "남해선A" = filt2<-subset(filt2, routeName =="남해선A"),
            "서울춘천선" = filt2<-subset(filt2, routeName =="서울춘천선"),
            "중부선-대전통영선A" = filt2<-subset(filt2, routeName =="중부선-대전통영선A"),
            "호남선지선" = filt2<-subset(filt2, routeName =="호남선지선"),
            "당진상주선" = filt2<-subset(filt2, routeName =="당진상주선"),
            "서해안선" = filt2<-subset(filt2, routeName =="서해안선"),
            "호남선A" = filt2<-subset(filt2, routeName =="호남선A"),
            "영동선" = filt2<-subset(filt2, routeName =="영동선"),
            "평택-음성선" = filt2<-subset(filt2, routeName =="평택-음성선"),
            "평택시흥선" = filt2<-subset(filt2, routeName =="평택시흥선"),
            "중앙선지선" = filt2<-subset(filt2, routeName =="중앙선지선"),
            "영동선(동군포)" = filt2<-subset(filt2, routeName =="영동선(동군포)"),
            "서천공주선" = filt2<-subset(filt2, routeName =="서천공주선"),
            "함양울산선" = filt2<-subset(filt2, routeName =="함양울산선"),
            "수도권제2순환선" = filt2<-subset(filt2, routeName =="수도권제2순환선"),
            "새만금포항선" = filt2<-subset(filt2, routeName =="새만금포항선"),
            "평택화성선" = filt2<-subset(filt2, routeName =="평택화성선"),
            "대전남부순환선" = filt2<-subset(filt2, routeName =="대전남부순환선"),
            "용인서울선" = filt2<-subset(filt2, routeName =="용인서울선"),
            "중부내륙선지선A" = filt2<-subset(filt2, routeName =="중부내륙선지선A")
        )
        
        ggplot(data=filt2, mapping = aes(x=unitName, y=amount))+geom_col(colour="blue")+labs(x=result, y="traffic Amount")
    
        })
    
    output$table <-  DT::renderDataTable(DT::datatable({
        result <- input$title
        
        filt2<-filt2 %>% 
            arrange(unitName)%>% 
            head(length(filt2$unitName))%>%
            select(unitName,unitCode,routeName,amount)
        
        data <- switch (result,
                        "경부선" = filt2<-subset(filt2, routeName =="경부선"),
                        "남해제2지선" = filt2<-subset(filt2, routeName =="남해제2지선"),
                        "광주대구선" = filt2<-subset(filt2, routeName =="광주대구선"),
                        "중부내륙선" = filt2<-subset(filt2, routeName =="중부내륙선"),
                        "동해선" = filt2<-subset(filt2, routeName =="동해선"),
                        "남해선A" = filt2<-subset(filt2, routeName =="남해선A"),
                        "서울춘천선" = filt2<-subset(filt2, routeName =="서울춘천선"),
                        "중부선-대전통영선A" = filt2<-subset(filt2, routeName =="중부선-대전통영선A"),
                        "호남선지선" = filt2<-subset(filt2, routeName =="호남선지선"),
                        "당진상주선" = filt2<-subset(filt2, routeName =="당진상주선"),
                        "서해안선" = filt2<-subset(filt2, routeName =="서해안선"),
                        "호남선A" = filt2<-subset(filt2, routeName =="호남선A"),
                        "영동선" = filt2<-subset(filt2, routeName =="영동선"),
                        "평택-음성선" = filt2<-subset(filt2, routeName =="평택-음성선"),
                        "평택시흥선" = filt2<-subset(filt2, routeName =="평택시흥선"),
                        "중앙선지선" = filt2<-subset(filt2, routeName =="중앙선지선"),
                        "영동선(동군포)" = filt2<-subset(filt2, routeName =="영동선(동군포)"),
                        "서천공주선" = filt2<-subset(filt2, routeName =="서천공주선"),
                        "함양울산선" = filt2<-subset(filt2, routeName =="함양울산선"),
                        "수도권제2순환선" = filt2<-subset(filt2, routeName =="수도권제2순환선"),
                        "새만금포항선" = filt2<-subset(filt2, routeName =="새만금포항선"),
                        "평택화성선" = filt2<-subset(filt2, routeName =="평택화성선"),
                        "대전남부순환선" = filt2<-subset(filt2, routeName =="대전남부순환선"),
                        "용인서울선" = filt2<-subset(filt2, routeName =="용인서울선"),
                        "중부내륙선지선A" = filt2<-subset(filt2, routeName =="중부내륙선지선A")
        )
    }))
}

# Run the application 
shinyApp(ui = ui, server = server)
