library(dplyr)
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# Convert the "Date" variable to Date format
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Filter observations based on the date range
filtered_df <- df %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Convert the "Global_active_power" variable to numeric format
filtered_df$Global_active_power <- as.numeric(filtered_df$Global_active_power)

# Convert Date and Time columns to a combined datetime format
filtered_df$DateTime <- as.POSIXct(paste(filtered_df$Date, filtered_df$Time), format = "%Y-%m-%d %H:%M:%S")

# Create a PNG device with specified dimensions
png(file = "plot2.png", width = 480, height = 480, units = "px")

# Create a line plot
plot(filtered_df$DateTime, filtered_df$Global_active_power,
     type = "l",  # "l" for a line plot
     xlab = "", ylab = "Global Active Power (kilowatt)",
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

# Close the PNG device
dev.off()