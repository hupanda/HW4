#0 Initialize environment and global variable ====
options( scipen = 0 )
options( digits = 5 )
setwd(dirname(parent.frame(2)$ofile))
# source("SupportFunction.R")
# source("Analyzer.R")

#1 Get raw data and initialize result table ====
rawData <- read.table("d_logret_16stocks.txt", sep="\t", header=TRUE)
#%Date  AIG	AmerExp	ATT	Boeing	Disney	DuPont	GenMotor	HomeDepot	HP	IBM	JPMorgan	McDonald	Merck	Microsoft	Verison	Walmart
#rawData <- rawData[,c("SYMBOL","DATE","TIME","PRICE","SIZE","EX")]
print(colnames(rawData))
#2 Get the stats for each ticker
# tickerList <- getTickerList()
# for (ticker in tickerList)
# {
#   
#   #3 Get the data for the ticker
#   #data <- rawData[rawData$SYMBOL == ticker,c("DATE","TIME","PRICE","EX","SIZE")]
#   
#   #4 Init result tables
#   #dateList <- unique(data[,c('DATE')])
#   resultTable_volume = initResultTable("generic")
# 
#   #5 Loop through date to get stats
# #   for (date in dateList)
# #   {
# #     subData <- data[data$DATE == date, c("TIME","PRICE","SIZE")]
# #     resultTable_frequency = analyzer(resultTable_frequency, subData, "frequency", interval, startTime, endTime, intervalUnit)
# #   }
# #     write.csv(file=paste(ticker,"_v",".csv",sep=""), x=resultTable_volume)
# }