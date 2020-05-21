# Code for KnowBR/gap analysis of lep specimens
# Lindsie McCabe / Erica Fischer
# most recent edit: 21 May 2020


## set up workspace
rm(list = ls())
library(tidyverse)
library(KnowBR)
setwd("~/Desktop/SCAN data/may data")


## make dataframe for KnowBR
data <- read_csv("valid_US.csv")
head(data)


## revise dataframe for maping
records <- data.frame(data$scientificName, data$decimalLongitude, data$decimalLatitude)
names(records) <- c("Species","Longitude","Latitude")
records = na.omit(records)

dim <- dim(records)
Counts <- rep(1,dim[1])
records <- cbind(records, Counts)


## running the function
data(States) # state Boundaries of the United States
data(adworld)

# US divided into cells
KnowB(data = records, save = "CSV", jpg = T, cutoffSlope = 0.1, xl = 6.1, xr = 6.3, pro = T, inc = F, 
      cell = 60,  dec=".")

# US divided into states
KnowBPolygon(data = records, shape = States, admAreas = TRUE, shapenames = "NAME", minLon = -130,
             maxLon = -70, minLat = 25, maxLat = 50, colscale = rev(heat.colors(100)), save = "CSV", 
             file1 = "statesSpecies", file2 = "StatesEstimators", file3 = "statesStdErrors", jpg = T, 
             jpg1 = "statesRecords.jpg", jpg2 = "statesObsRich", jpg3 = "statesCompleteness", 
             jpg4 = "statesSlopes", dec = ".")

