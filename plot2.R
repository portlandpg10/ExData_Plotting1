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

plot(mydf$dttm, mydf$Global_active_power, type="l",main="",xlab="",ylab="Global Active Power (kilowatts)")
dev.print(png,filename = "plot2.png", width = 480, height = 480)
dev.off()

