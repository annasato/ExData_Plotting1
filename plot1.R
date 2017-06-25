# Exploratory Data Analysis Week 1 Assignment
# Using RStudio
# plot1.R 
# Import data and create plots as PNGs (plot1.png)

# Load packages
library(data.table)
library(lubridate)


# Set working directory
getwd()

# Import data
raw <- fread("household_power_consumption.txt", sep= ';', header=T)
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

# Check number of rows
nrow(feb1)
nrow(feb2)
nrow(feb)

head(feb)

# Plot 1
png('plot1.png', width = 480, height = 480)
hist(feb$Global_active_power, 
     breaks=15, 
     col="red", 
     main = "Global Active Power")
dev.off()

