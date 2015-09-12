library(data.table)
library(dplyr)
library(lubridate)

#Take raw data and filter to be only the days I care about
start_date <- as.Date(strptime("02/01/2007","%m/%d/%Y"),tz="America/Los_Angeles")
end_date <- as.Date(strptime("02/02/2007","%m/%d/%Y"),tz="America/Los_Angeles")

mydf <- read.table('household_power_consumption.txt',sep=";",header=TRUE)
mydf <- mydf %>% mutate(Date = as.Date(strptime(Date,"%d/%m/%Y")),tz="America/Los_Angeles") %>%
  filter(Date <= end_date & Date >= start_date) %>% mutate(Global_active_power = as.numeric(Global_active_power) / 1000)


#Make histogram

hist(mydf$Global_active_power, main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.print(png,filename = "plot1.png", width = 480, height = 480)
dev.off()

