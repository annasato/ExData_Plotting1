# Exploratory Data Analysis Week 1 Assignment
# Using RStudio
# plot4.R 
# Import data and create plots as PNGs (plot4.png)

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

# Change data type of Global power sub meterings to numeric, and voltage
feb$Global_active_power <- as.numeric(feb$Global_active_power)
feb$Global_reactive_power <- as.numeric(feb$Global_reactive_power)
feb$Sub_metering_1 <- as.numeric(feb$Sub_metering_1)
feb$Sub_metering_2 <- as.numeric(feb$Sub_metering_2)
feb$Sub_metering_3 <- as.numeric(feb$Sub_metering_3)
feb$Voltage <- as.numeric(feb$Voltage)

# Create timestamp
feb$datetime <- paste(feb$Date, feb$Time)


# Check number of rows
nrow(feb1)
nrow(feb2)
nrow(feb)

head(feb)


# Plot 4
png('plot4.png', width = 480, height = 480)

par(mfrow = c(2,2))

# Top left (Assignment Plot 2)
plot(strptime(feb$datetime, "%Y-%m-%d %T"), feb$Global_active_power, 
     type = "l", xlab = "", 
     ylab = "Global Active Power")

# Top right 
plot(strptime(feb$datetime, "%Y-%m-%d %T"), feb$Voltage, 
     type = "l", 
     xlab = "datetime", ylab = "Voltage")

# Bottom left (Assignment Plot 3)
plot(strptime(feb$datetime, "%Y-%m-%d %T"), feb$Sub_metering_1, 
     type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(strptime(feb$datetime, "%Y-%m-%d %T"), feb$Sub_metering_2, 
      col = 'red')
lines(strptime(feb$datetime, "%Y-%m-%d %T"), feb$Sub_metering_3, 
      col = 'blue')
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, col=c("black", "red", "blue"))

# Bottom right
plot(strptime(feb$datetime, "%Y-%m-%d %T"), feb$Global_reactive_power, 
     type = "l", ylim=c(0,0.5),
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
  
