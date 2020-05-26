## Decompressing and reading the data
source("ProjectWeek4ReadingTheData.R")
rm(SCC)

## Plot 1
years<-c(1999,2002,2005,2008)
emissionPerYear<-tapply(NEI$Emissions,NEI$year,sum)
rm(NEI)

## Plotting on RStudio
plot(years,log10(emissionPerYear),type = "l",lwd=2,
     xlab = "Year",ylab = "Log10 Total Emission [tons]",
     main = "Total Emission vs Year",col="red")
points(years,log10(emissionPerYear),pch=3,col="black")

## Creating plot on file.
png(filename = "Plot1.png")

plot(years,log10(emissionPerYear),type = "l",lwd=2,
     xlab = "Year",ylab = "Log10 Total Emission [tons]",
     main = "Total Emission vs Year",col="red")
points(years,log10(emissionPerYear),pch=3,col="black")

dev.off()


setwd(workid)
rm(list = ls())
