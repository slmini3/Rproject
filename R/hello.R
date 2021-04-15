install.packages("jsonlite")

library(jsonlite)

install.packages("dplyr ")
library(dplyr)

install.packages("httr")

library(httr)

df_repos <-fromJSON("http://data.ex.co.kr/openapi/trafficapi/trafficAll?key=3079548252&type=json")

str(df_repos)
names(df_repos$trafficAll)
df_repos$trafficAll[1:39,"tmType"]

tf_amout<-df_repos$trafficAll[1:39,"trafficAmout"]
div_code<-df_repos$trafficAll[1:39,"exDivCode"]

json_text <-fromJSON("C:/users/dkacj/OneDrive/문서/새 폴더/ex3.json")

unitName<-json_text$list[1:156,"unitName"]

print(head(json_text))

filt_data = data.frame(json_text$list)
filt_data
print(head(filt_data))
head(filt_data)
plot(filt_data$unitCode,filt_data$trafficAmout,xlab= "station", ylab= "amount")

filter(filt_data$unitName~filt_data$trafficAmout)

row.names(filt_data)<-filt_data$unitName~filt_data$trafficAmout

barplot(filt_data$unitName~filt_data$trafficAmout)

install.packages("jsonlite")

library(jsonlite)

install.packages("dplyr ")
library(dplyr)

json_text<-fromJSON("C:/Users/dkacj/OneDrive/BigData/traffic/Rocket/export.json")

filt <-json_text%>% group_by(unitName)%>%summarize(sum_Amount=sum(as.numeric(trafficAmout)))


barplot(sum_Amount~unitName,data = filt,xlab = "cityName",ylab = "traffic", space=0.01,beside=true, las=2 )
