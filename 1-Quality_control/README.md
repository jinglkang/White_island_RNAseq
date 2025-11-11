# Quality_control
```bash
# 1. fastqc estimate the quality
mkdir fastqc; fastqc *.fastq.gz -o ./fastqc -t 32
# 2. find the summary result after running fastqc
find -name "summary.txt" | perl -ne 'chomp;print "$_\t"'|perl -alne 'print "cat $_ > all.samples.fastqc.txt"' > 1.sh
sh 1.sh
perl Extract_fastqc_results.pl > sort -u > all.samples.fastqc.result
# find the overrepresented sequences for the filtering of Trimmomatic
find -name "fastqc_data.txt" | perl -ne 'chomp;print "$_\t"'|perl -alne 'print "cat $_ > all.samples.fastqc_data.txt"'
less all.samples.fastqc_data.txt|perl -alne 'print if /^[ATCG]{8,}/'|cut -f 1|sort -u|perl -alne '$i++;$num=$i+2;print ">FlowCell$num\n$_"' > Overrepresented_sequences.fa
# 3. Trimmomatic to filter reads with low quality
# in the Trimmomatic working directory
# copy Overrepresented_sequences.fa to this working directory
cp ~/software/Trimmomatic-0.39/adapters/TruSeq2-PE.fa ./
cp ~/software/Trimmomatic-0.39/trimmomatic-0.39.jar ./
cat TruSeq2-PE.fa Overrepresented_sequences.fa >TruSeq2-PE-new.fa; mv TruSeq2-PE-new.fa TruSeq2-PE-final.fa
mkdir paired/; mkdir unpaired/
ll *.gz|perl -alne '@a=split /\./,$F[-1];print"$a[0]"'|perl -alne 's/_S\d+_R[1|2]\_001//;print'|sort -u >sample.name
perl Run_trimmomatic.pl
# 4. kraken to filter the potenital contaminations
mkdir kraken
for file in *_R1.fastq.gz; do name=${file/_R1.fastq.gz};kraken2 --db ~/software/kraken2/library --paired --threads 12 --gzip-compressed --unclassified-out kraken/${name}#.fastq ${name}_R1.fastq.gz ${name}_R2.fastq.gz --report kraken/reports/${name}.kraken_report --use-name --confidence 0.7 > kraken/total_output/${name}.out;done
```
