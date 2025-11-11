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
```
