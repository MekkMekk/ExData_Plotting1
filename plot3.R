# read the file
## IMPORTANT
## The script below does NOT download the file from the source URL (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip). 
## Please download the file from the source URL to your device and unzip the file 
## "household_power_consumption.txt" into your working directory.
## Please set your working directory before executing this script


# this script performs the following steps to create a plot an then to save it to a png file:



# read data only where the date equals to 1 and 2 Feb 2007. Set the column names and read the date as a data variable. 
fh <- file("household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Convert the dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

# set the device, file name and parameter
png(filename="plot3.png", width = 480, height = 480)
par(mfrow=c(1,1))

# construct the plot and change the plotting symbol to a line, add annotiations (change the x & y axis label, 
# change the colour of the lines to red and blue respectively) 
with(data, {
    plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", xlab = "")  
    lines(Sub_metering_2 ~ Datetime, col = "Red")  
    lines(Sub_metering_3 ~ Datetime, col = "Blue")}
)

# add the legend
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close the device
dev.off()

# close connection to the file
close(fh)
