# Quality_control
```bash
# 1. fastqc estimate the quality
mkdir fastqc; fastqc *.fastq.gz -o ./fastqc -t 32
# 2. find the summary result after running fastqc
find -name "summary.txt" | perl -ne 'chomp;print "$_\t"'|perl -alne 'print "cat $_ > all.samples.fastqc.txt"' > 1.sh
sh 1.sh
```
