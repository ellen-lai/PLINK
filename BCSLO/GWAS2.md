# GWAS
Input files: BC_GS_ES_SLO

## Accounting for population stratification: IBS clustering
```javascript
../../plink_mac/plink --dog --file ../../data/BC_GS_ES_SLO --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --cluster --mds-plot 4 --cc --ppc 0.05 --out BC_GS_ES_SLOclust
```
