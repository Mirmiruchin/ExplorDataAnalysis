## My personal Working directory for this project.
## Don't un-comment
setwd("C:/Users/Mare/Documents/Practicas R/C3 - Exploratory Data Analysis/Sem4")

## Creating the directory to save the data and plots
if (!dir.exists("./data2work")){dir.create("./data2work")}

## Setting the working directory
workid<-getwd()
worked<-paste(workid,"/data2work",sep = "")
setwd(worked)
files<-list.files()
fily<-files[grepl("^Source",files)]
if (!file.exists("Source_Classification_Code.rds")){
    setwd(workid)
    unzip(zipfile="exdata_data_NEI_data.zip", 
          exdir = "./data2work")
    setwd(worked)
}
rm(files);rm(fily);

## Reading the files.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#NEI<-transform(NEI,year=factor(year))

