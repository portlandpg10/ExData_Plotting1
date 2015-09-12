library(data.table)
library(dplyr)
library(lubridate)

#Take raw data and filter to be only the days I care about
start_date <- as.Date(strptime("02/01/2007","%m/%d/%Y"),tz="America/Los_Angeles")
end_date <- as.Date(strptime("02/02/2007","%m/%d/%Y"),tz="America/Los_Angeles")

mydf <- read.table('household_power_consumption.txt',sep=";",header=TRUE)
mydf <- mydf %>% mutate(Date = as.Date(strptime(Date,"%d/%m/%Y")),tz="America/Los_Angeles") %>%
  filter(Date <= end_date & Date >= start_date) %>% mutate(Global_active_power = as.numeric(Global_active_power) / 1000)

mydf$dttm <- as.POSIXct(paste(mydf$Date,mydf$Time),format="%Y-%m-%d %H:%M:%S",tz="America/Los_Angeles")

#Make histogram

plot(mydf$dttm, mydf$Sub_metering_1, type="l",main="",xlab="",ylab="Energy sub metering")
lines(mydf$dttm,mydf$Sub_metering_2, col="red")
lines(mydf$dttm,mydf$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1,1),
       col=c("black","red","blue"),y.intersp=1)
dev.print(png,filename = "plot3.png", width = 480, height = 480)
dev.off()

