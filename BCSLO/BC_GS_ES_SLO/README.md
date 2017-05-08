# GWAS
Input files: BC_GS_ES_SLO

## Quantifying population stratification: IBS clustering
```javascript
../../plink_mac/plink --dog --file ../../data/BC_GS_ES_SLO --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --cluster --mds-plot 4 --cc --ppc 0.05 --out BC_GS_ES_SLOclust
```
*  file conversion to make TFAM file for MDS plot
```javascript
../plink_mac/plink --dog --file BC_GS_ES_SLO --recode transpose --out BC_GS_ES_SLO
```

MDS plots were generated in R using [this code](BC_GS_ES_SLO_mds.R).

* MDS by clusters (as determined by the PPC threshold)
![mds](BC_GS_ES_SLO_mds_cluster.jpeg)

* MDS by breed
![mds](BC_GS_ES_SLO_mds_breed.jpeg)

## GWA, without accounting for population stratification
1. Association with no permutations
```javascript
../../plink_mac/plink --assoc --dog --file ../../data/BC_GS_ES_SLO --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --adjust --out BC_GS_ES_SLO_as1
```
  * Genomic inflation: lambda = 1.00608
  ![qqplot](as1qqplot.jpeg)
  * Unadjusted (for multiple testing) p-values
  ![mh](as1_unadj.jpeg)
  
  NOTE: most Bonferroni-corrected p-values were = 1, so the Manhattan plot was not plotted
  
```
 CHR               SNP      UNADJ         GC       BONF       HOLM   SIDAK_SS   SIDAK_SD     FDR_BH     FDR_BY
  12    BICF2S23661198  1.538e-06  1.654e-06     0.1832     0.1832     0.1674     0.1674    0.09072          1 
  12    BICF2S23416139  1.567e-06  1.685e-06     0.1866     0.1866     0.1702     0.1702    0.09072          1 
  17   BICF2G630202698  2.285e-06  2.451e-06     0.2722     0.2721     0.2383     0.2383    0.09072          1 
  17   BICF2G630202687  3.229e-06  3.458e-06     0.3847     0.3847     0.3193     0.3193    0.09617          1 
   4      BICF2P243678  4.258e-06  4.551e-06     0.5072     0.5071     0.3978     0.3978     0.1014          1 
  17   BICF2G630207334  1.495e-05  1.586e-05          1          1     0.8315     0.8315     0.2474          1 
  12      BICF2P742333  1.817e-05  1.926e-05          1          1     0.8852     0.8851     0.2474          1 
   4      BICF2P182666  1.823e-05  1.932e-05          1          1     0.8859     0.8859     0.2474          1 
  12    BICF2S23021596  1.879e-05  1.991e-05          1          1     0.8933     0.8933     0.2474          1 
 ```

2. Association with permutations
```javascript
../../plink_mac/plink --assoc mperm=100000 --dog --file ../../data/BC_GS_ES_SLO --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --adjust --out BC_GS_ES_SLO_as2
```
* Genomic inflation: lambda = 1.00608
![qqplot](as2qqplot.jpeg)
![mh](as2mhEMP2.jpeg)
  
```
$ sort -k 4n BC_GS_ES_SLO_as2.assoc.mperm | head
 CHR               SNP         EMP1         EMP2 
  12    BICF2S23661198        1e-05       0.1561 
  12    BICF2S23416139        1e-05       0.1572 
  17   BICF2G630202698        1e-05       0.1953 
  17   BICF2G630202687        1e-05       0.2493 
   4      BICF2P243678      1.5e-05       0.2842 
  17   BICF2G630207334        6e-05       0.5518 
  12      BICF2P742333     0.000145       0.6053 
   4      BICF2P182666      0.00014        0.607 
  12    BICF2S23021596        4e-05       0.6234 
```
