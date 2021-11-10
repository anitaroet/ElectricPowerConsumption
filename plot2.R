
library(tidyverse)
library(lubridate)


# Download and read data
if(!file.exists("hosehold_power_consumption.txt")){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, "electric.zip")
  unzip("electric.zip")
}

dat <- read.delim("household_power_consumption.txt", stringsAsFactors = TRUE, header=TRUE,sep=";")

# Change into time- and date variables, subset only necessary data and change into numeric class

power <- dat %>%
  mutate(Date=as.Date(Date, "%d/%m/%Y"),
         Global_active_power=as.numeric(Global_active_power)/500,
         Global_reactive_power=as.numeric(Global_reactive_power)/500,
         Voltage=as.numeric(Voltage),
         Global_intensity=as.numeric(Global_intensity),
         Sub_metering_1=as.numeric(Sub_metering_1),
         Sub_metering_2=as.numeric(Sub_metering_2),
         datetime=strptime(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")) %>%
  filter(Date>"2007-01-31"&Date<"2007-02-03")

# Plot 2
with(power, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))


dev.copy(png, file="plot2.png")
dev.off()
