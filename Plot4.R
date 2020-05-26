## Decompressing and reading the data
source("ProjectWeek4ReadingTheData.R")

## Installing libraries. Un-comment if you don't have them installed.
#install.packages("ggplot2")
library(ggplot2)

## Getting the SCC codes for coal combustion-related activities
SCCforCoal<-as.character(SCC$Short.Name)
SCCforCoal<-grepl("[Cc]oal",SCCforCoal)
SCCforCoal<-as.character(SCC[,1])[SCCforCoal]
rm(SCC)

## Getting the emission's data related to coal combustion
NEICoal<-subset(NEI,as.character(NEI$SCC) %in% SCCforCoal)
emissionCoalPerYear<-tapply(NEICoal$Emissions,NEICoal$year,sum)
years<-c(1999,2002,2005,2008)
rm(NEI); rm(NEICoal); rm(SCCforCoal);
## Creating the Data Frame
data2plot<-data.frame(years,emissionCoalPerYear)
colnames(data2plot)<-c("Years","Total_Emission")
rm(emissionCoalPerYear); rm(years)

## Plotting the yearly emissions for coal combustion-related sources
plot4<-qplot(Years,log10(Total_Emission),data=data2plot,col="hotpink",
      geom=c("point","line"),xlab = "Year",
      ylab = "Log10 Total Emissions from Coal Combustion [ton]",
      main = "Total PM25 Emission from Coal Combustion vs Year")+
    theme(legend.position="none")

print(plot4)

## Plotting in the png file
png("Plot4.png")
print(plot4)
dev.off()

setwd(workid)
rm(list = ls())
