# Exploratory Data Analysis Week 1 Assignment
# Using RStudio
# plot2.R 
# Import data and create plots as PNGs (plot2.png)

# Load packages
library(data.table)
library(lubridate)


# Set working directory
getwd()

# Import data
raw <- fread("household_power_consumption.txt", sep= ';', header=T, na.strings='?')
head(raw)
names(raw)

# Convert Date format from dd/mm/yyyy to yyyy-mm-dd
raw.date <- raw
raw.date$Date <- dmy(raw$Date)

# Subset needed dates (2007-02-01 and 2007-02-02)
feb1 <- raw.date[which(raw.date$Date == "2007-02-01")]
feb2 <- raw.date[which(raw.date$Date == "2007-02-02")]

feb <- rbind(feb1, feb2)

# Change data type of Global_atctive_power to numeric
feb$Global_active_power <- as.numeric(feb$Global_active_power)

# Create timestamp
feb$datetime <- paste(feb$Date, feb$Time)


# Check number of rows
nrow(feb1)
nrow(feb2)
nrow(feb)

head(feb)


# Plot 2
png('plot2.png', width = 480, height = 480)
plot(strptime(feb$datetime, "%Y-%m-%d %T"), feb$Global_active_power, 
     type = "l", xlab = "", 
     ylab = "Global Active Power(kilowatts)")
dev.off()

