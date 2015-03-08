## The working directory should be set where the data file is located. Steps of the logic are as follows:
## 1. The file is retrieved from that location and processed
## 2. First data is read via read.table function
## 3. The not available data is removed
## 4. Date and time are being reprocessed
## 5. Data is limited for the period we are interested
## 6. Data plot is created and output is given as png

plot4<- function()
        
{
        setwd("C:/Users/sarikaya.me/Desktop/Trainings/Data Science Training/Explanatory Data Analysis/Course Project 1")
        # Retrieve the data from location
        filelocation<-paste(getwd(),"household_power_consumption.txt",sep="/") 
        data<-read.table(filelocation,stringsAsFactors=FALSE,sep=";",na.strings="?",header=TRUE)
        ##remove the not available data
        data<-as.data.frame(data,na.rm=TRUE)
        ##reformat the data
        data$newDateStamp<-paste(data$Date,data$Time, sep=" ")
        data$newDateStamp<-strptime(data$newDateStamp, format="%d/%m/%Y %H:%M:%S")
        data$Date<-strptime(data$Date, format="%d/%m/%Y")
        ##Limit the data
        data<-subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")
        data[,1]<-weekdays(data[,1])
        ## Output the data to png
        png(filename="plot4.png")
        par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,2,0,0))
        with(data,{
                plot(data.frame(data$newDateStamp,data$Global_active_power),type= "l", xlab="", ylab="Global Active Power")        
                plot(data.frame(data$newDateStamp,data$Voltage),type= "l", xlab="datetime", ylab="Voltage")
                with(data,plot(data.frame(data$newDateStamp,data$Sub_metering_1), type="n",xlab="",ylab="Energy sub meeting" ))
                lines(data.frame(data$newDateStamp,data$Sub_metering_1),col="black")
                lines(data.frame(data$newDateStamp,data$Sub_metering_2),col="red")
                lines(data.frame(data$newDateStamp,data$Sub_metering_3),col="blue")
                legend("topright", col= c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=2,cex=0.85, bty="0", xjust=0, seg.len=0.5)        
                plot(data.frame(data$newDateStamp,data$Global_reactive_power),type= "l", xlab="datetime", ylab="Global Reactive Power") 
        })
        dev.off()
}
