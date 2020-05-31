library(ggplot2)
library(ggthemes)
library(cowplot)
library(tidyverse)
library(RColorBrewer)
library(ggpmisc)

setwd("/Users/helenakanya/UBC/BDC/bdc/backend/api/data")

############# FUNCTIONS #############
rm_na <- function(DF, lim_na = 2, colnames){
  cnt_na <- apply(DF, 1, function(z) sum(is.na(z)))
  DF <- DF[cnt_na <= lim_na,]
  colnames(DF) <- colnames
  return(DF)
}

get_max <- function(df, col = c("country", "year", "plot"), top = 10){
  # get countries with the top 'plot' values
  sub_df <- subset(df, year == max(df$year), select = col)
  lab <- as.vector(top_n(sub_df, top, plot)["country"])
  return(lab)
}

############# LOAD AND PROCESS DATA #############
df_year <- read.csv("web_ready/country_year_master.csv", header = T, check.names = F)
sub_year <- subset(df_year, select = c("country", "year",  "continent", "Gdp pc usd inflation adjusted",                                                     
                                       "Gni pc constant 2010 u",  "human development index (HDI)",
                                       "Current health expenditure (CHE) as percentage of gross domestic product (GDP) (%)",
                                       "Current health expenditure (CHE) per capita in US$",
                                       "Out-of-pocket expenditure (OOP) per capita in US$",
                                       "Breast cancer deaths per 100000 women",
                                       "Breast cancer new cases per 100000 women", 
                                       "Prostate cancer deaths per 100000 men",                                             
                                       "Prostate cancer new cases per 100000 men"))
sub_year <- rm_na(sub_year, colnames = c("country", "year",  "continent", "GDP", "GNI", "HDI", "CHE/GDP", "CHE_pc",
                                         "OOP_pc", "BC_deaths", "BC_new", "PC_deaths", "PC_new"))



############# PLOTTING #############
sub_year["BC_deaths_%"] <- (sub_year$BC_deaths/sub_year$BC_new) * 100
sub_year["PC_deaths_%"] <- (sub_year$PC_deaths/sub_year$PC_new) * 100
y_ax <- c("BC_deaths_%", "PC_deaths_%")
y_lab <- c("Relative mortality of breast cancer (%)", "Relative mortality of prostate cancer (%)")
x_ax <- c("HDI")
x_lab <- c("Human Development Index (HDI)")
plt_dim <- c(1, 2)
save_file = "HDI_vs_deaths_%_cancer.png"
top <- F #FALSE to use all data, TRUE to use top data

list_plt <- list()
for (i in 1:length(x_ax)){
  for (j in 1:length(y_ax)){
    sub_year["y_plot"] <- sub_year[y_ax[j]]
    sub_year["x_plot"] <- sub_year[x_ax[i]]
    
    if (top == TRUE){
      top_list <- get_max(sub_year)
      plt_df <- sub_year[is.element(sub_year$country, lab$country),]
      plt_attrs <- geom_line(aes(colour = country))
    }
    else{
      plt_df <- sub_year
      plt_attrs <- geom_line(aes(colour = country), show.legend = F)
    }
    
    c <- length(list_plt) + 1
    list_plt[[c]] <- ggplot(plt_df, mapping=aes(x=x_plot, y=y_plot)) +
      xlab(x_ax[i]) + ylab(y_ax[j]) + geom_point(size = 0.2) + plt_attrs
  }
}
plot_grid(plotlist=list_plt, nrow = plt_dim[1], ncol = plt_dim[2])
ggsave(file = save_file, width = 30, height = 15, units = "cm")


############# FIT PLOTTING #############
y_ax <- c("BC_deaths_%", "PC_deaths_%")
y_lab <- c("Relative mortality of breast cancer (%)", "Relative mortality of prostate cancer (%)")
x_ax <- c("HDI")
x_lab <- c("Human Development Index (HDI)")
plt_dim <- c(1, 2)
save_file <- "HDI_vs_rel_deaths_cancer_lm.png"

list_plt <- list()
for (i in 1:length(x_ax)){
  for (j in 1:length(y_ax)){
    sub_year["y_plot"] <- sub_year[y_ax[j]]
    sub_year["x_plot"] <- sub_year[x_ax[i]]
    
    c <- length(list_plt) + 1
    list_plt[[c]] <- ggplot(sub_year, mapping=aes(x=x_plot, y=y_plot)) +
      xlab(x_lab[i]) + ylab(y_lab[j]) + geom_point(size = 0.2, alpha = 0.4) +
      geom_line(aes(colour = country), show.legend = F, alpha = 0.4) +
      geom_smooth(method='lm', formula= y~x, se = F, colour = "red4", size = 1) +
      stat_poly_eq(formula = y~x, aes(label = paste(..eq.label.., ..rr.label.., ..p.value.label.., sep = "~~~")), 
                   parse = TRUE, label.x ="right")
  }
}
plot_grid(plotlist=list_plt, nrow = plt_dim[1], ncol = plt_dim[2], scale = 0.85)
ggsave(file = save_file, width = 40, height = 20, units = "cm")









