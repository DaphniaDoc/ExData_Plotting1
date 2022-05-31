## Part 3 ----
library("data.table")

# Reads in data from file & subsets the data for specified dates
pwrDT <- data.table::fread(input = "household_power_consumption.txt"
                           , na.strings="?")

# Prevents Scientific Notation
pwrDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Makes a POSIXct date able to be filtered by time of day
pwrDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
pwrDT <- pwrDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(pwrDT[, dateTime], pwrDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(pwrDT[, dateTime], pwrDT[, Sub_metering_2],col="red")
lines(pwrDT[, dateTime], pwrDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
