
# Exploratory Data Analysis
# Assignment 1: Plot 4
# July 13, 2014

# Set working directory - this is user specific
setwd("C:\\Users\\Brian\\Documents\\Coursera\\Exploratory Data Analysis\\")

# Define data directory file names and expected locations
dataDirectory <- "./Data/"
dataFileName <- "household_power_consumption.txt"
zipFileName <- "exdata-data-household_power_consumption.zip"
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Look for data file in 'data' subdirectory of current working directory
# If data file is not found, check for zipped version. Unzip if found.
# If zipped version is not found, download the original file from website and unzip.
# Ordinarily this would be a separate function, but I'll include it with each R file for ease of grading 
if(file.exists(paste0(dataDirectory, dataFileName)) == FALSE){
  if(file.exists(paste0(dataDirectory, zipFileName)) == FALSE){
    download.file(dataURL, paste0(dataDirectory, zipFileName), "curl")
  }
  unzip(paste0(dataDirectory, zipFileName), exdir = "./Data")
}

# Load data into dataframe
df <- read.table(paste0(dataDirectory, dataFileName), header = TRUE, sep = ";", stringsAsFactors=FALSE, na.strings = c("","?"))

# Narrow down the data to the dates of interest 
df <- subset(df, Date %in% c("1/2/2007", "2/2/2007"))

# Combine string date and time values from file into single date/time field 
df$DateTime <- as.POSIXct(strptime(paste0(df$Date, ' ', df$Time), format="%d/%m/%Y %H:%M:%S"))

# Prepare graphics device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# Specify multiple plots per page layout
par(mfrow=c(2,2))

# Generate plots
plot(df$DateTime, df$Global_active_power, type="n", xlab = "", ylab = "Global Active Power")
lines(df$DateTime, df$Global_active_power)

plot(df$DateTime, df$Voltage, type="n", ylab = "Voltage", xlab = "datetime")
lines(df$DateTime, df$Voltage)

plot(df$DateTime, df$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(df$DateTime, df$Sub_metering_1, col = "black")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
legend("topright",col = c("black", "red", "blue"), lty=c(1,1),  cex = 0.8, bty = "n", xjust=1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(df$DateTime, df$Global_reactive_power, type="n", ylab = "Global_reactive_power", xlab = "datetime")
lines(df$DateTime, df$Global_reactive_power)

# Close graphics device
dev.off()