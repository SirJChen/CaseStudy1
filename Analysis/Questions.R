## Question 1: Finding how many records match:
nrow(CleanMerge[CleanMerge$Ranking!='' & CleanMerge$`Income Group`!='' & is.na(CleanMerge$Ranking)==FALSE, ])

##190 records match

## Question 2 Finding the 13th lowest country by GDP
CleanMerge<-plyr::arrange(CleanMerge, CleanMerge$GDP)
GDPthirteen<-CleanMerge[13,1]
##The return value was KNA which corresponds to St. Kitts and Nevis

## Question 3
## To find the average GDP rankings for the two high income groups we must parse out the countries by income category
AvgGDP <- CleanMerge[CleanMerge$`Income Group` == "High income: OECD" | CleanMerge$`Income Group` == "High income: nonOECD",c(3,4,5)]
names(AvgGDP) <- c("IncomeGroup","Ranking", "GrossIncome")
attach(AvgGDP)
AvgGDPGroup <- aggregate(AvgGDP[c(2,3)], by=list(IncomeGroup), mean)
detach(AvgGDP)
## From the results we can see the following:
## OECD : Average Ranking: 32.9667 Average GDP: 1483917.1
## nonOECD: Average Ranking: 91.91304 Average GDP: 104349.8

##Question 4
ggplot(data=CleanMerge, aes(CleanMerge$GDP, fill=CleanMerge$`Income Group`, colour=CleanMerge$`Income Group`)) + geom_density(alpha = 0.7) + ggtitle("GDP by Income Group") 
## We note that the graph is incredibly ugly and extremely difficult to interpret, all the results are mashed towards the value zero. 
## We manually add a limit to the x-axis in an attempt to make the graph a little more presentable
ggplot(data=CleanMerge, aes(CleanMerge$GDP, fill=CleanMerge$`Income Group`, colour=CleanMerge$`Income Group`)) + geom_density(alpha = 0.7) + ggtitle("GDP by Income Group") + xlim(0,900000)
##However even with the limit the graph is very difficult to read. We will perform a log transform to GDP and see if that helps any.
ggplot(data=CleanMerge, aes(log(CleanMerge$GDP), fill=CleanMerge$`Income Group`, colour=CleanMerge$`Income Group`)) + geom_density(alpha = 0.7) + ggtitle("GDP by Income Group") + xlim(2, 18)

##Question 5
## ntile command is from dplyr.
CleanMerge$Quantile <- ntile(CleanMerge$Ranking,5)
## If we view QTable afterwards we can see that there are 5 countries in the 1st quantile of GDP rankings that are also considered lower middle income.
QTable <- table(CleanMerge$Quantile, CleanMerge$`Income Group`)
