## install all absent packages at once
installed.packages()[,"Package"]
MyList <- c("downloader")
summary((MyList %in% installed.packages()[,"Package"]))
new.packages <- MyList[!(MyList %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

## load packages at once
lapply(MyList,require,character.only=T)

##download and unzip data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip")

## processing data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
findata <- with(NEI, aggregate(Emissions, by = list(year), sum))

plot(findata, type = "o", main = "Total PM2.5 Emissions", xlab = "Year", ylab = "PM2.5 Emissions", pch = 19, col = "darkblue", lty = 6)
