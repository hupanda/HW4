analyzer <- function(resultTable, data, analyzerName, interval, startTime, endTime, intervalUnit)
{
  intervalStartTime = startTime
  
  if(analyzerName == "tickTime")
  {
    data <- data[data$TIME >= startTime & data$TIME < endTime, ]
    newData <- data[1,]
    for(i in 2:nrow(data))
    {
      if(data$PRICE[i] != data$PRICE[i-1])
      {
        newData = rbind(newData, data[i,])
      }
    }
    data = newData
  }
  
  if(analyzerName == "duration" | analyzerName == "durationSum" | analyzerName == "tickTime")
  {
    data <- data[data$TIME >= startTime & data$TIME < endTime, ]
    n = nrow(data)
    data$PRICE[2:n] = as.numeric(data$TIME[2:n] - data$TIME[1:(n-1)])
    data$PRICE[1] = as.numeric(data$TIME[1] - startTime)
  }
  
  while(intervalStartTime < endTime)
  {
    intervalEndTime = addTime(intervalStartTime, interval, intervalUnit)
    subData <- data[data$TIME >= intervalStartTime & data$TIME < intervalEndTime, ]
    if(analyzerName == "frequency")
    {
      value = getFrequency(subData)
    }
    if(analyzerName == "price")
    {
      value = getLastPrice(subData, resultTable)
    }
    if(analyzerName == "duration" | analyzerName == "tickTime")
    {
      value = getDuration(subData)
    }
    if(analyzerName == "avgPrice")
    {
      value = getAvgPrice(subData)
    }
    if(analyzerName == "closingPrice")
    {
      value = getLastPrice(subData, resultTable)
    }
    if(analyzerName == "durationSum")
    {
      value = getDurationSum(subData)
    }
    if(analyzerName == "volume")
    {
      value = getVolume(subData)
    }
    resultTable = rbind(resultTable, data.frame(startTime = substr(intervalStartTime, 12, 19), value))
    intervalStartTime = intervalEndTime
  }
  return(resultTable)
}

getFrequency <- function(data)
{
  if(nrow(data) > 0)
  {
    return(nrow(data))
  }
  else
  {
    return(0)   
  }
}

getLastPrice <- function(data, resultTable)
{
  if(nrow(data) > 0)
  {
    return(data$PRICE[nrow(data)])
  }
  else
  {
    if(nrow(resultTable) == 0)
    {
      return(0)
    }
    else
    {
      return(resultTable$value[nrow(resultTable)])
    }  
  }
}

getDuration <- function(data)
{
  return(mean(data$PRICE))
}

getDurationSum <- function(data)
{
  return(sum(data$PRICE))
}

getAvgPrice <- function(data)
{
  if(nrow(data) > 0)
  {
    return(mean(data$PRICE))  
  }
  return(0)
}

getVolume <- function(data)
{
  if(nrow(data) > 0)
  {
    return(sum(data$SIZE))  
  }
  return(0)
}
