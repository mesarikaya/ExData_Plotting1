## The working directory should be set where the data file is located. Steps of the logic are as follows:
## 1. The file is retrieved from that location and processed
## 2. First data is read via read.table function
## 3. The not available data is removed
## 4. Date and time are being reprocessed
## 5. Data is limited for the period we are interested
## 6. Data plot is created and output is given as png

plot2<- function()
        
{
        setwd("C:/Users/sarikaya.me/Desktop/Trainings/Data Science Training/Explanatory Data Analysis/Course Project 1")
       ## Read The file from the location 
        filelocation<-paste(getwd(),"household_power_consumption.txt",sep="/") 
        data<-read.table(filelocation,stringsAsFactors=FALSE,sep=";",na.strings="?",header=TRUE)
       ## Remove not available data
        data<-as.data.frame(data,na.rm=TRUE)
       ## Reformat dates
        data$newDateStamp<-paste(data$Date,data$Time, sep=" ")
        data$newDateStamp<-strptime(data$newDateStamp, format="%d/%m/%Y %H:%M:%S")
        data$Date<-strptime(data$Date, format="%d/%m/%Y")
       ## Limit the data
        data<-subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")
        data[,1]<-weekdays(data[,1])
       ## Plot the graph
        plot(data.frame(data$newDateStamp,data$Global_active_power),type= "l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.copy(png,file="plot2.png")
        dev.off()
}
