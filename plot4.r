library(data.table)
library(dplyr)
library(lubridate)

#Take raw data and filter to be only the days I care about
start_date <- as.Date(strptime("02/01/2007","%m/%d/%Y"),tz="America/Los_Angeles")
end_date <- as.Date(strptime("02/02/2007","%m/%d/%Y"),tz="America/Los_Angeles")

mydf <- read.table('household_power_consumption.txt',sep=";",header=TRUE)
mydf <- mydf %>% mutate(Date = as.Date(strptime(Date,"%d/%m/%Y")),tz="America/Los_Angeles") %>%
  filter(Date <= end_date & Date >= start_date) %>% 
  mutate(Global_active_power = as.numeric(Global_active_power) / 1000,Voltage = as.numeric(Voltage),
         Global_reactive_power = as.numeric(Global_reactive_power) / 1000)

mydf$dttm <- as.POSIXct(paste(mydf$Date,mydf$Time),format="%Y-%m-%d %H:%M:%S",tz="America/Los_Angeles")


#Make histogram
par(mfrow=c(2,2))

#top left plot
plot(mydf$dttm, mydf$Global_active_power, type="l",main="",xlab="",ylab="Global Active Power")

#top right plot
plot(mydf$dttm, mydf$Voltage, type="l",main="",xlab="datetime",ylab="Voltage")

#bottom left plot
plot(mydf$dttm, mydf$Sub_metering_1, type="l",main="",xlab="",ylab="Energy sub metering")
lines(mydf$dttm,mydf$Sub_metering_2, col="red")
lines(mydf$dttm,mydf$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1),
       col=c("black","red","blue"),y.intersp=1)

#bottom right plot
plot(mydf$dttm, mydf$Global_reactive_power, type="l",main="",xlab="datetime",ylab="Global_reactive_power")

#Save graph as a png
dev.print(png,filename = "plot4.png", width = 480, height = 480)
dev.off()

