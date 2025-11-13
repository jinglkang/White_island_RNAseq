#!/usr/bin/perl
use strict;
use warnings;

my (%yal, %blu, %ble);
my $Yaldwyn="YaldwynNofilter_enrichment.txt";
open YAL, $Yaldwyn or die "can not open $Yaldwyn\n";
while (<YAL>) {
	chomp;
	next if /^Tags/;
	my @a=split /\t/;
	$yal{$a[2]}++ if $a[6]==0;
}
my $Blueyed="BlueeyedNofilter_enrichment.txt";
open BLU, $Blueyed or die "can not open $Blueyed\n";
while (<BLU>) {
	chomp;
	next if /^Tags/;
	my @a=split /\t/;
	$blu{$a[2]}++ if $a[6]==0;
}

my $blenny="BlennyNofilter_enrichment.txt";
open BLE, $blenny or die "can not open $blenny\n";
while (<BLE>) {
	chomp;
	next if /^Tags/;
	my @a=split /\t/;
	$ble{$a[2]}++ if $a[6]==0;
}

my $common="CommonNofilter_enrichment.txt";
open COM, $common or die "can not open $common\n";
while (<COM>) {
	chomp;
	next if /^Tags/;
	my @a=split /\t/;
	print "$a[2]\n" if $yal{$a[2]} && $blu{$a[2]} && $ble{$a[2]} && $a[4]<=0.05;
}
