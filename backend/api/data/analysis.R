library(ggplot2)
library(ggthemes)
library(cowplot)
library(tidyverse)
library(RColorBrewer)

setwd("/Users/helenakanya/UBC/BDC/bdc/backend/api/data/")

csv <- list.files(path = "raw", pattern = "\\.csv$", full.names = T)
years <- as.character(2000:2020)

format_csv <- function(csv_path){
  data <- read.csv(csv_path, header = T, sep = ",", skip = 1, check.names = T)
  data <- 
  #header <- apply((read.csv(csv_path, nrows =1, header = F)), 1, function(x)unique(x[!is.na(x)]))
  
  #data <- gather(data, "year" , "values", -Country) %>% 
  #  extract("year", c("year", "suffix"), "([^X]{4})(..|)")  %>%
  #  spread(suffix, "values")
  names(data) <- c("country", "year", header)
  return(data)
}

mega_data <- data.frame(country=character(0),year=numeric(0))
for (i in csv_list){
  print(paste0("processing: ", i))
  data <- format_csv(i)
  mega_data <- merge(mega_data, data, by = c("country", "year"), all = T)
}