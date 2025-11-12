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
# select the orthgoups that contain sequences of all species, and map them to the swiss-prot
perl blastp_uni.pl Orthogroups/Orthogroups.GeneCount.tsv
```
