.libPaths("D:/GitHub/Packages")

install.packages("jsonlite")

install.packages("knitr")
install.packages("flexdashboard")
install.packages("dplyr ")

library(jsonlite)

library(dplyr)

json_text<-fromJSON("D://GitHub/Rproject/export.json")

filt <-json_text%>% group_by(unitName)%>%summarize(sum_Amount=sum(as.numeric(trafficAmout)))


barplot(sum_Amount~unitName,data = filt,xlab = "cityName",ylab = "traffic", space=0.01,beside=true, las=2 )

