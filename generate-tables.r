# load data --------------

## from the RegData 2.2 version
industry_3digit <- readr::read_csv("industry_3digit.csv")

## remove the "Nan" from the 'agency_name' column before import
metadata <- readr::read_csv("metadata.csv", 
                            col_types = cols(agency_name = col_character()))

## the NAICS 2017 codes are downloaded from 
## https://www.census.gov/eos/www/naics/downloadables/downloadables.html
## column names were then changed to 'id', 'industry' and 'description'
## and file was saved as csv
NAICS2017 <- readr::read_csv("NAICS2017.csv", 
                             col_types = cols(id       = col_skip(), 
                                              industry = col_integer()))

# clean and combine data -----------

industry_long <- tidyr::gather(industry_3digit, 
                               key   = "industry", 
                               value = "probability", 
                               -c("year", "title", "part"))

## eliminate low probability industries
industry_long <- subset(industry_long, probability > 0.9)

## combine industry and agency datasets
regdata <- merge(metadata, industry_long, by = c("year", "title", "part"))

## drop unneeded industry codes
NAICS2017 <- subset(NAICS2017, industry > 99 & industry < 1000)

## add the industry descriptions to the regdata
regdata <- merge(regdata, NAICS2017, by="industry")

## remove unnecessary datasets
rm(industry_long, industry_3digit, metadata, NAICS2017)


# agencies-industry interactions --------------------

library(dplyr)

## build dataset of all cumulative restrictions of agency-industry pairs 
ai_cumulative <- regdata %>%
  select(agency_name, description, restrictions) %>%
  group_by(agency_name, description) %>%
  summarize(restrictions = sum(restrictions))

## rename variables
colnames(ai_cumulative)[1] <- "Agency"
colnames(ai_cumulative)[2] <- "Industry"
colnames(ai_cumulative)[3] <- "Restrictions"

# create tables and save them -------------------------

## specify the directory where you want to save the tables
filePath <- "tables/"

## save all data in one file (interactive table)
DT::saveWidget(
  DT::datatable(ai_cumulative), 
  paste(filePath, "__table_fancy.html", sep = "")
)

## save separate files per industry 

library(xtable)

for (i in ai_cumulative$Industry) {
  
  tt <- xtable(
    subset(ai_cumulative, 
           Industry == i, 
           select = c("Agency", "Restrictions")), 
    caption = paste(i, "(cummulative restrictions from 1970 to 2014)"))
  
  print.xtable(tt, 
               paste(filePath, i, ".html", sep = ""),
               type = "html",
               include.rownames = FALSE,
               caption.placement = "top",
               NA.string = "Other",
               html.table.attributes = 'border=0')
}


## alternative creation of single file.
for (i in ai_cumulative$industry) {
  
  tt <- xtable(
    subset(ai_cumulative, 
           industry == i, 
           select = c("agency", "restrictions")), 
    caption = paste(i, "(cummulative restrictions from 1970 to 2014)"))
  
  print.xtable(tt, 
               paste(filePath, "__table_simple.html", sep = ""),
               type = "html",
               include.rownames = FALSE,
               caption.placement = "top",
               NA.string = "Other",
               html.table.attributes = 'border=0',
               append = TRUE)
}