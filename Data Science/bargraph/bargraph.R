
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

sqlOnCampusArrest <- sprintf("
               SELECT 
               Case when SUM(Total)=0 then 0
               Else 
               SUM(
               WEAPON10 
               + DRUG10
               + LIQUOR10) * 100000/SUM(Total) END AS '2010',
               Case when SUM(Total)=0 then 0
               Else 
               SUM(
               + WEAPON11
               + DRUG11
               + LIQUOR11) * 100000/SUM(Total) END AS '2011',
               Case when SUM(Total)=0 then 0
               Else 
               SUM(
               + WEAPON12
               + DRUG12
               + LIQUOR12) * 100000/SUM(Total) END AS '2012'
               FROM rkhadse.OnCampusArrest ")


sqlNonCampusArrest <- sprintf("SELECT 

               Case when SUM(Total)=0 then 0   #Divide by zero error
               Else 
               SUM(
               WEAPON10 
               + DRUG10
               + LIQUOR10) * 100000/SUM(Total) END AS '2010',
               Case when SUM(Total)=0 then 0
               Else 
               SUM(
               + WEAPON11
               + DRUG11
               + LIQUOR11) * 100000/SUM(Total) END AS '2011',
               Case when SUM(Total)=0 then 0
               Else 
               SUM(
               + WEAPON12
               + DRUG12
               + LIQUOR12) * 100000/SUM(Total) END AS '2012'
               FROM rkhadse.NonCampusArrest  ; ") 

OnCampusArrest <- dbGetQuery(con, sqlOnCampusArrest)
NonCampusArrest <- dbGetQuery(con, sqlNonCampusArrest)
# Disconnect SQL Database
dbDisconnect(con)
OnCampusArrest
NonCampusArrest
Category = c("On Campus", "On Campus", "On Campus","Non Campus", "Non Campus", "Non Campus") 
Year = c(2010, 2011, 2012,2010, 2011, 2012)

ArrestRate = c(OnCampusArrest[1, 1] , OnCampusArrest[1, 2] ,OnCampusArrest[1, 3] ,NonCampusArrest[1, 1] , NonCampusArrest[1, 2] ,NonCampusArrest[1, 3] ) 
result <- data.frame(
  Category,
  Year, 
  ArrestRate
)
result


# Bar graph, time on x-axis, color fill grouped by  Category (NonCampus,Campus)
ggplot(data=result, aes(x=Year, y=ArrestRate, fill=Category)) +
  geom_bar(stat="identity", position=position_dodge())

# Stacked bar graph 
ggplot(data=result, aes(x=Year, y=ArrestRate, fill=Category)) +
  geom_bar(stat="identity")


