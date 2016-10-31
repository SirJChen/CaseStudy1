## GDP Clean up
## After looking at the CSV file we see that there are some entries that do no possess a valid GDP value.
## In addition there are some lines of data at the bottom of the file that we can drop. 
## We also drop any columns that we don't need
CleanGDP <- GDP[GDP$V1!=''& GDP$V2!='' & GDP$V5!='', c(1,2,4,5)]
##Name the variables for ease of use
names(CleanGDP)<-c("CountryCode", "Ranking", "Country", "GDP")
##Purge commas from dollar amounts
CleanGDP$GDP<-as.numeric(gsub(",","",CleanGDP$GDP))

##running a str(CleanGDP) we note with some alarm that the ranking is categorized as a character value. We should clear that up to make our lives easier down the line
CleanGDP$Ranking<-as.numeric(CleanGDP$Ranking)

str(CleanGDP)
## We should see now that both GDP and Ranking show up as numeric values, just as God intended. 

##Country Cleanup
##Looking at the file we can breath a little easier, this file is much cleaner than the GDP file. 
## Nonetheless there are lot of unused columns, lets trim them. 
CleanCountry<-CountryData[c(1,2,3)]


##Finally we merge the two sets for our final product
CleanMerge <- merge(CleanCountry, CleanGDP, by="CountryCode", all=TRUE)

## NOTE THAT THIS LAST STEP SHOULD BE DONE AFTER ANSWERING QUESTION 1
##After merging we see that some entries on one table do not have matching values on the second table, resulting in some missing values.
##In addition we see that the long form of the countries' names have a second column. We are going to purge those. 
CleanMerge <- CleanMerge[CleanMerge$Ranking!='' & CleanMerge$GDP!='' & is.na(CleanMerge$Ranking)==FALSE, c(1,2,3,4,6)]

## A final scan of the data revealed on remaining anomaly: Country Code SSD has a ranking and GDP, but its long form name is blank. 
## SSD is also missing its income category. 
## After we queried the World Bank we discovered that South Sudan is considered a Low Income Country. 

CleanMerge$`Long Name`[CleanMerge$CountryCode == "SSD"] <- "South Sudan"
CleanMerge$`Income Group`[CleanMerge$CountryCode == "SSD"] <- "Low income"

## Data is now ready for analysis