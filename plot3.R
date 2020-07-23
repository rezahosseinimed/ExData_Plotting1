## Downloading and unzipping the data file:
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "exdata-household_power_consumption.zip",
              method = "curl")
unzip("exdata-household_power_consumption.zip")


## Reading in and subsetting the data for the dates "2007-02-01" and
## "2007-02-01":
# I use tidyverse package, which automatically loads readr, dplyr, etc.
library(tidyverse)
hPower <- read_delim(file = "exdata-household_power_consumption.zip",
                     delim = ";",
                     na = "?")
hPower$Date <- as.Date(hPower$Date, format = "%d/%m/%Y")
sub_hPower <- filter(hPower, Date == "2007-02-01" | Date == "2007-02-02")
rm(list = setdiff(ls(), "sub_hPower"))  # Removing unnecessary objects

## Drawing the plot:
library(lubridate)
datetime <- with(sub_hPower, ymd(Date) + hms(Time))
png(filename = "plot3.png", width = 480, height = 480)
with(sub_hPower, plot(datetime,
                      Sub_metering_1,
                      type = "l",
                      xlab = "",
                      ylab = "Energy sub metering"
                      )
     )
with(sub_hPower, lines(datetime, Sub_metering_2, col = "red"))
with(sub_hPower, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"),
       cex = 0.95
       )
dev.off()
