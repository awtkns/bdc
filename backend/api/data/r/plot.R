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

df <- read.csv("web_ready/grouped_master_dev_level.csv", header = T, check.names = F)
sub_df <- subset(df, select = c("country", "continent", "dev_level", "Gdp pc usd inflation adjusted",
                                "Gni pc constant 2010 u", "Hdi human development index",
                                "Current health expenditure (CHE) as percentage of gross domestic product (GDP) (%)",
                                "Current health expenditure (CHE) per capita in US$",
                                "Out-of-pocket expenditure (OOP) per capita in US$",
                                "Breast cancer deaths per 100000 women",
                                "Breast cancer new cases per 100000 women", 
                                "Prostate cancer deaths per 100000 men",                                             
                                "Prostate cancer new cases per 100000 men",
                                "Existence of national screening program for breast cancer",
                                "Computed tomography", "Magnetic resonance imaging",
                                "Positron emission tomography", "Gamma camera or nuclear medicine",                                                  
                                "Linear accelerator", "Telecobalt unit", "Radiotherapy",                                                                      
                                "Registered Labs", "Labs with clinical tests", "Labs with research tests"))
sub_df <- rm_na(sub_df, col = (1:12), colnames = c("country", "continent", "dev_level", "GDP", "GNI", "HDI", "CHE/GDP", "CHE_pc",
                                     "OOP_pc", "BC_deaths", "BC_new", "PC_deaths", "PC_new", "BC_test",
                                     "CT", "MRI", "PET", "gamma", "linac", "cobalt", "RT", 
                                     "labs", "clinical_lab", "research_lab"))

#################################################################################
############# CATEGORIZATION #############
cat <- sub_df[c("country", "continent", "HDI")]
lims <- c(0.56, 0.73, 0.804)

cat["Quartile"] <- NULL
cat$Quartile[cat$HDI <= lims[1]] <- 1
cat$Quartile[cat$HDI >= lims[1]] <- 2
cat$Quartile[cat$HDI >= lims[2]] <- 3
cat$Quartile[cat$HDI >= lims[3]] <- 4
DF <- merge(cat, sub_df_2, by = c("country", "continent", "HDI"), all =T)

############# add columns #############
sub_df_2 <- sub_df
sub_df_2["diagnostic"] <- sub_df_2$CT + sub_df_2$MRI + sub_df_2$PET + sub_df_2$gamma
sub_df_2["treatment"] <- sub_df_2$linac + sub_df_2$cobalt + sub_df_2$RT
sub_df_2["diag/treat"] <- sub_df_2$diagnostic / sub_df_2$treatment

sub_df_2["BC_rel_death"] <- sub_df_2$BC_deaths / sub_df_2$BC_new
sub_df_2["PC_rel_death"] <- sub_df_2$PC_deaths / sub_df_2$PC_new

############# PLOTTING #############
DF <- sub_df_2
y_ax <- c("CHE/GDP") #"BC_new", "BC_deaths", "PC_new", "PC_deaths")
y_lab <- c("Health expenditure as a percentage of GDP (%)") #"Human Development Index (HDI)", "New cases of breast cancer per 100k women", "New cases of prostate cancer per 100k men") #c("CHE/GDP (%)", "CHE per capita", "OOP per capita")
x_ax <- c("diagnosis", "treatment") #"HDI", "GDP", "GNI")
x_lab <- c("# of imaging devices per million population", "# of treatment technology per million population", "Availability of breast cancer screening program")
#sections <- list(c(0.56, 0.73, 0.804), c(1720, 5950, 15500), c(1665, 5330, 15150))
y_ax <- c("BC_rel_death", "PC_rel_death")
x_ax <- c("CT", "MRI", "PET", "gamma", "linac", "cobalt", "RT")
x_lab <- c("CT", "MRI", "PET", "Gamma camera", "Linear accelerator", "Telecobalt machine")
plt_dim <- c(1,2)
save_file = c("tech_vs_expenditure.png") # "tech_vs_HDI.png", "tech_vs_GDP.png", "tech_vs_GNI.png")
title <- c("Breast Cancer", "Prostate Cancer")

