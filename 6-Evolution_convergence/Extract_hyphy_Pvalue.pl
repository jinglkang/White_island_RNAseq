#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use Parallel::ForkManager;

my @txts=<*.txt>;
foreach my $txt (@txts) {
        my ($orth, $p);
        ($orth)=$txt=~/(.*)_Blenny_Common\.txt/;
        open TXT, $txt or die "can not open $txt\n";
        while (<TXT>) {
                chomp;
                if (/Likelihood/) {
                        my @a=split;
                        ($p)=$a[-1]=~/(\d+\.\d+)/;
                        print "$orth\t$p\n";
                }
        }
}
