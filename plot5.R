library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCmotor <- SCC[SCC$EI.Sector %in% unique(SCC$EI.Sector)[grep("Mobile.*Gasoline|Diesel",unique(SCC$EI.Sector))],]

NEIbalt <- subset(NEI, fips == "24510")

NEIbaltmotor <- subset(NEIbalt, SCC %in% SCCmotor$SCC)

NEIbaltmotorm <- merge(NEIbaltmotor,SCCmotor,by.x="SCC",by.y="SCC")

totalspsector  <- aggregate(NEIbaltmotorm$Emissions, by = list(year = NEIbaltmotorm$year,sector = NEIbaltmotorm$EI.Sector), sum)

p <- qplot(year,x,data=totalspsector,facets=.~sector,geom=c("point","smooth"))
p <- p + ggtitle("Total PM2.5 emissions from motor vehicle (mobile gasoline or diesel) sources in Baltimore City")
p <- p + xlab("Years")
p <- p + ylab("Total amount of PM2.5 emitted, in tons")

png(file = "plot5.png", width=1400, height=480)

print(p)

dev.off()