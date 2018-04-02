## install all absent packages at once
MyList <- c("downloader","ggplot2")
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
Subset <- subset(NEI, fips == "24510" & type=="ON-ROAD")
baltimore.sources <- aggregate(Subset[c("Emissions")], list(type = Subset$type, year = Subset$year, zip = Subset$fips), sum)
qplot(year, Emissions, data = baltimore.sources, geom= "line") + theme_gray() + ggtitle("Motor Vehicle-Related Emissions in Baltimore County") + xlab("Year") + ylab("Emission Levels")