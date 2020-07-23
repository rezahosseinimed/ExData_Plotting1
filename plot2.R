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

## Drawing the plot"
library(lubridate)
datetime <- with(sub_hPower, ymd(Date) + hms(Time))
with(sub_hPower, plot(datetime,
                      Global_active_power,
                      type = "l",
                      xlab = "",
                      ylab = "Global Active Power (kilowatts)"
                      )
     )


## Copying the plot to a PNG graphics device:
dev.copy(png, width = 480, height = 480, file = "plot2.png")
dev.off()
