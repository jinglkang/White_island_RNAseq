#!/usr/bin/perl
use strict;
use warnings;
#use Array::Utils qw(:all);

my %anno;
my $anog="orth_id_paml_ano.txt";
open ANOG, $anog or die "can not open $anog\n";
while (<ANOG>) {
        chomp;
        my @a=split /\t/;
        $anno{$a[0]}=$a[1]."\t".$a[2];
}

my $conv="convergent_evo_genes.txt";
open CONV, $conv or die "can not open $conv\n";
while (<CONV>) {
        chomp;
        my @a=split /\t/;
        print "$_\t$anno{$a[0]}\n";
}
