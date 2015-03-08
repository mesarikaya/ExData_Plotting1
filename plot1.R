## The working directory should be set where the data file is located. Steps of the logic are as follows:
## 1. The file is retrieved from that location and processed
## 2. First data is read via read.table function
## 3. Date and time are being reprocessed
## 4. Data is limited for the period we are interested
## 5. Data histogram is created and output is given as png

plot1<- function()
        
{
        setwd("C:/Users/sarikaya.me/Desktop/Trainings/Data Science Training/Explanatory Data Analysis/Course Project 1")
      ## read the data from the location
        filelocation<-paste(getwd(),"household_power_consumption.txt",sep="/") 
        data<-read.table(filelocation,stringsAsFactors=FALSE,sep=";",na.strings="?",header=TRUE)
      ##change the Date format
        data$Date<-strptime(data$Date, format="%d/%m/%Y")
        data$Time<-strptime(data$Time, "%H:%M:%S")
      ##select the dates we are interested
        data<-subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")
        hist(data[,"Global_active_power"],main="Global Active Power",col="red", xlab="Global Active Power (kilowatts)") 
        dev.copy(png,file="plot1.png")
        dev.off()
}
