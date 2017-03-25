if("RMySQL" %in% rownames(installed.packages()) == FALSE) 
{install.packages("RMySQL")}

if("maps" %in% rownames(installed.packages()) == FALSE) 
{install.packages("maps")}

if("maptools" %in% rownames(installed.packages()) == FALSE) 
{install.packages("maptools")}

if("sp" %in% rownames(installed.packages()) == FALSE) 
{install.packages("sp")}

library(RMySQL)
library(maps)
library(maptools)
library(sp)

con <- dbConnect(MySQL(),
                 user = 'rohitsaurabh',
                 password = 'rohit1991',
                 host = '50.62.209.88',
                 dbname='rkhadse')

tmp <- sprintf("
               SELECT 
               State,
               Case when SUM(Total)=0 then 0
               Else 
               FLOOR(SUM( WEAPON10 + DRUG10 + LIQUOR10 + WEAPON11 + DRUG11 + LIQUOR11 + WEAPON12 + DRUG12 + LIQUOR12) * 100000/SUM(Total)) END AS ArrestRate
               FROM rkhadse.NonCampusArrest
               where State != '' AND State IS NOT NULL
               GROUP BY State
               ORDER BY State")
sqlquery<-dbEscapeStrings(con, tmp)

result <- dbGetQuery(con, tmp)
dbDisconnect(con)
head(result)
textstate <- paste(result$State,collapse=" ")
textarrestrate <- paste(result$ArrestRate,collapse=" ")
combinedmapdata <- c(textstate, textarrestrate)
txt <- paste(combinedmapdata,collapse=" \n ")
txt
#txt <- "AB  AK  AL  AN  AR  AZ  CA  CO  CT  DC  DE  EN  FL  GA  HI  IA  ID  IL  IN  KS
#    1  21  31   1  12  56 316  53  31  16   7   1 335  63  11  42  29  73  40  2"

dat <- stack(read.table(text = txt,  header = TRUE))
names(dat)[2] <-'state.abb'
dat$states <- tolower(state.name[match(dat$state.abb,  state.abb)])

mapUSA <- map('state',  fill = TRUE,  plot = FALSE)
nms <- sapply(strsplit(mapUSA$names,  ':'),  function(x)x[1])
USApolygons <- map2SpatialPolygons(mapUSA,  IDs = nms,  CRS('+proj=longlat'))

idx <- match(unique(nms),  dat$states)
dat2 <- data.frame(value = dat$value[idx], state = unique(nms))
row.names(dat2) <- unique(nms)

USAsp <- SpatialPolygonsDataFrame(USApolygons,  data = dat2)

spplot(USAsp['value'],  xlab = "Heat Map of Non-Campus Arrest Rate across US", ylab = "Number of Arrests per 100,000 people")

