## Decompressing and reading the data
source("ProjectWeek4ReadingTheData.R")

## Libraries. Install them if you don't have them already.
#install.packages("reshape2")
library(reshape2)
#install.packages("ggplot2")
library(ggplot2)


## Subsetting the data for Baltimore and Los Angeles
NEIBalti<-subset(NEI,fips=="24510")
NEILosAng<-subset(NEI,fips=="06037")
rm(NEI)

## Getting the SCC codes related to vehicles.
SCCforVehicles<-as.character(SCC$Short.Name)
SCCforVehicles<-grepl("[Vv]ehicle",SCCforVehicles)
SCCforVehicles<-as.character(SCC[,1])[SCCforVehicles]
rm(SCC)

## Subsetting the data from Baltimore and L.A. for vehicles.
NEIBaltiVehi<-subset(NEIBalti,as.character(NEIBalti$SCC) %in% SCCforVehicles)
NEILosAngVehi<-subset(NEILosAng,as.character(NEILosAng$SCC) %in% SCCforVehicles)
rm(NEIBalti); rm(NEILosAng); rm(SCCforVehicles)

LosAngeles<-tapply(NEILosAngVehi$Emissions,
                   NEILosAngVehi$year,sum)
Baltimore<-tapply(NEIBaltiVehi$Emissions,
                  NEIBaltiVehi$year,sum)
rm(list = c("NEIBaltiVehi","NEILosAngVehi"))

## Getting the data into a Data Frame and ordering the Data
dataF<-data.frame(year=c(1999,2002,2005,2008),
                  Baltimore,LosAngeles)

data2plot<-melt(dataF,measure.vars = c("Baltimore","LosAngeles"))
colnames(data2plot)<-c("Year","City","Total_Emission")


## Plotting
plot6<-qplot(Year,log10(Total_Emission),data=data2plot,color=City,
             geom=c("point","line"),xlab = "Year",
             ylab = "Log10 Total PM25 Emission [ton]",
             main = "Total PM25 Emission by Vehicles vs Year - Baltimore vs LA")
print(plot6)

## Plotting into a file
png(filename = "Plot6.png")
print(plot6)
dev.off()

setwd(workid)
rm(list = ls())

