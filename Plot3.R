## Decompressing and reading the data
source("ProjectWeek4ReadingTheData.R")
rm(SCC)

## Libraries. Install them if you don't have them already.
#install.packages("reshape2")
library(reshape2)
#install.packages("ggplot2")
library(ggplot2)

## Subsetting the data for Baltimore
NEIBalti<-subset(NEI,fips=="24510")
rm(NEI)
NEIBaltiByType<-split(NEIBalti,NEIBalti$type)
rm(NEIBalti)
## Reordering the data by type of emission
NON_ROAD<-tapply(NEIBaltiByType[[1]]$Emissions,
                        NEIBaltiByType[[1]]$year,sum)
NON_POINT<-tapply(NEIBaltiByType[[2]]$Emissions,
                         NEIBaltiByType[[2]]$year,sum)
ON_ROAD<-tapply(NEIBaltiByType[[3]]$Emissions,
                         NEIBaltiByType[[3]]$year,sum)
POINT<-tapply(NEIBaltiByType[[4]]$Emissions,
                         NEIBaltiByType[[4]]$year,sum)
rm(NEIBaltiByType)

## Getting the data into a Data Frame
dataF<-data.frame(year=c(1999,2002,2005,2008),
                  NON_ROAD,NON_POINT,
                  ON_ROAD,POINT)
rm(NON_POINT); rm(NON_ROAD); rm(ON_ROAD); rm(POINT)

## Making the data tidy
data2plot<-melt(dataF,
     measure.vars = c("NON_ROAD","NON_POINT","ON_ROAD","POINT"))
colnames(data2plot)<-c("year","Type_of_Emission","Total_Emission")
rm(dataF)

## Plotting
plot3<-qplot(year,Total_Emission,data=data2plot,color=Type_of_Emission,
      geom=c("point","line"),xlab = "Year",
      ylab = "Total PM25 Emission [ton]",
      main = "Total PM25 Emission by Type vs Year - Baltimore City")
print(plot3)

## Plotting into a the file
png(filename = "Plot3.png")
print(plot3)
dev.off()

setwd(workid)
rm(list=ls())