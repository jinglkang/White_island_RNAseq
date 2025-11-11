open fil, "sample.name";
while (<fil>) {
        chomp;
        ($num)=$_=~/(\d+)/;
        $num1="_S"."$num";
        $forward="$num1"."_R1_001.fastq.gz";
        $reverse="$num1"."_R2_001.fastq.gz";
        $seq1=$_.$forward;
        $seq2=$_.$reverse;
        $seq1_paired="$_"."_R1.fastq.gz";
        $seq2_paired="$_"."_R2.fastq.gz";
        $seq1_unpaired=$_.".unpaired.R1.fastq.gz";
        $seq2_unpaired=$_.".unpaired.R2.fastq.gz";
        system("java -jar trimmomatic-0.39.jar PE $seq1 $seq2 ./paired/$seq1_paired ./unpaired/$seq1_unpaired ./paired/$seq2_paired ./unpaired/$seq2_unpaired ILLUMINACLIP:TruSeq2-PE-final.fa:2:30:10 LEADING:4 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:40 -threads 32);
}
