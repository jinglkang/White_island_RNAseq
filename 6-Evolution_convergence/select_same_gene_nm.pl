#!/usr/bin/perl
use strict;
use warnings;

my %ano;
my $ano="all_swissprot_diamond_ano.txt";
open ANO, $ano or die "can not open $ano\n";
while (<ANO>) {
        chomp;
        my @a=split /\t/;
        $ano{$a[0]}=$a[1];
}

my %hash1;
my $ort="Orthogroups.GeneCount.tsv";
open ORT, $ort or die "can not open $ort\n";
while (<ORT>) {
        chomp;
        my @a=split /\t/;
        if (/^Orthogroup/) {
                next;
        } else {
                my $j;
                for (my $i = 1; $i < @a-1; $i++) {
                        $j++ if $a[$i] > 0;
                }
                $hash1{$a[0]}++ if $j && $j==16;
        }
}

my @spes=qw(Acura Apoly Blenny Blue_eyed Common Daru Fugu Medaka Ocomp Padel Platyfish Pmol Spottedgar Stickleback Yaldwyn Zebrafish);
print "Orthogroups\tAcura\tApoly\tBlenny\tBlue_eyed\tCommon\tDaru\tFugu\tMedaka\tOcomp\tPadel\tPlatyfish\tPmol\tSpottedgar\tStickleback\tYaldwyn\tZebrafish\tName\n";

my $ortseq="Orthogroups.tsv";
open ORTSEQ, $ortseq or die "can not open $ortseq\n";
while (<ORTSEQ>) {
        chomp;
        my @a=split /\t/;
        next if /^Orthogroup/;
        if ($hash1{$a[0]}) {
                my (%hash2, %hash3);
                for (my $i = 1; $i < @a; $i++) {
                        $a[$i]=~s/\s+//g;
                        if ($a[$i]=~/\,/) {
                                my @b=split /\,/, $a[$i];
                                for (my $j = 0; $j < @b; $j++) {
                                        my $spe;
                                        if ($b[$j]=~/ENSTRUG/) {
                                $spe="Fugu";
                            } elsif ($b[$j]=~/ENSORLG/) {
                            $spe="Medaka";
                        } elsif ($b[$j]=~/ENSXMAG/) {
                                $spe="Platyfish";
                        } elsif ($b[$j]=~/ENSLOCG/) {
                                $spe="Spottedgar";
                            } elsif ($b[$j]=~/ENSGACG/) {
                            $spe="Stickleback";
                        } elsif ($b[$j]=~/ENSDARG/) {
                        $spe="Zebrafish";
                        } else {
                                ($spe)=$b[$j]=~/(.*)\_.*/;
                        }
                if ($ano{$b[$j]}) {
#                       print "$b[$j]\n";
                        (my $name)=$ano{$b[$j]}=~/sp\|.*\|(.*)\_.*/;
                                        @{$hash2{$name}->{$spe}}=[] unless exists $hash2{$name}->{$spe};
                                        push @{$hash2{$name}->{$spe}}, $b[$j];
                                        $hash3{$name}++;
                }
                        }
                } else {
                        if ($ano{$a[$i]}) {
#               print "$b[$j]\n";
                                my $spe;
                                if ($a[$i]=~/ENSTRUG/) {
                                $spe="Fugu";
                    } elsif ($a[$i]=~/ENSORLG/) {
                    $spe="Medaka";
                        } elsif ($a[$i]=~/ENSXMAG/) {
                        $spe="Platyfish";
                } elsif ($a[$i]=~/ENSLOCG/) {
                        $spe="Spottedgar";
                    } elsif ($a[$i]=~/ENSGACG/) {
                    $spe="Stickleback";
                } elsif ($a[$i]=~/ENSDARG/) {
                        $spe="Zebrafish";
                } else {
                        ($spe)=$a[$i]=~/(.*)\_.*/;
                }
                (my $name)=$ano{$a[$i]}=~/sp\|.*\|(.*)\_.*/;
                                @{$hash2{$name}->{$spe}}=[] unless exists $hash2{$name}->{$spe};
                                push @{$hash2{$name}->{$spe}}, $a[$i];
                                $hash3{$name}++;
            }
                }
        }

        foreach my $name (sort keys %hash3) {
                my $info;
                foreach my $spe (@spes) {
                        my $nb;
                        my $info1;
                        if ($hash2{$name}->{$spe}) {
                                #$nb=@{$hash2{$name}->{$spe}};
                                foreach my $ele (@{$hash2{$name}->{$spe}}) {
                                        $info1.=$ele.";" if $ele !~ /ARRAY/;
                                }
                                $info1=~s/\;$//;
                        } else {
                                #$nb=0;
                                $info1="";
                        }
                        $info.=$info1."\t";
                        #$info.=$nb."\t";
                }
                $info=~s/\s+$//;
                print "$a[0]\t$info\t$name\n";
                }
        }
}
