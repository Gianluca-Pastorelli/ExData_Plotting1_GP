library(dplyr)
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# Convert the "Date" variable to Date format
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Filter observations based on the date range
filtered_df <- df %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Convert variables to numeric format
filtered_df$Global_active_power <- as.numeric(filtered_df$Global_active_power)
filtered_df$Sub_metering_1 <- as.numeric(filtered_df$Sub_metering_1)
filtered_df$Sub_metering_2 <- as.numeric(filtered_df$Sub_metering_2)
filtered_df$Sub_metering_3 <- as.numeric(filtered_df$Sub_metering_3)
filtered_df$Voltage <- as.numeric(filtered_df$Voltage)
filtered_df$Global_reactive_power <- as.numeric(filtered_df$Global_reactive_power)

# Convert Date and Time columns to a combined datetime format
filtered_df$DateTime <- as.POSIXct(paste(filtered_df$Date, filtered_df$Time), format = "%Y-%m-%d %H:%M:%S")

# Create a PNG device with specified dimensions
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2, 2))

# Create the first line plot
plot(filtered_df$DateTime, filtered_df$Global_active_power,
     type = "l",  # "l" for a line plot
     xlab = "", ylab = "Global Active Power",
     main = "",
     xlim = c(min(filtered_df$DateTime), max(filtered_df$DateTime)),  # Set the x-axis limits
     ylim = c(0, 8),  # Set the y-axis limits
     col = "black",  # Set line color to black
     axes = FALSE)  # Turn off automatic axis labeling

# Add custom x-axis tick marks and labels
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")),
             labels = c("Thu", "Fri", "Sat"))

# Add y-axis breaks
axis(side = 2, at = seq(0, 6, by = 2))

# Add a box around the plot
box()

# Create the second line plot
plot(filtered_df$DateTime, filtered_df$Sub_metering_1,
     type = "l",  # "l" for a line plot
     xlab = "", ylab = "Energy sub metering",
     main = "",
     xlim = c(min(filtered_df$DateTime), max(filtered_df$DateTime)),  # Set the x-axis limits
     ylim = c(0, 40),  # Set the y-axis limits
     col = "black",
     axes = FALSE)  # Turn off automatic axis labeling

# Add lines for Sub_metering_2 and Sub_metering_3
lines(filtered_df$DateTime, filtered_df$Sub_metering_2, col = "red")
lines(filtered_df$DateTime, filtered_df$Sub_metering_3, col = "blue")

# Add custom x-axis tick marks and labels
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")),
             labels = c("Thu", "Fri", "Sat"))

# Add y-axis breaks
axis(side = 2, at = seq(0, 30, by = 10))

# Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# Add a box around the plot
box()

# Create the third line plot
plot(filtered_df$DateTime, filtered_df$Voltage,
     type = "l",  # "l" for a line plot
     xlab = "", ylab = "Voltage",
     main = "",
     xlim = c(min(filtered_df$DateTime), max(filtered_df$DateTime)),  # Set the x-axis limits
     ylim = c(min(filtered_df$Voltage), max(filtered_df$Voltage)),  # Set the y-axis limits
     col = "black",  # Set line color to black
     axes = FALSE)  # Turn off automatic axis labeling

# Add custom x-axis tick marks and labels
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")),
             labels = c("Thu", "Fri", "Sat"))

# Add y-axis breaks
axis(side = 2, at = seq(234, 246, by = 2))

# Add a box around the plot
box()

# Create the fourth line plot
plot(filtered_df$DateTime, filtered_df$Global_reactive_power,
     type = "l",  # "l" for a line plot
     xlab = "", ylab = "Global Reactive Power",
     main = "",
     xlim = c(min(filtered_df$DateTime), max(filtered_df$DateTime)),  # Set the x-axis limits
     ylim = c(0, 0.5),  # Set the y-axis limits
     col = "black",  # Set line color to black
     axes = FALSE)  # Turn off automatic axis labeling

# Add custom x-axis tick marks and labels
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-02 23:59:00")),
             labels = c("Thu", "Fri", "Sat"))

# Add y-axis breaks
axis(side = 2, at = seq(0, 0.5, by = 0.1))

# Add a box around the plot
box()

# Close the PNG device
dev.off()