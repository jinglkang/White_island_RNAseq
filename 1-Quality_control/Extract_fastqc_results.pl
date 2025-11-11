open fil, "all.samples.fastqc.txt";
while (<fil>) {
        chomp;
        @a = split /\t/;
        $name = $a[0]."\t".$a[1];
        $hash{$name} ++;
}
foreach $key(keys %hash) {
        print "$key\t$hash{$key}\n";
}
