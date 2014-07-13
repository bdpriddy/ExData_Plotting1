
# Exploratory Data Analysis
# Assignment 1: Plot 1
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
# If zipped version not found, download the original file from website and unzip.
# Ordinarily this would be a separate function, but I'll include it with each R file for ease of grading 
if(file.exists(paste0(dataDirectory, dataFileName)) == FALSE){
  if(file.exists(paste0(dataDirectory, zipFileName)) == FALSE){
    download.file(dataURL, paste0(dataDirectory, zipFileName), "curl")
  }
  unzip(paste0(dataDirectory, zipFileName), exdir = "./Data")
}

# Load data into dataframe, excluding null values
df <- read.table(paste0(dataDirectory, dataFileName), header = TRUE, sep = ";", stringsAsFactors=FALSE, na.strings = c("","?"))

# Narrow down the data to the dates of interest and remove nulls
df <- subset(df, Date %in% c("1/2/2007", "2/2/2007"))

# Prepare graphics device
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# Create histogram of Global Active Power data
hist(df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close graphics device
dev.off()