# DEGs detection based on the ortholgous genes
## Obtain the reads number matrix
```bash
# 1. Obtain the reference for each species
perl get_sequences_ref.pl -input=final_blast_orth_group -nuc=/orf_nuc/ -output=final_reference
# RSEM for reads number matrix
rsem-prepare-reference --bowtie2 Blenny.fa Blenny --bowtie2
rsem-prepare-reference --bowtie2 Blue_eyed.fa Blue_eyed --bowtie2
rsem-prepare-reference --bowtie2 Common.fa Common --bowtie2
rsem-prepare-reference --bowtie2 Yaldwyn.fa Yaldwin --bowtie2
# 2. Align
perl RSEM_align.pl
# 3. Obtain the read number matrix
# In each species directory
# crested blenny
perl -e '@files=<*.genes.results>;print "../merge_RSEM_frag_counts_single_table.pl";foreach $file(@files){print " $file "}'>merge.sh
sh merge.sh >total_Blenny.gene.matrix
# blue-eyed triplefin
perl -e '@files=<*.genes.results>;print "../merge_RSEM_frag_counts_single_table.pl";foreach $file(@files){print " $file "}'>merge.sh
sh merge.sh >total_Blue_eyed.gene.matrix
# common triplefin
perl -e '@files=<*.genes.results>;print "../merge_RSEM_frag_counts_single_table.pl";foreach $file(@files){print " $file "}'>merge.sh
sh merge.sh >total_Common.gene.matrix
# Yaldwin's triplefin
perl -e '@files=<*.genes.results>;print "../merge_RSEM_frag_counts_single_table.pl";foreach $file(@files){print " $file "}'>merge.sh
sh merge.sh >total_Yaldwin.gene.matrix
```
## DEGs detection
```bash
DESeq --matrix Blenny_matrix.xls --samples coldata_blenny.txt --column Site --prefix Blenny
DESeq --matrix Blueeyed_matrix.xls --samples coldata_Blueeyed.txt --column Site --prefix Blueeyed
DESeq --matrix Common_matrix.xls --samples coldata_Common.txt --column Site --prefix Common
DESeq --matrix Yaldwin_matrix.xls --samples coldata_Yaldwin.txt --column Site --prefix Yaldwin
```
## Log2Foldchange DEGs per species comparisons across all four species
### V1 vs. control
```bash
# 1. Blenny
perl Extract_lo2FC_DEGs.pl 1 Blenny Blueeyed Common Yaldwyn > Blenny_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Blenny across species

# 2. Blueeyed
perl Extract_lo2FC_DEGs.pl 1 Blueeyed Blenny Common Yaldwyn > Blueeyed_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Blueeyed across species

# 3. Common
perl Extract_lo2FC_DEGs.pl 1 Common Blenny Blueeyed Yaldwyn > Common_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Common across species

# 4. Yaldwin
perl Extract_lo2FC_DEGs.pl 1 Yaldwin Blenny Blueeyed Common > Yaldwin_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Yaldwyn across species
```
### V2 vs. control
```bash
# 1. Blenny
perl Extract_lo2FC_DEGs.pl 2 Blenny Blueeyed Common Yaldwyn > Blenny_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Blenny across species

# 2. Blueeyed
perl Extract_lo2FC_DEGs.pl 2 Blueeyed Blenny Common Yaldwyn > Blueeyed_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Blueeyed across species

# 3. Common
perl Extract_lo2FC_DEGs.pl 2 Common Blenny Blueeyed Yaldwyn > Common_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Common across species

# 4. Yaldwyn
perl Extract_lo2FC_DEGs.pl 2 Yaldwyn Blenny Blueeyed Common > Yaldwyn_DEGs_log2FC.txt
# R test the differences between the DEG log2FC of Yaldwyn across species
```
### R test
```test.R
library(tidyverse)
library(ggpubr)
library(rstatix)
# setwd("V1C/") or setwd("V2C/")
# 1. Blenny
# Log2FC of Blennty DEGs across species
data <- read.table("Blenny_DEGs_log2FC.txt", header = T, sep="\t")
names(data)
head(data)
oneway <- aov(Log2FC ~ Species, data = data)
summary(oneway)
data %>%  pairwise_t_test(
  Log2FC ~ Species, 
  p.adjust.method = "bonferroni"
)

# 2. Blueeyed
# Log2FC of Blueeyed DEGs across species
data <- read.table("Blueeyed_DEGs_log2FC.txt", header = T, sep="\t")
names(data)
head(data)
oneway <- aov(Log2FC ~ Species, data = data)
summary(oneway)
data %>%  pairwise_t_test(
  Log2FC ~ Species, 
  p.adjust.method = "bonferroni"
)

# 3. Common
# Log2FC of Common DEGs across species
data <- read.table("Common_DEGs_log2FC.txt", header = T, sep="\t")
names(data)
head(data)
oneway <- aov(Log2FC ~ Species, data = data)
summary(oneway)
data %>%  pairwise_t_test(
  Log2FC ~ Species, 
  p.adjust.method = "bonferroni"
)

# 4. Yaldwin
# Log2FC of Yaldwin DEGs across species
data <- read.table("Yaldwyn_DEGs_log2FC.txt", header = T, sep="\t")
names(data)
head(data)
oneway <- aov(Log2FC ~ Species, data = data)
summary(oneway)
data %>%  pairwise_t_test(
  Log2FC ~ Species, 
  p.adjust.method = "bonferroni"
)
```
