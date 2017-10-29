# Setting WD where project data downloaded
setwd("C:/Users/jmaldonado/Documents/DSAcceleratorRepos/EDAFiles")

# Reading data in from the zip file
data <- read.table(unz("exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.txt"), header = TRUE, sep = ";")

# Subsetting the data to the appropriate dates
data_feb <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Changing global active power to a charater and then to a numeric
data_feb$Global_active_power <- as.numeric(as.character(data_feb$Global_active_power))

# Creating a timestamp field to use as the x axis
data_feb$Timestamp <- (as.POSIXct(paste(as.Date(data_feb$Date, "%d/%m/%Y"), data_feb$Time)))

#Doing the same character > numeric transformation for the sub metering, voltage, and global reactive power
data_feb$Sub_metering_1 <- as.numeric(as.character(data_feb$Sub_metering_1))
data_feb$Sub_metering_2 <- as.numeric(as.character(data_feb$Sub_metering_2))
data_feb$Sub_metering_3 <- as.numeric(as.character(data_feb$Sub_metering_3))
data_feb$Voltage <- as.numeric(as.character(data_feb$Voltage))
data_feb$Global_reactive_power <- as.numeric(as.character(data_feb$Global_reactive_power))


#Setting working directory to save PNG file
setwd("C:/Users/jmaldonado/Documents/DSAcceleratorRepos/EDAFiles/ExData_Plotting1/Project Files")

# Plotting the chart
png("Plot4.png", width = 480, height = 480)

# Setting a 2x2 grid for the plots
par(mfrow = c(2,2))

#Plot 1 (same as Plot 1)
with(data_feb, plot(Timestamp, Global_active_power,
                    type = "l",
                    xlab = "",
                    ylab = "Global Active Power"))
#Plot 2
with(data_feb, plot(Timestamp, Voltage,
                    type = "l",
                    xlab = "datetime"))

#Plot 3 (same as plot 3)
with(data_feb, plot(Timestamp, Sub_metering_1,
                    type = "l",
                    xlab = "", 
                    ylab = "Energy sub metering",
                    col = "black",
                    ybreak = c(0, 10, 20, 30)))
lines(data_feb$Timestamp, data_feb$Sub_metering_2,
      col = "red")
lines(data_feb$Timestamp, data_feb$Sub_metering_3,
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       bty = "n")

#Plot 4
with(data_feb, plot(Timestamp, Global_reactive_power,
                    type = "l",
                    xlab = "datetime",
                    ybreak = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5)))

dev.off()

