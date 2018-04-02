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

Subset1 <- subset(NEI, fips == "06037" & type=="ON-ROAD")
losangeles.sources <- aggregate(Subset1[c("Emissions")], list(type = Subset1$type, year = Subset1$year, zip = Subset1$fips), sum)
CombinedMotorVehiclesData <- rbind(baltimore.sources, losangeles.sources)
qplot(year, Emissions, data = CombinedMotorVehiclesData, color = zip, geom= "line", ylim = c(-100, 5500)) + ggtitle("Motor Vehicle Emissions in Baltimore (24510) \nvs. Los Angeles (06037) Counties") + xlab("Year") + ylab("Emission Levels")
