library(dplyr)
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# Convert the "Date" variable to Date format
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Filter observations based on the date range
filtered_df <- df %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Convert the "Global_active_power" variable to numeric format
filtered_df$Global_active_power <- as.numeric(filtered_df$Global_active_power)

# Create a PNG device with specified dimensions
png(file = "plot1.png", width = 480, height = 480, units = "px")

# Create a histogram with 0.5 bins for the "Global_active_power" variable
hist(filtered_df$Global_active_power, breaks = seq(min(filtered_df$Global_active_power), max(filtered_df$Global_active_power) + 0.5, by = 0.5),
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main = "Global Active Power",
     xlim = c(0, 6), ylim = c(0, 1200),
     col = "red",
     axes = FALSE)  # Turn off automatic axis labeling

# Add custom axis ticks and labels
axis(side = 1, at = seq(0, 6, by = 2), labels = seq(0, 6, by = 2), cex.axis = 0.8)
axis(side = 2, at = seq(0, 1200, by = 200), labels = seq(0, 1200, by = 200), cex.axis = 0.8)

# Close the PNG device
dev.off()