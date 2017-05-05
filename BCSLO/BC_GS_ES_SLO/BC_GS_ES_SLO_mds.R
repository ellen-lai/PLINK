library(ggplot2)
library(dplyr)
library(tidyr)

# set working directory
setwd("./Google_Drive/Oberbauer Lab/BC_SLO/Rstudio/bcslo")

# load global environment
load("C:/Users/elai/Desktop/plink_1.9/R_studio/warts.RData")

# Import data
# MDS file from plink
M <- read.csv("../../PLINK 1.9/analyses/BC_GS_ES_SLO/BC_GS_ES_SLOclust.mds", sep="")

# Phenotypic scoring (must make yourself from TFAM: 2 columns with headers IID and phen)
tfam <- read_delim("~/Google_Drive/Oberbauer Lab/BC_SLO/PLINK 1.9/data/BC_GS_ES_SLO.tfam", " ", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)

phen <- select(tfam,2,6) #subset column 2 (IID) and 6 (status) from the TFAM file and put into phen data frame

colnames(phen) <- c("IID", "Status") #assign headers to phen df

#add column for breed
phen$Breed <-ifelse(grepl("BC", phen$IID),"Border Collie",
                    ifelse(grepl("cHD1_", phen$IID), "Gordon Setter", "English Setter"))

nrow(phen[phen$Breed == "Gordon Setter",]) # check have correct number of GS (38)

# Add pheno column from phenotypic scoring df to MDS df
M <- inner_join(M, phen, by="IID")

# MDS with points color-coded by cluster and shape-coded by phenotype
M %>%
  ggplot(aes(x=C1, y=C2, shape=as.character(Status), color=as.character(SOL)))+
  geom_point()+
  labs(shape="Status", color="Cluster number") +
  scale_shape_discrete(labels = c("Control", "Case")) +
  theme_bw() +
  ggsave("BC_GS_ES_SLO_mds_cluster.pdf", width = 8, height = 6, units = c("in")) +
  ggsave("BC_GS_ES_SLO_mds_cluster.jpeg", width = 8, height = 6, units = c("in"))

#MDS with points color-coded by breed and shape-coded by phenotype
M %>%
  ggplot(aes(x=C1, y=C2, shape=as.character(Status), color=Breed)) +
  geom_point() +
  labs(shape="Status", color="Breed") +
  scale_shape_discrete(labels = c("Control", "Case")) +
  theme_bw() +
  ggsave("BC_GS_ES_SLO_mds_breed.pdf", width = 8, height = 6, units = c("in")) +
  ggsave("BC_GS_ES_SLO_mds_breed.jpeg", width = 8, height = 6, units = c("in"))

