

install.packages("jsonlite")

library(jsonlite)

install.packages("dplyr ")
library(dplyr)

json_text<-fromJSON("D://GitHub/Rproject/export.json")

filt <-json_text%>% group_by(unitName)%>%summarize(sum_Amount=sum(as.numeric(trafficAmout)))


barplot(sum_Amount~unitName,data = filt,xlab = "cityName",ylab = "traffic", space=0.01,beside=true, las=2 )


install.packages("knitr")
