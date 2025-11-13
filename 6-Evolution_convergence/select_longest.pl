#!/usr/bin/perl
use strict;
use warnings;

my $all ="all.fas";
my $cmd1="cat ~/white_island/Compevo/Input_pep/*.fasta > $all";
system($cmd1);

my %hash;
my $gene;
open ALL, $all or die "can not open $cmd1\n";
while (<ALL>) {
        chomp;
        if (/\>/) {
                s/\>//;
                $gene=$_;
        } else {
                $hash{$gene}.=$_;
        }
}
system("rm $all");

my @heads;
my $orth="Orth_same_gene_nm_16spe.txt";
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
        chomp;
        my @a=split /\t/;
        if (/^Orthogroups/) {
                print "$_\n";
                @heads=@a;
        } else {
                my $info;
                for (my $i = 1; $i < @a-1; $i++) {
                        my $sel;
                        my @b=split /\;/, $a[$i];
                        my $nb=@b;
                        if ($nb == 1) {
                                $hash{$a[$i]}?($a[$i]=$a[$i]):($a[$i]=$heads[$i]."_".$a[$i]);
                                $sel=$a[$i];
                        } else {
                                my %hash1;
                                foreach my $b (@b) {
                                        $hash{$b}?($b=$b):($b=$heads[$i]."_".$b);
                                        if ($hash1{$i}) {
                                                my $old_len=$hash1{$i}->{'LEN'};
                                                my $new_len=length($hash{$b});
                                                if ($new_len > $old_len) {
                                                        $hash1{$i}={
                                                                'GENE' => $b,
                                                                'LEN'  => $new_len
                                                        };
                                                }
                                        } else {
                                                die "what's happen\t$b\t$i\t$a[$i]\n" if ! $hash{$b};
                                                my $len=length($hash{$b});
                                                $hash1{$i}={
                                                        'GENE' => $b,
                                                        'LEN'  => $len
                                                };
                                        }
                                }
                                $sel=$hash1{$i}->{'GENE'};
                        }
                        $info.=$sel."\t";
                }
                print "$a[0]\t$info$a[-1]\n";
        }
}
