#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use Parallel::ForkManager;

# hyphy /lustre1/g/sbs_schunter/Kang/Ldim_revision/BUSTED-MH.bf --alignment final_alignment.fa --tree /lustre1/g/sbs_schunter/Kang/Ldim_revision/spe_hyphy.tre --branches Foreground
my $list=$ARGV[0]; # The list
my $tree=$ARGV[1]; # The tree
my $spe =$ARGV[2]; # The species for positive selection analysis
my $outd="Hyphy";
unless (-d $outd) {
        mkdir $outd;
}

my @cmds;
open LIST, $list or die "can not open $list\n";
while (<LIST>) {
        chomp;
        my @a=split;
        my $orth=$a[0];
        my $alig="$orth/final_alignment.fa"; # the alignment
        my $outl="$outd/$orth"."_".$spe.".txt";
        my $cmd ="hyphy busted --alignment $alig --tree $tree --multiple-hits Double+Triple --starting-points 5 --branches Foreground > $outl";
#       print "$cmd\n";
        push @cmds, $cmd;
}

my $manager = new Parallel::ForkManager(110);
foreach my $cmd (@cmds) {
        $manager->start and next;
    system($cmd);
    $manager->finish;
}
$manager -> wait_all_children;
