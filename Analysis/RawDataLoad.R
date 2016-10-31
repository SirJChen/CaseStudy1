##R Dependencies for this project
library(repmis)
library(ggplot2)
library(dplyr)
library(plyr)

##Loading raw data

CountryData <- source_data("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

GDP <- source_data("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
