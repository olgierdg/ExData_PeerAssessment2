NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totals <- with(NEI, tapply(Emissions, year, sum, na.rm = T))

png(file = "plot1.png", width=480, height=480)

plot(unique(NEI$year), totals, xlab = "Years", ylab = "Total amount of PM2.5 emitted, in tons")
lines(unique(NEI$year),totals)
title("Total PM2.5 emissions from all sources for each year")

dev.off()