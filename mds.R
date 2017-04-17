# Import data
# Phenotypic scoring (must make yourself from TFAM: 2 columns with headers IID and phen)
bc43phen <- read.delim("path/to/file/bc43phen.txt")

# MDS file from plink
bc43clust <- read.csv("path/to/file/bc43clust.mds", sep="")

# Add pheno column from phenotypic scoring df to MDS df
bc43_mds <- inner_join(bc43clust, bc43phen, by="IID")

# MDS with points color-coded by cluster and shape-coded by phenotype
bc43_mds %>%
  ggplot(aes(x=C1, y=C2, color=as.character(SOL), shape=as.character(phen)))+
  geom_point()+
  theme_bw() +
  ggsave("bc43sloclust.png", width = 8, height = 6, units = c("in"))
