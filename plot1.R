
## IMPORTANT
## The script below does NOT download the file from the source URL (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip). 
## Please download the file from the source URL to your device and unzip the file 
## "household_power_consumption.txt" into your working directory.
## Please set your working directory before executing this script


# this script performs the following steps to create a plot an then to save it to a png file:


# read the file
# read data only where the date equals to 1 and 2 Feb 2007. Set the column names and read the date as a data variable. 
fh <- file("household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Convert the dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

# construct the plot and add annotiations for the x axis the the main title
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
# save plot to a png file with a width of 480 pixels and a height of 480 pixels and close the device
dev.copy(png, file = "plot1.png",  width = 480, height = 480)
dev.off()

# close connection to the file
close(fh)
