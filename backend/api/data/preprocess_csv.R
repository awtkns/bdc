library(ggplot2)
library(ggthemes)
library(cowplot)
library(tidyverse)
library(RColorBrewer)

setwd("/Users/helenakanya/UBC/BDC/bdc/backend/api/data/")

csv_list <- list.files(path = "WHO_data", pattern = "\\.csv$", full.names = T)

data <- read.csv(csv_list[1], header = T, sep = ",", skip = 1, check.names = F)
data_c <- gather(data, "year" , "cancer_policy", -Country)

data2 <- read.csv(csv_list[2], header = T, sep = ",", skip = 1)
data_c2 <- data2 %>% gather("year" , "cancer_prevention", -Country) %>% 
  extract("year", c("year", "suffix"), "([^X]{4})(..|)")  %>%
  spread(suffix, "cancer_prevention")

data3 <- read.csv(csv_list[3], header = T, sep = ",", skip = 1, check.names = T)
header <- apply((read.csv(csv_list[3], nrows =1, header = F)), 1, function(x)unique(x[!is.na(x)])) #unique(read.csv(csv_list[3], nrows =1, header = F))

data_c3 <- data3 %>% gather("year" , "CHE/GDP", -Country) %>% 
  extract("year", c("year", "suffix"), "([^X]{4})(..|)")  %>%
  spread(suffix, "CHE/GDP")
names(data_c3) <- c("country", "year", header)

format_csv <- function(csv_path){
  data <- read.csv(csv_path, header = T, sep = ",", skip = 1, check.names = T)
  header <- apply((read.csv(csv_path, nrows =1, header = F)), 1, function(x)unique(x[!is.na(x)]))
  
  data <- gather(data, "year" , "values", -Country) %>% 
    extract("year", c("year", "suffix"), "([^X]{4})(..|)")  %>%
    spread(suffix, "values")
  names(data) <- c("country", "year", header)
  return(data)
}

mega_data <- data.frame(country=character(0),year=numeric(0))
for (i in csv_list){
  print(paste0("processing: ", i))
  data <- format_csv(i)
  mega_data <- merge(mega_data, data, by = c("country", "year"), all = T)
}

write.csv(mega_data, file = "combined_WHO.csv")

