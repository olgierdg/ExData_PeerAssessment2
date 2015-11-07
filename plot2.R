NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIbalt <- subset(NEI, fips == "24510")

totals <- with(NEIbalt, tapply(Emissions, year, sum, na.rm = T))

png(file = "plot2.png", width=480, height=480)

plot(unique(NEIbalt$year), totals, xlab = "Years", ylab = "Total amount of PM2.5 emitted, in tons")
lines(unique(NEIbalt$year),totals)
title("Total PM2.5 emissions in Baltimore City, Maryland for each year")

dev.off()