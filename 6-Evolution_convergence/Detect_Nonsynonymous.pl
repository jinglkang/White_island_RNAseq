#!/usr/bin/perl
# HPC: Detect_Nons.pl
use strict;
use warnings;
#use Array::Utils qw(:all);

my %seq; my $name;
my $orth=$ARGV[0];
my $fas="paml_files/$orth/final_alignment_pep.fa";
open FAS, $fas or die "can not open $fas\n";
while (<FAS>) {
        chomp;
        if (/^>/) {
                s/\>//;
                $name=$_;
        } else {
                $seq{$name}.=$_;
        }
}

my %cleaner=(
        'Blenny'=> 1,
        'Common'=> 1,
        );

# compare the nonsynonymous position pep sequences one by one
my %hash1;
my @poss;
my @nocls=qw(Acura Apoly Blueeyed Daru Fugu Medaka Ocomp Padel Platyfish Pmol Spottedgar Stickleback Yaldwyn Zebrafish);
my @cleas=qw(Blenny Common);
my @aspes=qw(Acura Apoly Blenny Blueeyed Common Daru Fugu Medaka Ocomp Padel Platyfish Pmol Spottedgar Stickleback Yaldwyn Zebrafish);

&Build_pos_hash(\@aspes);

sub Build_pos_hash {
        my ($grp)=@_;
        my @grp=@{$grp};
        my $len;
        foreach my $spe (@grp) {
                my $seq=$seq{$spe};
                $len=length($seq);
                for (my $i = 0; $i < $len; $i++) {
                        my $spepos=substr($seq,$i,1);
                        $hash1{$spe}->{$i}=$spepos;
                }
        }

        for (my $i = 0; $i < $len; $i++) {
                my (%hash2,%hash3);
                my $pos=$i;
                my $newp=$pos+1;
                my $info=$newp.":";
                foreach my $spe (@aspes) {
                        my $spepos=$hash1{$spe}->{$pos};
                        $info.=$spe."($spepos);";
                }

                my (@cleas_pos, @nocls_pos);
                foreach my $spe (@cleas) {
                        my $spepos=$hash1{$spe}->{$pos};
                        $hash2{$spepos}++;
                        push @cleas_pos, $spepos;
                }
                foreach my $spe (@nocls) {
                        my $spepos=$hash1{$spe}->{$pos};
                        $hash3{$spepos}++;
                        push @nocls_pos, $spepos;
                }
                my %array1 = map { $_ => 1 } @cleas_pos;
				my @isect = grep { $array1{$_} } @nocls_pos;
                #my @isect = intersect(@cleas_pos, @nocls_pos);
                my $numb2=keys %hash2;
                my $numb3=keys %hash3;
                unless (@isect) {
                        print "$orth\t$numb2\t$numb3\t$info\n" if $numb2==1 && $numb3==1;
                }
        }
}
