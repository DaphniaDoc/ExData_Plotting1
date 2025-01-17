##  Part 2 ----
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

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = pwrDT[, dateTime]
     , y = pwrDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
