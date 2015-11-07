library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCcoal <- SCC[SCC$EI.Sector %in% unique(SCC$EI.Sector)[grep("Coal",unique(SCC$EI.Sector))],]

NEIcoal <- subset(NEI, SCC %in% SCCcoal$SCC)

NEIcoalm <- merge(NEIcoal,SCCcoal,by.x="SCC",by.y="SCC")

totalspsector  <- aggregate(NEIcoalm$Emissions, by = list(year = NEIcoalm$year,sector = NEIcoalm$EI.Sector), sum)

p <- qplot(year,x,data=totalspsector,facets=.~sector,geom=c("point","smooth"))
p <- p + ggtitle("Total PM2.5 emissions from coal combustion-related sources across the United States")
p <- p + xlab("Years")
p <- p + ylab("Total amount of PM2.5 emitted, in tons")

png(file = "plot4.png", width=800, height=480)

print(p)

dev.off()