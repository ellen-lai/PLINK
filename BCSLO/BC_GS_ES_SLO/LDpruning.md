# LD-based variant pruning
1. Variant pruning using `--indep`
```javascript
../../plink_mac/plink --dog --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --indep 50 5 10 --file ../../data/BC_GS_ES_SLO --out BC_GS_ES_SLO_prune1
```
  * 83972 of 119116 variants removed, 35,144 variants remaining
  * Association using pruned SNPs and no permutations
  ```javascript
  ../../plink_mac/plink --dog --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --assoc --adjust --file ../../data/BC_GS_ES_SLO --out BC_GS_ES_SLO_as3
  ```
   * Top SNPs
    
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
  * 100k permutation
  ```javascript
  ../../plink_mac/plink --dog --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --assoc mperm=100000 --adjust --file ../../data/BC_GS_ES_SLO --out BC_GS_ES_SLO_as4
  ```
  
    * Top SNPs

```
    $ sort -k 4n BC_GS_ES_SLO_as4.assoc.mperm | head
 CHR               SNP         EMP1         EMP2 
  12    BICF2S23661198        1e-05       0.1583 
  12    BICF2S23416139        1e-05       0.1595 
  17   BICF2G630202698      2.5e-05       0.1975 
  17   BICF2G630202687      2.5e-05       0.2495 
   4      BICF2P243678        1e-05       0.2849 
  17   BICF2G630207334        9e-05        0.553 
  12      BICF2P742333     0.000145       0.6071 
   4      BICF2P182666     0.000145       0.6088 
  12    BICF2S23021596      2.5e-05       0.6245
```

2. Variant pruning using `--indep-pairwise`

```javascript
../../plink_mac/plink --dog --maf 0.05 --mind 0.05 --geno 0.05 --ci 0.95 --hwe 0.0001 --indep-pairwise (insert parameters) --file ../../data/BC_GS_ES_SLO --out BC_GS_ES_SLO_prune2
```
