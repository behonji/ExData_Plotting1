###############################################################################
# Coursera Class: Exploratory Data Analysis
#
# Class Project: Project 1
# File Name: plot4.R
# File Generated: plot4.png
#
# Graph Type: plot 4 charts in one file. 
#
# Comments: This file is for Project 1.  This file will download data, filter
#           the data and then generate a .png file.
###############################################################################

###############################################################################
# 1: Download File
###############################################################################
setwd("C:/Users/bhoenig/Documents/R/Coursera/ExploratoryDataAnalysis")

#Create directory for Project1 if it doesn't exist
if (!file.exists("./Project1"))(dir.create("./Project1"))

# Download the file if it's not already downloaded. 
# Notice the windows does not need the method = "curl" as on a Mac.
if (!file.exists("./Project1/household_power_consumption.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile="./Project1/household_power_consumption.zip")
}

# Unzip the file if it's not already unzipped.
if (!file.exists("./Project1/household_power_consumption.txt")){
  unzip(zipfile="./Project1/household_power_consumption.zip", exdir = "./Project1")
}


# check the content of the Project1 folder
#list.files("./Project1")


###############################################################################
# 2: Read data from file and save to variables
###############################################################################
dataFile <- "./Project1/household_power_consumption.txt"
initial <- read.table( dataFile, sep=";", header = TRUE, nrows=100)
classes <- sapply(initial, class)
ds <- read.table(dataFile, header=TRUE, sep=";", colClasses = classes, na.strings="?")


###############################################################################
# 3: Create a subset (ss) from the dataset (ds) for specific dates
###############################################################################
ds$DateTime <- paste(ds$Date, ds$Time, sep=" ")
ds$DateTime <- strptime(ds$DateTime, format="%d/%m/%Y %H:%M:%S")
ds$Date <- as.Date(ds$Date, format="%d/%m/%Y")
ss <- ds[ds$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

###############################################################################
# 4: generate plot
###############################################################################
png(file="./Project1/plot4.png", width = 480, height = 480)
par(mfcol=c(2,2), mar=c(4,4,4,2), oma=c(1,0,0,0))
plot(ss$DateTime, ss$Global_active_power, type="l", ylab = "Global Active Power", xlab="")

plot(ss$DateTime, ss$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
lines(ss$DateTime, ss$Sub_metering_2, col="red")
lines(ss$DateTime, ss$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = "solid", col = c("black", "red", "blue"), bty = "n")

plot(ss$DateTime, ss$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(ss$DateTime, ss$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()
