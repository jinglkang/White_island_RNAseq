#!/usr/bin/perl
use strict;
use warnings;

my @heads;
my $orth="Orth_same_gene_nm_16spe_longest_newOrthID.txt";
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
        chomp;
        my @a=split /\t/;
        if (/^Acura/) {
                @heads=@a;
        } else {
                my $info;
                for (my $i = 1; $i < @a; $i++) {
                        my $gene;
                        ($a[$i]=~/\_/)?($gene=$a[$i]):($gene=$heads[$i-1]."_".$a[$i]);
                        ($gene=~/Blue_eyed/)?($gene=~s/Blue_eyed/Blueeyed/):($gene=$gene);
                        $info.=$gene."\t";
                }
                print "$a[0]\t$info\n";
        }
}
