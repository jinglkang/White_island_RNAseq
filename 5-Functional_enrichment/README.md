# Functional enrichment
```bash
# The DEGs between V1 and control, and V2 and control were used as the input for functional enrichment
###################################################################
# Summary in the functions that were reduced to most specific terms
###################################################################
# functions related to circadian rhythm, vision perception, energy metabolism, stimulus response
# Extract the DEGs underlying these consitent functions between V1 and control, and V2 and control
extract_gene_functions -i V1C/*Nofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions Consistent_CR_func.txt --output Consistent_CR_DEGs_V1C
extract_gene_functions -i V2C/*Nofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions Consistent_CR_func.txt --output Consistent_CR_DEGs_V2C
# Extract the functional enrichment information for plot
cat Consistent_functions/Consistent_*_func.txt > Consistent_sigFunc.txt
perl extract_consistent_funcInfo.pl V1C > Consistent_sigFunc_plot1.txt
perl extract_consistent_funcInfo.pl V2C > Consistent_sigFunc_plot2.txt
cat Consistent_sigFunc_plot1.txt Consistent_sigFunc_plot2.txt > Consistent_sigFunc_plot.txt
```
