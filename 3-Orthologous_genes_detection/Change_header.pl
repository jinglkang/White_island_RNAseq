@fa=<*.fa>;
foreach $fa (@fa) {
	open fil1, "$fa";
	($name)=$fa=~/(.*)\.fa/;
	$new=$name."-1.fa";
	open fil2, ">$new";
	while (<fil1>) {
		chomp;
		if (/>/) {
			$i++;
			$gene_id=$name."_".$i;
			print fil2 ">$gene_id\n";
		} else {
			print fil2 "$_\n";
		}
	}
	$i=0;
}
