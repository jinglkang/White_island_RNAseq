#!/usr/bin/perl
use strict;
use warnings;

my $head="Tags\tGO_ID\tGO_Name\tGO_Category\tFDR\tP-Value\tNr_Test\tNr_Reference\tNon_Annot_Test\tNon_Annot_Reference\tType\tSpecies";
print "$head\n";
my (%yal, %blu, %ble, %com);

my $Yaldwyn="YaldwynNofilter_enrichment.txt";
my $Blueyed="BlueeyedNofilter_enrichment.txt";
my $blenny="BlennyNofilter_enrichment.txt";
my $common="CommonNofilter_enrichment.txt";

%yal=&Build_hash($Yaldwyn);
%blu=&Build_hash($Blueyed);
%ble=&Build_hash($blenny);
%com=&Build_hash($common);

my $funcs=$ARGV[0];
open FUNCS, $funcs or die "can not open $funcs\n";
while (<FUNCS>) {
	chomp;
	s/\r//g;
	next if /^Function/;
	my @a=split /\t/;
	my $yalInfo=$yal{$a[0]};
	my $bluInfo=$blu{$a[0]};
	my $bleInfo=$ble{$a[0]};
	my $comInfo=$com{$a[0]};
	print "$yalInfo\t$a[1]\tYaldwin\n";
	print "$bluInfo\t$a[1]\tblue-eyed\n";
	print "$bleInfo\t$a[1]\tblenny\n";
	print "$comInfo\t$a[1]\tcommon\n";
}


sub Build_hash {
	my ($file)=@_; my %hash;
	open FILE, $file or die "can not open $file\n";
	while (<FILE>) {
		chomp;
		my @a=split /\t/;
		if (/^Tags/) {
			next;			
		} else {
			my $line;
			for (my $i = 0; $i < 10; $i++) {
				unless ($a[6]) {
					$a[6]="NA";
				}
				$line.=$a[$i]."\t";
			}
			$line=~s/\s+$//;
			$hash{$a[2]}=$line;
		}
	}
	return %hash;
}
