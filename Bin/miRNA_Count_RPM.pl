#!/usr/bin/perl -w


use strict;
my @case;

open IN,"/zfssz5/BC_PUB/Software/03.Soft_ALL/samtools-1.7/samtools view -F 4 $ARGV[0]|"or die $!;
my $sam=$ARGV[1];
my $out=$ARGV[2];

##***********
my %ref; #
open REF,"$ARGV[3]"or die $!;

while(<REF>){
        chomp;
	my($trans,$sym)=(split/\t/,$_)[1,0];
	$ref{$trans}="$sym";
}

my $total=0; #total read number
my(%hash,%hash1);
my (%ge,%tr,%ge_tr); #ge for sym /tr for trans / ge_tr for sym_trans
my %mul_tr;

while(<IN>){
	chomp;

        my($read,$trans,$seq)=(split/\t/,$_)[0,2,9];

	if(!exists $hash{$read}){
		$total++;
		$hash{$read}=$trans;
		$tr{$trans}++;
		$mul_tr{$trans}++;
	}else{
		if(!exists $hash1{$read}){
			$hash1{$read}=1;$tr{$hash{$read}}--;next;
		}else{
			next;}
	}
}

open OUT,"> $out/$sam.miRNA.Count_RPM.xls"or die $!;
print OUT"GeneID\ttype\tuniqCount\tuniqRPM\tmuiCount\tmuiRPM\ttotalCount\n";
foreach my $i(keys %tr){
#	$ge{$ref{$i}}+=	$tr{$i};
#	if(!exists $ge_tr{$ref{$i}}){$ge_tr{$ref{$i}}=$i;}else{$ge_tr{$ref{$i}}.=":$i";}
	#muit reads
	my $num_mul=$mul_tr{$i};
	my $mul_CPM=($num_mul*1000000)/$total;
	#uniq reads
	my $CPM=($tr{$i}*1000000)/$total;
	print OUT"$i\t$ref{$i}\t$tr{$i}\t$CPM\t$num_mul\t$mul_CPM\t$total\n";		
}

