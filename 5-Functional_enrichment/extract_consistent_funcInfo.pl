#!/usr/bin/perl
use strict;
use warnings;

my $header;
my %info;
my $dir=$ARGV[0];
&extract_func("$dir/BlennyNofilter_enrichment.txt","blenny");
&extract_func("$dir/CommonNofilter_enrichment.txt","common");
&extract_func("$dir/BlueeyedNofilter_enrichment.txt","blue-eyed");
&extract_func("$dir/YaldwinNofilter_enrichment.txt","Yaldwin");

my @spes=qw(blenny common blue-eyed, Yaldwin);
my $funcs="Consistent_sigFunc.txt";
print "$header\tSpecies\tType\n";
open FUNCS, $funcs or die "can not open $funcs\n";
while (<FUNCS>) {
	chomp;
	foreach my $spe (@spes) {
		my $info2=$info{$spe}->{$_};
		print "$info2\t$spe\t$dir\n";
	}
}

sub extract_func {
	my ($file, $spe)=@_;
	open FILE, $file or die "can not open $file\n";
	while (<FILE>) {
		chomp;
		my @a=split /\t/;
		if (/^Tags/) {
			$header=$_;
		} else {
			my $info1;
			for (my $i = 0; $i < @a-1; $i++) {
				$info1.=$a[$i]."\t";
			}
			$info1=~s/\s+$//;
			$info{$spe}->{$a[2]}=$info1;
		}
	}
}
