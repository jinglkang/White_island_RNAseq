#!/usr/bin/perl
use strict;
use warnings;

my (%hash1, %hash2);
my $swis="/home/kang1234/swiss-prot/unprot_name_description.txt";
open SWIS, $swis or die "can not open $swis\n";
while (<SWIS>) {
        chomp;
        my @a=split /\t/;
        $hash1{$a[0]}=$a[1];
}

my $spes="/home/kang1234/white_island/Compevo/Input_pep/OrthoFinder/Results_Mar21/Orthogroups/all_swissprot_diamond_ano.txt";
open SPES, $spes or die "can not open $spes\n";
while (<SPES>) {
        chomp;
        my @a=split /\t/;
        if (/^Acura/) {
                $hash2{$a[0]}=$a[1];
        }
}

my $orth="/home/kang1234/white_island/Compevo/Input_pep/OrthoFinder/Results_Mar21/Orthogroups/orth_id_paml.txt";
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
        chomp;
        my @a=split;
        my $id=$a[1];
        my $nm=$hash2{$a[1]};
        my $dr=$hash1{$nm};
        print "$a[0]\t$nm\t$dr\n";
}
