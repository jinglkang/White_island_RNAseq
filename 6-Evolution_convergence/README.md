# Convergent evolution analysis
## Orthologous genes detection
```bash
# 1. pre-orthologous genes detection
# Download the genome sequences and gtf file of six reference species from Esemble biomart
# Ensembl genome version: Japanese Medaka, Oryzias latipes ASM223467v1; Fugu, Takifugu rubripes fTakRub1.2; Stickleback, Gasterosteus aculeatus BROAD S1; Zebrafish, Danio rerio GRCz11; Platyfish, Xiphophorus maculatus X_maculatus-5.0-male; Spotted gar, Lepisosteus oculatus LepOcu1
# use the protein and nucleotide sequences of Apoly: Acanthochromis polyacanthus, Padel: Pomacentrus adelus, Pmol: Pomacentrus moluccensis, Acura: Amblyglyphidodon curacao, Daru: Dascyllus aruanus, Ocomp: Ostorhinchus compressus

# 2. orthologous genes detection
orthofinder -f ./ -a 20
# 2.1 phylogenetic tree construction of 16 species
# concatenate the resulting single copy ortholgous for phylogeny: 46 single cope orthologous genes
# copy the single copy fasta file to a new dir "single_copy" and change the name
perl Change_SCGheader.pl
# muscle to align, and trimal to trim based on the alignments of sequences
perl Align_trim_conca.pl > single_copy.concatenated.fasta
# change the fasta format to phylip format for phylogeny tree construction
fasta2phy.pl single_copy.concatenated.fasta >single_copy.concatenated.phy
raxmlHPC -f a -m PROTGAMMAAUTO -p 12345 -x 12345 -# 100 -s single_copy.concatenated.phy -o Spottedgar -n single_copy.concatenated -T 24

# 2.2 Run possvm: Divid the orthogroups into small orthogroups
conda activate possvm
export DISPLAY=:0.0
perl build_sub_orth.pl
less sub_orth_genecount.txt|perl -alne 'my $j;for (my $i = 1; $i <= 16; $i++){$j++ if $F[$i]>=1};print if $j==16'|wc -l # 5216 sub_orth
############################################################################################################
# 1. make sure all species have at least one transcript and only kept the genes with same uniprot gene name;
# 2. and select the longest one if there are more than one transcript for a species
############################################################################################################
# Step 1: select the transcript with same uniprot gene name across all 18 species
perl select_same_gene_nm.pl|perl -alne '$nb=@F;print if $nb==18' >Orth_same_gene_nm_16spe.txt

# Step 2: select the longest transcript if the gene has multiple transcript
perl select_longest.pl > Orth_same_gene_nm_16spe_longest.txt
# change the name: "Blue_eyed" to "Blueeyed"
perl change_name.pl > orth_id_paml.txt

# step 3: annotation to these orthologous genes across the 18 species
perl anno_orth.pl > orth_id_paml_ano.txt
```
## Prepare the sequences of each orthologous gene for comparison
```bash
# Clustal Omega v1.2.4: protein align
# pal2nal v14: protein-cDNA alignments
# trim: Gblocks v0.91b
# run prepare_input_paml.pl in parallel
perl prepare_input_paml_parallel.pl orth_id_paml.txt

# translate the nucleotide sequences of all orthologous genes in final_orth_input_paml.txt
# use translateDna.pl
perl translate_OG_pep.pl
```
## Convergent site detection
```bash
# Protein sequence comparison of each orthologous gene
# Detect the convergenet site within the crested blenny and common triplefin which are nonsynonymous substitutions compared to other 14 species
# same amino acid in crested blenny and common triplefin, but different with another same amino acid across the other 14 species
# perl Detect_Nons.pl $_
perl Detect_Nons_all.pl > convergent_evo_genes.txt
# annotation
perl anno_convergent_genes.pl
```
## Hyphy to detect the positively selected sites
```bash
# The crested blenny and common triplefin as the forebranch
conda create -n hyphy_env -c bioconda -c conda-forge hyphy
conda activate hyphy_env
# Run BUSTED-MH method implemented in HYPHY v2.5.85 to detect the positively selected sites of crested blenny and common triplefin
perl run_hyphy.pl CEGs_list.txt spe_Blenny_Common.tre Blenny_Common
```
