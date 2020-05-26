## Decompressing and reading the data
source("ProjectWeek4ReadingTheData.R")
rm(SCC)

## Subsetting the data for Baltimore
NEIBalti<-subset(NEI,fips=="24510")
rm(NEI)
emissionPerYear<-tapply(NEIBalti$Emissions,NEIBalti$year,sum)
years<-c(1999,2002,2005,2008)
rm(NEIBalti)

## Plotting on RStudio
plot(years,log10(emissionPerYear),type = "l",lwd=2,
     xlab = "Year",ylab = "Log10 Total Emission [tons]",
     main = "Total Emission vs Year - Baltimore City",col="blue")
points(years,log10(emissionPerYear),pch=3,col="black")

## Creating plot on file.
png(filename = "Plot2.png")

plot(years,log10(emissionPerYear),type = "l",lwd=2,
     xlab = "Year",ylab = "Log10 Total Emission [tons]",
     main = "Total Emission vs Year - Baltimore City",col="blue")
points(years,log10(emissionPerYear),pch=3,col="black")

dev.off()

setwd(workid)
rm(list = ls())