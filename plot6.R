library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCmotor <- SCC[SCC$EI.Sector %in% unique(SCC$EI.Sector)[grep("Mobile.*Gasoline|Diesel",unique(SCC$EI.Sector))],]

NEIbalt <- subset(NEI, fips == "24510")
NEIla <- subset(NEI, fips == "06037")

NEIbaltmotor <- subset(NEIbalt, SCC %in% SCCmotor$SCC)
NEIlamotor <- subset(NEIla, SCC %in% SCCmotor$SCC)

NEIbaltmotorm <- merge(NEIbaltmotor,SCCmotor,by.x="SCC",by.y="SCC")
NEIlamotorm <- merge(NEIlamotor,SCCmotor,by.x="SCC",by.y="SCC")

totalspsectorbalt  <- aggregate(NEIbaltmotorm$Emissions, by = list(year = NEIbaltmotorm$year,sector = NEIbaltmotorm$EI.Sector), sum)
totalspsectorla  <- aggregate(NEIlamotorm$Emissions, by = list(year = NEIlamotorm$year,sector = NEIlamotorm$EI.Sector), sum)

totals <- rbind(totalspsectorbalt, totalspsectorla)

p <- ggplot(NULL, aes(year,x))

p <- p + geom_point(aes(year, x, color="Baltimore"), data=totalspsectorbalt)
p <- p + geom_smooth(aes(year, x, color="Baltimore"), data=totalspsectorbalt) 

p <- p + geom_point(aes(year, x, color="Los Angeles"), data=totalspsectorla)
p <- p + geom_smooth(aes(year, x, color="Los Angeles"), data=totalspsectorla) 

p <- p + facet_grid(. ~ sector)

p <- p + ggtitle("Total PM2.5 emissions from motor vehicle (mobile gasoline or diesel) sources in Baltimore City and Los Angeles")
p <- p + xlab("Years")
p <- p + ylab("Total amount of PM2.5 emitted, in tons")

png(file = "plot6.png", width=1400, height=480)

print(p)

dev.off()