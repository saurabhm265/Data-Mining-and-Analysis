
if("RMySQL" %in% rownames(installed.packages()) == FALSE) 
{install.packages("RMySQL")}

if("psych" %in% rownames(installed.packages()) == FALSE) 
{install.packages("psych")}

if("ggplot2" %in% rownames(installed.packages()) == FALSE) 
{install.packages("ggplot2")}

library(RMySQL)
#library(psych)
#library(ggplot2)

con <- dbConnect(MySQL(),
                 user = 'rohitsaurabh',
                 password = 'rohit1991',
                 host = '50.62.209.88',
                 dbname='rkhadse')
#summary(con)
#dbGetInfo(con)
#dbListResults(con)
#dbListTables(con)
tmp <- sprintf("
               SELECT 
               Total,ArrestRate  AS ArrestRate
               FROM rkhadse.vwOnCampusArrestVsPopulation AS OnCampusArrests ")

sqlquery<-dbEscapeStrings(con, tmp)

result <- dbGetQuery(con, tmp)
dbDisconnect(con)
head(result)
plot(ArrestRate~Total,result)
result.kmeans <- kmeans(result,centers = 2);
result.kmeans$centers
result.kmeans$cluster

c1<- (result.kmeans$cluster==1)
c2<- result.kmeans$cluster==2

summary(result.kmeans)

cluster.stats(result.kmeans,c1,c2)

plot(
  result[result.kmeans$cluster==1,],col="red",main="Sorting On-Campus Arrest Rate with k-means",xlab="Total on-campus population",ylab ="Arrest Rate (per 100,000 people)")
points(result[result.kmeans$cluster==2,], col="blue")

#As Arrest Rate clusters towards positive zero we can conclude that 
#On campus arrest rate is higher when population is low
#Two Dividing clusters clearly shows that small private and public 
#institution's (with low population) on-campus lack 
#security infrastructure and planning. 
#because of that arrrest rate is higher