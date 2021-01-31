###############remove.adaptor.pl###############
#To run this perl script to remove the adpators of the sequences of the file named with "test.fastq", you can try this command:
#perl remove.adaptor.pl test.fastq
#And the output file is named with "test.fastq.qf.fasta"
#
#We only use the "R1" file of the "paired-end sequencing" to analyse. For "R2" provides the same information as "R1" does.
#
#The outputfile is like this:
#>TAGCTTATCAGACTGATGTTGA_1000
#TAGCTTATCAGACTGATGTTGA
#
#The first line contains the sequence information and the counts of this sequence in this sample.
#In the example, the "TAGCTTATCAGACTGATGTTGA" sequence appears 1000 times in the input file.
#And information of the counts is reverved in the first column of ".sam" file. 
#



open(in, "$ARGV[0]") or die "cannnot open the $ARGV[0]!\n";
open(out, ">$ARGV[0].qf.fasta") or die "cannot open the outfiles!\n";

$adaptor="AGATCGG";

$K=3;
$N=1;

while(<in>){
	chomp;
	if($K==$N*4){
		if(/$adaptor/){
			$end_posi=index($_, $adaptor);
			$seq=substr($_, 0, $end_posi);
			$len=length($seq);
			if($len >= 20 and $len <= 25){
				if($f_seq{$seq} eq $seq){
					$reads{$seq}=$reads{$seq}+1;
				}
				else{
					$f_seq{$seq}=$seq;
					$reads{$seq}=1;
				}
			}
		}
	$N=$N+1;
	}
	$K=$K+1;
}
$N=$N-1;
print "total reads : $N!\n";

while(($key, $value)=each(%reads)){
	$name="$key"."_"."$value";
	print out ">$name\n$key\n";
}
