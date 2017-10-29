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

#Setting working directory to save PNG file
setwd("C:/Users/jmaldonado/Documents/DSAcceleratorRepos/EDAFiles/ExData_Plotting1/Project Files")

# Plotting the chart
png("Plot2.png", width = 480, height = 480)
with(data_feb, plot(Timestamp, Global_active_power,
     type = "l",
     xlab = "", 
     ylab = "Global Active Power (kilowatts)"))
dev.off()