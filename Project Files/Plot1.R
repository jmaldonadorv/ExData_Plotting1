# Setting WD where project data downloaded
setwd("C:/Users/jmaldonado/Documents/DSAcceleratorRepos/EDAFiles")

# Reading data in from the zip file
data <- read.table(unz("exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.txt"), header = TRUE, sep = ";")

# Subsetting the data to the appropriate dates
data_feb <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Have to change Global Active Power to character and then numeric, as it was read in as a factor.
data_feb$Global_active_power <- as.numeric(as.character(data_feb$Global_active_power))

# Setting working directory to save the plot
setwd("./ExData_Plotting1/Project Files")

# Plotting the histogram
png("Plot1.png", width = 480, height = 480)
with(data_feb, hist((as.numeric(data_feb$Global_active_power)), 
                    col = "red", 
                    xlab = "Global Active Power (kilowatts)",
                    main = "Global Active Power"))
dev.off()
