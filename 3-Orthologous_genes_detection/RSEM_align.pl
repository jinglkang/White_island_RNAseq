use strict;
use warnings;
open "fil", "sample_info.txt" or die "can not open sample_info.txt";
while (<fil>) {
        chomp;
        my @a=split;
        my $spe=$a[0];
        my $result_dir=$spe."_RSEM_output";
        mkdir $result_dir unless (-d $result_dir);
        chdir "./$result_dir";
#       system 'pwd';
        my @R1=split /\,/, $a[1];
        foreach my $R1 (@R1) {
                my ($sample)=$R1=~/(.*)\_1\.fastq\.gz/;
                my $R2=$sample."_2.fastq.gz";
                my $cmd="rsem-calculate-expression -p 24 --bowtie2 --paired-end ../../$R1 ../../$R2 ../$spe $sample --no-bam-output";
                system "$cmd";
        }
        chdir "../";
#       system 'pwd';
}
