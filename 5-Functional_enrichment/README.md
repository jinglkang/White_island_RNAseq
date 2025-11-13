<img width="432" height="14" alt="image" src="https://github.com/user-attachments/assets/7467d204-7912-4a34-9e24-8d0a152b7652" /># Functional enrichment
## Consistent functions
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
## Specific functions responses in the common triplefin and crested blenny
### V1 vs. C
#### 1. Specific responses only in the common triplefin
```bash
# select the significant enriched functions in the common triplefin
# and make sure the other three species without any genes enriched in these functions
perl specific_sig_funcs_commontriplefin.pl > specific_sig_funcs_commontriplefin_V1C.txt # 278 functions
```
#### 2. Specific responses in both the common triplefin and crested blenny
```bash
# select the significant enriched functions in the common triplefin and crested blenny
# and make sure the other two species without any genes enriched in these functions
perl both_specific_sig_funcs_commonblenny.pl > both_specific_sig_funcs_commonblenny_V1C.txt # 132 functions
```
#### 3. Specific responses only in the crested blenny
```bash
# select the significant enriched functions in the crested blenny
# and make sure the other three species without any genes enriched in these functions
perl specific_sig_funcs_blenny.pl > specific_sig_funcs_blenny_V1C.txt # 0 function
```
### V2 vs. C
#### 1. Specific responses only in the common triplefin
```bash
# select the significant enriched functions in the common triplefin
# and make sure the other three species without any genes enriched in these functions
perl specific_sig_funcs_commontriplefin.pl > specific_sig_funcs_commontriplefin_V2C.txt # 46 functions
```
#### 2. Specific responses in both the common triplefin and crested blenny
```bash
# select the significant enriched functions in the common triplefin and crested blenny
# and make sure the other two species without any genes enriched in these functions
perl both_specific_sig_funcs_commonblenny.pl > both_specific_sig_funcs_commonblenny_V2C.txt # 2 functions
```
#### 3. Specific responses only in the crested blenny
```bash
# select the significant enriched functions in the crested blenny
# and make sure the other three species without any genes enriched in these functions
perl specific_sig_funcs_blenny.pl > specific_sig_funcs_blenny_V2C.txt # 4 function
```
## Generate the plot file
### V1 vs. C
```bash
perl generate_funcs_plot.pl specific_sig_funcs_commontriplefin_V1C_plot.txt > specific_sig_funcs_commontriplefin_V1C_plot_final.txt
perl generate_funcs_plot.pl both_specific_sig_funcs_commonblenny_V1C_plot.txt > both_specific_sig_funcs_commonblenny_V1C_plot_final.txt
```
### V2 vs. C
```bash
perl generate_funcs_plot.pl specific_sig_funcs_commontriplefin_V2C_plot.txt > specific_sig_funcs_commontriplefin_V2C_plot_final.txt
perl generate_funcs_plot.pl both_specific_sig_funcs_commonblenny_V2C.txt > both_specific_sig_funcs_commonblenny_V2C_plot_final.txt
perl generate_funcs_plot.pl specific_sig_funcs_blenny_V2C.txt > specific_sig_funcs_blenny_V2C_plot_final.txt
```
## Extract the genes underlying the specific functions
### V1 vs. C
```bash
# 1. Extract the genes underlying the specific functions in the common triplefin
less specific_sig_funcs_commontriplefin_V1C_plot.txt|perl -alne 'my @a=split /\t/;next if /Function/i;print $a[0]' > specific_sig_funcs_commontriplefin_V1C_extract.txt
extract_gene_functions -i CommonNofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions specific_sig_funcs_commontriplefin_V1C_extract.txt --output specific_sig_funcs_commontriplefin_V1C_genes

# 2. Extract the genes underlying functions specific in both the common triplefin and crested blenny
less both_specific_sig_funcs_commonblenny_V1C_plot.txt|perl -alne 'my @a=split /\t/;next if /Function/i;print $a[0]' > both_specific_sig_funcs_commonblenny_V1C_extract.txt
extract_gene_functions -i CommonNofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions both_specific_sig_funcs_commonblenny_V1C_extract.txt --output specific_sig_funcs_sharedCommontriplefin_V1C_genes
extract_gene_functions -i BlennyNofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions both_specific_sig_funcs_commonblenny_V1C_extract.txt --output specific_sig_funcs_sharedBlenny_V1C_genes

```
### V2 vs. C
```bash
# 1. Extract the genes underlying the specific functions in the common triplefin
less specific_sig_funcs_commontriplefin_V2C_plot.txt|perl -alne 'my @a=split /\t/;next if /Function/i;print $a[0]' > specific_sig_funcs_commontriplefin_V2C_extract.txt
extract_gene_functions -i CommonNofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions specific_sig_funcs_commontriplefin_V2C_extract.txt --output specific_sig_funcs_commontriplefin_V2C_genes

# 2. Extract the genes underlying functions specific in both the common triplefin and crested blenny
extract_gene_functions -i CommonNofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions both_specific_sig_funcs_commonblenny_V2C.txt --output specific_sig_funcs_sharedCommontriplefin_V2C_genes
extract_gene_functions -i BlennyNofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions both_specific_sig_funcs_commonblenny_V2C.txt --output specific_sig_funcs_sharedBlenny_V2C_genes

# 3. Extract the genes underlying functions specific in the crested blenny
extract_gene_functions -i BlennyNofilter_enrichment.txt -a unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions specific_sig_funcs_blenny_V2C.txt --output specific_sig_funcs_blenny_V2C_genes
```
## DEGs extraction underlying the target two functions
```bash
# 1. behavior (GO:0007610); 2. synaptic signaling (GO:0099536)
vi target_two_GOs.txt
# behavior
# synaptic signaling
# V1 vs. Control
extract_gene_functions -i BlennyNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Blenny_target_two_GOs_DEGs
extract_gene_functions -i BlueeyedNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Blueeyed_target_two_GOs_DEGs
extract_gene_functions -i CommonNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Common_target_two_GOs_DEGs
extract_gene_functions -i YaldwynNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Yaldwyn_target_two_GOs_DEGs

less Common_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "common triplefin\tV1vsC\t$go\t$key\t$des"}}' > Common_target_two_GOs_DEGs_uniq_V1C.txt
less Yaldwyn_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "Yaldwin triplefin\tV1vsC\t$go\t$key\t$des"}}' > Yaldwyn_target_two_GOs_DEGs_uniq_V1C.txt
less Blenny_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "crested blenny\tV1vsC\t$go\t$key\t$des"}}' > Blenny_target_two_GOs_DEGs_uniq_V1C.txt
less Blueeyed_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "blueeyed triplefin\tV1vsC\t$go\t$key\t$des"}}' > Blueeyed_target_two_GOs_DEGs_uniq_V1C.txt

# V2 vs. Control
extract_gene_functions -i BlennyNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Blenny_target_two_GOs_DEGs
extract_gene_functions -i BlueeyedNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Blueeyed_target_two_GOs_DEGs
extract_gene_functions -i CommonNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Common_target_two_GOs_DEGs
extract_gene_functions -i YaldwynNofilter_enrichment.txt -a ../unprot_name_description_orthgroup.txt --gene_column 1 --func_column 3 --functions target_two_GOs.txt --output Yaldwyn_target_two_GOs_DEGs

less Common_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "common triplefin\tV2vsC\t$go\t$key\t$des"}}' > Common_target_two_GOs_DEGs_uniq_V2C.txt
less Yaldwyn_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "Yaldwin triplefin\tV2vsC\t$go\t$key\t$des"}}' > Yaldwyn_target_two_GOs_DEGs_uniq_V2C.txt
less Blenny_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "crested blenny\tV2vsC\t$go\t$key\t$des"}}' > Blenny_target_two_GOs_DEGs_uniq_V2C.txt
less Blueeyed_target_two_GOs_DEGs.txt |perl -alne '@a=split /\t/;$hash1{$a[2]}="$a[3]\t$a[4]";$hash2{$a[2]}.=$a[1]." & ";END{foreach my $key (keys %hash1){my $des=$hash1{$key}; my $go=$hash2{$key};$go=~s/\s+&\s+$//;print "blueeyed triplefin\tV2vsC\t$go\t$key\t$des"}}' > Blueeyed_target_two_GOs_DEGs_uniq_V2C.txt
```
