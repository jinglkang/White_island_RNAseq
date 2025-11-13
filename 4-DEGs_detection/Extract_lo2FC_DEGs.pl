#!/usr/bin/perl
use strict;
use warnings;

my @DEGs; my %hash;
my $num=$ARGV[0];
my $speDEG=$ARGV[1];
&Detect_DEGs($speDEG);
&Build_hash($ARGV[2]);
&Build_hash($ARGV[3]);
&Build_hash($ARGV[4]);
my @spes=qw(Blenny Blueeyed Common Yaldwyn);
print "OrthID\tSpecies\tLog2FC\n";

foreach my $gene (@DEGs) {
	# my $info=$gene."\t";
	# my ($info1, $info2);
	foreach my $spe (sort {$hash{$gene}->{$b} <=> $hash{$gene}->{$a}} @spes) {
		my $logFC;
		($hash{$gene}->{$spe})?($logFC=$hash{$gene}->{$spe}):($logFC="NA");
		#my $logFC=$hash{$gene}->{$spe};
		#$info1.=$spe."($logFC);";
		#$info2.=$spe.">";
		print "$gene\t$spe\t$logFC\n";
	}
	#$info1=~s/\;$//;
	#$info2=~s/\>$//;
	#print "$gene\t$info1\t$info2\n";
}


sub Detect_DEGs {
	my $spe=$_[0];
	my $csv=$spe."_V".$num."C.csv";
	open CSV, $csv or die "can not open $csv\n";
	while (<CSV>) {
		chomp;
		s/\"//g;
		next if /baseMean/ || /NA/;
		my @a=split /\,/;
		if ($a[1]>=10 && abs($a[2])>=0.3 && $a[-1]<=0.05) {
			$hash{$a[0]}->{$spe}=abs($a[2]);
			push @DEGs, $a[0];
		}
	}
}

sub Build_hash {
	my $spe=$_[0];
	my $csv=$spe."_V".$num."C.csv";
	open CSV, $csv or die "can not open $csv\n";
	while (<CSV>) {
		chomp;
		s/\"//g;
		my @a=split /\,/;
		if (/baseMean/ || /NA/) {
			next;
		} else {
			$hash{$a[0]}->{$spe}=abs($a[2]);			
		}
		# next if /baseMean/; # || /NA/;		
		# $hash{$a[0]}->{$spe}=abs($a[2]);
	}	
}
