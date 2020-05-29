library(ggplot2)
library(ggthemes)
library(cowplot)
library(tidyverse)
library(RColorBrewer)
library(ggpmisc)
library(dplyr)

setwd("/Users/helenakanya/UBC/BDC/bdc/backend/api/data")

############# FUNCTIONS #############
rm_na <- function(DF, col, lim_na = 2, colnames){
  cnt_na <- apply(DF[col], 1, function(z) sum(is.na(z)))
  DF <- DF[cnt_na <= lim_na,]
  colnames(DF) <- colnames
  return(DF)
}

df <- read.csv("web_ready/grouped_master.csv", header = T, check.names = F)
sub_df <- subset(df, select = c("country", "continent", "Gdp pc usd inflation adjusted",
                                "Gni pc constant 2010 u", "Hdi human development index",
                                "Current health expenditure (CHE) as percentage of gross domestic product (GDP) (%)",
                                "Current health expenditure (CHE) per capita in US$",
                                "Out-of-pocket expenditure (OOP) per capita in US$",
                                "Breast cancer deaths per 100000 women",
                                "Breast cancer new cases per 100000 women", 
                                "Prostate cancer deaths per 100000 men",                                             
                                "Prostate cancer new cases per 100000 men",
                                "Computed tomography", "Magnetic resonance imaging",
                                "Positron emission tomography", "Gamma camera or nuclear medicine",                                                  
                                "Linear accelerator", "Telecobalt unit", "Radiotherapy",                                                                      
                                "Registered Labs", "Labs with clinical tests", "Labs with research tests"))
sub_df <- rm_na(sub_df, col = (1:12), colnames = c("country", "continent", "GDP", "GNI", "HDI", "CHE/GDP", "CHE_pc",
                                     "OOP_pc", "BC_deaths", "BC_new", "PC_deaths", "PC_new", 
                                     "CT", "MRI", "PET", "gamma", "linac", "cobalt", "RT", 
                                     "labs", "clinical_lab", "research_lab"))

#################################################################################
############# CATEGORIZATION #############
cat <- sub_df[c("country", "continent", "HDI")]
lims <- c(0.56, 0.73, 0.804)

cat["dev_level"] <- NULL
cat$dev_level[cat$HDI <= lims[1]] <- 4
cat$dev_level[cat$HDI >= lims[1]] <- 3
cat$dev_level[cat$HDI >= lims[2]] <- 2
cat$dev_level[cat$HDI >= lims[3]] <- 1
DF <- merge(cat, sub_df, by = c("country", "continent", "HDI"), all =T)

############# PLOTTING #############
y_ax <- c("HDI", "GDP", "GNI")
y_lab <- c("Human Development Index (HDI)", "Gross Domestic Product (GDP)", "Gross national Income (GNI)")
x_ax <- c("continent")
x_lab <- c("continent")
sections <- list(c(0.56, 0.73, 0.804), c(1720, 5950, 15500), c(1665, 5330, 15150))
plt_dim <- c(1,3)
save_file = c("place_vs_econ.png") # "tech_vs_HDI.png", "tech_vs_GDP.png", "tech_vs_GNI.png")

list_plt <- list()
for (j in 1:length(y_ax)){
  for (i in 1:length(x_ax)){
    sub_df["y_plot"] <- sub_df[y_ax[j]]
    sub_df["x_plot"] <- sub_df[x_ax[i]]
    
    c <- length(list_plt) + 1
    list_plt[[c]] <- ggplot(sub_df, mapping=aes(x = x_plot, y = y_plot, colour = continent)) +
      xlab(x_ax[i]) + ylab(y_ax[j]) + geom_point(size = 0.5)
    
    for (l in 1:length(sections)){
      list_plt[[c]] <- list_plt[[c]] + geom_hline(yintercept=sections[[j]][l], linetype="dashed")
    }
  }
#  plot_grid(plotlist=list_plt, nrow = plt_dim[1], ncol = plt_dim[2])
#  ggsave(file = save_file[j], width = 30, height = 30, units = "cm")
}

plot_grid(plotlist=list_plt, nrow = plt_dim[1], ncol = plt_dim[2], scale = 0.9)
ggsave(file = save_file, width = 50, height = 15, units = "cm")



plt_1 <- ggplot(sub_df, mapping=aes(x=country, y=GDP)) + geom_point(aes(colour = continent)) +
  scale_fill_hue() + geom_hline(yintercept=5755, linetype="dashed", aes(colour = "black")) + 
  geom_hline(yintercept=1618, linetype="dashed", aes(colour = "red")) +
  geom_hline(yintercept=15400, linetype="dashed", aes(colour = "green")) 


