library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIbalt <- subset(NEI, fips == "24510")

totalsptype  <- aggregate(NEIbalt$Emissions, by = list(year = NEIbalt$year,type = NEIbalt$type), sum)

p <- qplot(year,x,data=totalsptype,facets=.~type,geom=c("point","smooth"))
p <- p + ggtitle("Total PM2.5 emissions in Baltimore City, Maryland for each year per source type")
p <- p + xlab("Years")
p <- p + ylab("Total amount of PM2.5 emitted, in tons")

png(file = "plot3.png", width=700, height=480)

print(p)

dev.off()