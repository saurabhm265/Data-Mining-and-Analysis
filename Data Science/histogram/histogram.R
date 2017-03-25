if("RMySQL" %in% rownames(installed.packages()) == FALSE) 
{install.packages("RMySQL")}

if("lattice" %in% rownames(installed.packages()) == FALSE) 
{install.packages("lattice")}

library(lattice)
library(RMySQL)

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
               men_total,women_total
               FROM rkhadse.OnCampusArrest  
               UNION ALL
               SELECT 
               men_total,women_total
               FROM rkhadse.NonCampusArrest  
            ")

sqlquery<-dbEscapeStrings(con, tmp)

result <- dbGetQuery(con, tmp)
dbDisconnect(con)
head(result)
histogram(
    x = ~women_total,
    data = result,
    main = "Histogram of Women Population in Data")

histogram(
  x = ~men_total,
  data = result,
  main = "Histogram of Men Population in Data")