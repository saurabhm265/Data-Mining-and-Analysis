if("RMySQL" %in% rownames(installed.packages()) == FALSE) 
{install.packages("RMySQL")}

library(RMySQL)

if("ggplot2" %in% rownames(installed.packages()) == FALSE) 
{install.packages("ggplot2")}

#library(ggplot2)

con <- dbConnect(MySQL(),
                 user = 'rohitsaurabh',
                 password = 'rohit1991',
                 host = '50.62.209.88',
                 dbname='rkhadse')

tmp <- sprintf("
SELECT 
    'On Campus' as Category,
               CASE
               WHEN SUM(Total) = 0 THEN 0
               ELSE SUM(WEAPON10 + DRUG10 + LIQUOR10 + WEAPON11 + DRUG11 + LIQUOR11 + WEAPON12 + DRUG12 + LIQUOR12) * 100000 / SUM(Total)
               END AS ArrestRate
               FROM
               rkhadse.OnCampusArrest
               union ALL 
               SELECT 
               'Non Campus' as Category,
               CASE
               WHEN SUM(Total) = 0 THEN 0
               ELSE SUM(WEAPON10 + DRUG10 + LIQUOR10 + WEAPON11 + DRUG11 + LIQUOR11 + WEAPON12 + DRUG12 + LIQUOR12) * 100000 / SUM(Total)
               END AS ArrestRate
               FROM
               rkhadse.NonCampusArrest")

sqlquery<-dbEscapeStrings(con, tmp)

result <- dbGetQuery(con, tmp)
dbDisconnect(con)
head(result)

# Pie Chart with Percentages
slices <- result$ArrestRate
lbls <- result$Category
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Average Arrest Rate")
