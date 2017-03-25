
if("RMySQL" %in% rownames(installed.packages()) == FALSE) 
{install.packages("RMySQL")}

if("psych" %in% rownames(installed.packages()) == FALSE) 
{install.packages("psych")}

if("ggplot2" %in% rownames(installed.packages()) == FALSE) 
{install.packages("ggplot2")}

library(RMySQL)
library(psych)
library(ggplot2)

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
               FROM rkhadse.vwNonCampusArrestVsPopulation AS NonCampusArrests ")
sqlquery<-dbEscapeStrings(con, tmp)

result <- dbGetQuery(con, tmp)
dbDisconnect(con)
head(result)
plot(ArrestRate~Total,result)
result.kmeans <- kmeans(result,centers = 2);
result.kmeans$centers
result.kmeans$cluster

plot(
  result[result.kmeans$cluster==1,],col="red",main="Sorting Non-Campus Arrest Rate with k-means",xlab="Total non-campus population",ylab ="Arrest Rate (per 100,000 people)")

points(result[result.kmeans$cluster==2,], col="blue")

#As Arrest Rate clusters towards positive infinity we can conclude that 
#Non campus arrest rate is higher when population is high
#Two Dividing clusters clearly shows that private and public 
#institution's (with large population) non-campus lack 
#enough security infrastructure and planning to handle 
#large population
#because of that arrrest rate is higher