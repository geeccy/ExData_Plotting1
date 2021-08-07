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
png("plot2.png")

#Create line plot
plot(dataSample$Global_active_power ~ dataSample$DateTime, 
     type="l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")


dev.off()

