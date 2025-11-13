# translate_OG_pep.pl
#!/usr/bin/perl
use strict;
use warnings;

my $orth="final_orth_input_paml.txt";
open ORTH, $orth or die "can not open $orth\n";
while (<ORTH>) {
	chomp;
	my $orthdir="paml_files/".$_;
	chdir "$orthdir";
	my $cmd1="translateDna.pl -i final_alignment.fa > final_alignment_pep.fa";
	system($cmd1);
	chdir "/data2/jlkang/White_island/paml_input";
}
