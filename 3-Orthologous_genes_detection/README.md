# Use OrthoFinder v2.3.3 for orthologous genes detection
## 1. Prepare the input for OrthoFinder
```bash
# Transdecoder to obtain the protein sequences
TransDecoder.LongOrfs -t Blenny.fa -O Blenny_orf
TransDecoder.LongOrfs -t Blue_eyed.fa -O Blue_eyed_orf
TransDecoder.LongOrfs -t Common.fa -O Common_orf
TransDecoder.LongOrfs -t Yaldwyn.fa -O Yaldwin_orf
```
## 2. Run OrthoFinder
```bash
# the longest_orfs.pep in the results directory of Transdecoder will be used as input for OrthoFinder
# change the header of fasta file for each species
perl Change_header.pl
mkdir orthofinder_input; mv *-1.fa orthofinder_input
orthofinder -f orthofinder_input -a 32

# Make sure the orthogroups including transcripts of all four species, and only keep the representative transcript 
# 1. select the orthgoups that contain sequences of all species, and map them to the swiss-prot
perl blastp_uni.pl Orthogroups/Orthogroups.GeneCount.tsv
# 2. get the reads number per transcript per species
# use the nucleotide sequences corresponding as the longest orf pep sequences as reference
# Build index
rsem-prepare-reference --bowtie2 Blenny.fa Blenny --bowtie2
rsem-prepare-reference --bowtie2 Blue_eyed.fa Blue_eyed --bowtie2
rsem-prepare-reference --bowtie2 Common.fa Common --bowtie2
rsem-prepare-reference --bowtie2 Yaldwin.fa Yaldwin --bowtie2
# 3. align
perl RSEM_align.pl
# 4. obtain the read number matrix
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
mkdir reads_matrix; cp *gene.matrix reads_matrix/
# 5. Get the representative transciprt per species per orthogroups
perl get_best_blast_orthogroup.pl -blast_result=blastp_result -reads_matrix=reads_matrix
# Then we obtain the orthogroups as the orthologous genes which contain the transcripts of all four species and only keep the respresentative transcript per species
```
