getTickerList <- function()
{
  return(c("F","GE","TM","HMC"))
}

getColorList <- function()
{
  return(c("blue","red","green","pink","brown","orange","purple"))
}

initResultTable <- function(tableName)
{
  if(tableName == "generic")
  {
    return(data.frame(startTime = character(), value = numeric()))
  }
}

weekdayTest <- function(inputDate, weekday)
{
  formattedDate = as.POSIXlt(toString(inputDate), format='%Y%m%d', origin="1960-01-01")
  if(formattedDate$wday ==  weekday)
  {
    return(TRUE)
  }
  return(FALSE)
}

monthTest <- function(inputDate, weekday)
{
  formattedDate = as.POSIXlt(toString(inputDate), format='%Y%m%d', origin="1960-01-01")
  if(formattedDate$mon ==  weekday)
  {
    return(TRUE)
  }
  return(FALSE)
}

addTime <- function(time, interval, intervalUnit)
{
  if(intervalUnit == "S")
  {
    time$sec = time$sec + interval 
  }
  if(intervalUnit == "M")
  {
    time$min = time$min + interval
  }
  if(intervalUnit == "H")
  {
    time$hour = time$hour + interval
  }
  return(time)
}

mergeResult <- function(mainTable, subTable, method)
{
  print("In mergeResult")
  if(nrow(mainTable) == 0)
  {
    return(subTable)
  }
  else
  {
    if(method == "+")
    {
      mainTable$value = mainTable$value + subTable$value
    }
    if(method == "*")
    {
      mainTable$value = mainTable$value * subTable$value
    }
    return(mainTable)
  }
}

PortfolioSRByDay <- function(weight)
{
  tickerList= getTickerList()
  
  inputData = matrix(0,1,1)
  
  for(i in 1:length(tickerList))
  {
    price= read.csv(paste(tickerList[i], "_c1", ".csv", sep = ""), header= TRUE)
    if(sum(inputData) == 0)
    {
      inputData = matrix(0, (nrow(price)-1), length(tickerList))
    }
    inputData[, i] = (price[2:nrow(price),3]/price[1:(nrow(price)-1),3]) - 1
  }
  
  return(ProfolioSharpeRatio(weight,inputData))                     
}

PortfolioSRByInterval <- function(weight)
{
  tickerList= getTickerList()
  
  inputData = matrix(0,1,1)
  
  for(i in 1:length(tickerList))
  {
    price= read.csv(paste(tickerList[i], "_b1", ".csv", sep = ""), header= TRUE)
    if(sum(inputData) == 0)
    {
      inputData = matrix(0, (nrow(price)-1), length(tickerList))
    }
    inputData[, i] = (price[2:nrow(price),3]/price[1:(nrow(price)-1),3]) - 1
  }
  
  return(ProfolioSharpeRatio(weight,inputData))                     
}