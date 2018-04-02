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
SCC <- readRDS("Source_Classification_Code.rds")
SCC.sub <- SCC[grepl("Coal" , SCC$Short.Name), ]
NEI.sub <- NEI[NEI$SCC %in% SCC.sub$SCC, ]
plot4 <- ggplot(NEI.sub, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) + xlab("year") +ylab("Coal-Related PM2.5 Emissions") + ggtitle("Total Coal-Related PM2.5 Emissions")
print(plot4)
