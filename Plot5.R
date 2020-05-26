## Decompressing and reading the data
source("ProjectWeek4ReadingTheData.R")

## Libraries. Install them if you don't have them already.
#install.packages("ggplot2")
library(ggplot2)


## Subsetting the data for Baltimore and Los Angeles
NEIBalti<-subset(NEI,fips=="24510")
rm(NEI)

## Getting the SCC codes related to vehicles.
SCCforVehicles<-as.character(SCC$Short.Name)
SCCforVehicles<-grepl("[Vv]ehicle",SCCforVehicles)
SCCforVehicles<-as.character(SCC[,1])[SCCforVehicles]
rm(SCC)

## Subsetting the data from Baltimore and L.A. for vehicles.
NEIBaltiVehi<-subset(NEIBalti,as.character(NEIBalti$SCC) %in% SCCforVehicles)
rm(NEIBalti); rm(SCCforVehicles)

Baltimore<-tapply(NEIBaltiVehi$Emissions,
                  NEIBaltiVehi$year,sum)
rm(NEIBaltiVehi)

## Getting the data into a Data Frame and ordering the Data
data2plot<-data.frame(year=c(1999,2002,2005,2008),
                  Baltimore)

colnames(data2plot)<-c("Year","Total_Emission")


## Plotting
plot5<-qplot(Year,Total_Emission,data=data2plot,col = "honeydew",
             geom=c("point","line"),xlab = "Year",
             ylab = "Total PM25 Emission [ton]",
             main = "Total PM25 Emission by Vehicles vs Year - Baltimore")+
        theme(legend.position="none")
print(plot5)

## Plotting into a file
png(filename = "Plot5.png")
print(plot5)
dev.off()

setwd(workid)
rm(list = ls())

