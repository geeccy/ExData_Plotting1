#Using the tidyverse libraries
library(tidyverse)
library(lubridate)

#Extract whole dataset from text file
data <- read.csv("household_power_consumption.txt", sep=";")

#create data slice for analysis
dataSample <- data %>% 
  mutate(Date = dmy(Date)) %>% 
  mutate(Time = hms(Time)) %>% 
  mutate(Global_active_power = as.numeric(Global_active_power)) %>% 
  mutate(Global_reactive_power  = as.numeric(Global_reactive_power)) %>% 
  mutate(Voltage  = as.numeric(Voltage)) %>% 
  mutate(Global_intensity = as.numeric(Global_intensity)) %>% 
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>% 
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) 

#Take only required dates  
dataSample <- filter(dataSample, (Date == dmy("01/02/2007")|Date==ymd("2007-02-02"))) 
dataSample <- mutate(dataSample, DateTime = Date + Time)

#Remove NA values
dataSample <- dataSample[complete.cases(dataSample),]


#output to png
png("plot4.png")


#set up 2x2 plotting area
par(mfcol = c(2,2))

#top left chart
  plot(dataSample$Global_active_power ~ dataSample$DateTime, type="l", 
       ylab = "Global Active Power",xlab = "")


#bottom left chart
  plot(dataSample$Sub_metering_1 ~ dataSample$DateTime, type="n", 
       xlab="", ylab="Energy Sub metering")
  
  #Add lines
  lines(dataSample$Sub_metering_1 ~ dataSample$DateTime)
  lines(dataSample$Sub_metering_2 ~ dataSample$DateTime, col="red")
  lines(dataSample$Sub_metering_3 ~ dataSample$DateTime, col="blue")
  
  #Add legend
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"),
         lwd = 2)

#top right chart
  plot(dataSample$Voltage ~ dataSample$DateTime, type="l", 
       ylab = "Voltage",xlab = "datetime")
  
  
#bottom right chart
  plot(dataSample$Global_reactive_power ~ dataSample$DateTime, type="l", 
       ylab = "Global_reactive_power",xlab = "datetime")
  
  
dev.off()

