## install all absent packages at once
installed.packages()[,"Package"]
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
sub2 <- subset(NEI, fips == "24510")
baltimore.sources <- aggregate(sub2[c("Emissions")], list(type = sub2$type, year = sub2$year), sum)
qplot(year, Emissions, data = baltimore.sources, color = type, geom= "line")+ ggtitle("Total PM2.5 Emissions in Baltimore County by Source Type") + xlab("Year") + ylab("PM2.5 Emissions")
