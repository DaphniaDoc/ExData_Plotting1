##  Part 1 ----
library("data.table")

# Reads in data from file & subsets the data for specified dates
pwrDT <- data.table::fread(input = "household_power_consumption.txt"
                           , na.strings="?")

# Prevents scientific notation
pwrDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changes Date Column to Date Type
pwrDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates: 2007-02-01 and 2007-02-02
pwrDT <- pwrDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(pwrDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
