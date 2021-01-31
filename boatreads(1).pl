###############boatreads.pl###############
#In this script, you should input the ".sam" file. For example, if the input file is "test.sam", you can try this command:
#perl boatreads.pl test.sam
#And the output file is named with "reads_test.sam"
#
#The second colomn of ".sam" file is "FLAG". FLAG=4 means the sequence cannot map to the miRNA index and these sequences are removed from the ".sam" file.
#In the same time, the "_" in the first colomn, which contains the information of counts, is replaced with "\t".
#
#Finally, we get a table which can tell us the sequence(Colomn 1), counts(Colomn 2), miRNA(Colomn 4).
#


$infile=$ARGV[0];

open(in, "$infile") or die "can not open $infile\n";
open(out, ">reads_$infile") or die " can  not open out!\n";

while (<in>){
	@temp=split;
	if($temp[1] == 4){
		$K=$K+1;
	}
	else{
		print out if s/_/\t/;
	}
}
print "unmapped reads is $K\n";
