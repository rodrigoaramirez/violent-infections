setwd("C:/Users/roram/Documents/thesis datasets/attacks/")

pacman::p_load(tidyverse, rvest)
awsd <- read_csv("aid worker security database/security_incidents_2021-11-15.csv")

View(awsd)

url <- "https://www.worldometers.info/geography/how-many-countries-in-africa/"

AF_cunt_tree <- 
  url %>%
  read_html() %>%
  html_table()

countries <- AF_cunt_tree[[1]][2]

countries <- as.character(countries$Country)

countries

filtered <-
  awsd %>%
  filter(Country %in% countries,
         Year %in% c(2012:2017))

dta <-
  filtered %>%
  group_by(Year, Country) %>%
  summarise(incidents = n()) %>%
  pivot_wider(names_from = Year, values_from = incidents)

dta[is.na(dta)] <- 0
