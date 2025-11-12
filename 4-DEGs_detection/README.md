# DEGs detection based on the ortholgous genes
## Obtain the reads number matrix
```bash
# 1. Obtain the reference for each species
perl get_sequences_ref.pl -input=final_blast_orth_group -nuc=/orf_nuc/ -output=final_reference
# RSEM for reads number matrix
rsem-prepare-reference --bowtie2 Blenny.fa Blenny --bowtie2
rsem-prepare-reference --bowtie2 Blue_eyed.fa Blue_eyed --bowtie2
rsem-prepare-reference --bowtie2 Common.fa Common --bowtie2
rsem-prepare-reference --bowtie2 Yaldwyn.fa Yaldwyn --bowtie2
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
sh merge.sh >total_Yaldwyn.gene.matrix
```