list_plt <- list()
for (i in 1:length(x_ax)){
  for (j in 1:length(y_ax)){
    DF["y_plot"] <- DF[y_ax[j]]
    DF["x_plot"] <- DF[x_ax[i]]
    DF$Quartile <- as.factor(DF$Quartile)
    
    c <- length(list_plt) + 1
    list_plt[[c]] <- ggplot(DF, mapping=aes(x = x_plot, y = y_plot, colour = Quartile)) +
      xlab(paste0(x_lab[i])) + ylab(y_lab[j]) + scale_color_discrete() +
      geom_point(size = .7) #+ theme(plot.title = element_text(face = 'bold'), legend.position = "none")
    
   # if (c == j) {
   #   list_plt[[c]] <- list_plt[[c]] + ggtitle(title[c])
   # }
  }
}

plot_grid(plotlist=list_plt, nrow = plt_dim[1], ncol = plt_dim[2], scale = 0.9)
ggsave(file = save_file, width = 30, height = 15, units = "cm")

############# PLOTTING REL DEATH PER DEV LEVEL #############
DF <- sub_df_2
y_ax <- c("BC_rel_death", "PC_rel_death")
y_lab <- c("Relative mortality of breast cancer in women", "Relative mortality of prostate cancer in men") #c("CHE/GDP (%)", "CHE per capita", "OOP per capita")
x_ax <- c("CT", "MRI", "PET", "gamma", "linac", "cobalt", "RT")
x_lab <- c("CT", "MRI", "PET", "Gamma camera", "Linear accelerator", "Telecobalt machine")
#sections <- list(c(0.56, 0.73, 0.804), c(1720, 5950, 15500), c(1665, 5330, 15150))
plt_dim <- c(6,2)
save_file = c("tech1_vs_rel_death.png") # "tech_vs_HDI.png", "tech_vs_GDP.png", "tech_vs_GNI.png")

for (l in 1:4) {
  list_plt <- list()
  subDF <- subset(DF, subset = Quartile == l)
  for (i in 1:length(x_ax)){
    for (j in 1:length(y_ax)){
      subDF["y_plot"] <- subDF[y_ax[j]]
      subDF["x_plot"] <- subDF[x_ax[i]]
      
      c <- length(list_plt) + 1
      
      list_plt[[c]] <- ggplot(subDF, mapping=aes(x = x_plot, y = y_plot)) +
        xlab(x_ax[i]) + ylab("Relative Mortality") + geom_point(alpha = 0.8, colour = "slategrey") + 
        geom_smooth(method='lm', formula= y~x, se = F, colour = "black", size = 1) +
        stat_poly_eq(formula = y~x, aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
                     parse = TRUE)
      if (c == j) {
        list_plt[[c]] <- list_plt[[c]] + ggtitle(title[c])}
    }
  }
  plot_grid(plotlist=list_plt, nrow = plt_dim[1], ncol = plt_dim[2], scale = 0.85)
  ggsave(file = paste0("lm_test_vs_rel_death_dev_", l, ".png"), width = 25, height = 60, units = "cm")
}
plot_grid(plotlist=list_plt, nrow = plt_dim[1], ncol = plt_dim[2], scale = 0.85)
ggsave(file ="tech1_vs_rel_death_dev_all", width = 60, height = 20, units = "cm")

######### BREAST CANCER TESTS BAR PLOTS ##############
bct_y <- subset(sub_df_2, subset = BC_test == "Yes", select = c("country", "continent", "BC_test", "BC_rel_death"))
bct_n <- subset(sub_df_2, subset = BC_test == "No", select = c("country", "continent", "BC_test", "BC_rel_death"))

sum_bct_y <- summary(bct_y$BC_rel_death)
sum_bct_n <- summary(bct_n$BC_rel_death)
#Existence of national screening program for breast cancer
bc_df <- data.frame(name=c("Yes", "No"), mean = c("44.73", "72.06"), sd = c("23.87", "28.92"))
t <- t.test(bct_n$BC_rel_death, bct_y$BC_rel_death)

ggplot(bc_df, aes(x = name, y = mean)) + scale_fill_brewer() + geom_bar(stat = "identity") + 
  ylab("Mean relative mortality (%)") + xlab("Existence of national screening program for breast cancer")

ggsave(file = "bc_barplot.png", width = 15, height = 15, units = "cm")
#p-value = 1.055e-05 << 0.001

ggplot(bc_df, aes(x = name, y = mean)) + scale_fill_brewer() + geom_bar(stat = "identity") + 
  ylab("Mean relative mortality (%)") + xlab("Existence of national screening program for breast cancer")
