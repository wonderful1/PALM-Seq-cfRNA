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
	my($trans,$type)=(split/\t/,$_)[1,2];
	$ref{$trans}="$type";
}

my $total_tRNA=0; #total read number
my $total_piRNA=0;
my(%hash_t,%hash_pi,%hash1);
my (%ge,%tr,%ge_tr); #ge for sym /tr for trans / ge_tr for sym_trans
my %mul_tr;

####for tRNA
while(<IN>){
	chomp;
        my($read,$trans,$seq)=(split/\t/,$_)[0,2,9];
	if($ref{$trans} eq "tRNA"){
		if(!exists $hash_t{$read}){
			$total_tRNA++;
			$hash_t{$read}=$trans;
			$tr{$trans}++;
			$mul_tr{$trans}++;
		}else{	
			if(!exists $hash1{$read}){
				$hash1{$read}=1;$tr{$hash_t{$read}}--;next;
			}else{
				next;}
		}
	}else{next;}
}close IN;
######for piRNA
open IN,"/zfssz5/BC_PUB/Software/03.Soft_ALL/samtools-1.7/samtools view -F 4 $ARGV[0]|"or die $!;
while(<IN>){
        chomp;
        my($read,$trans,$seq)=(split/\t/,$_)[0,2,9];
	#print "$ref{$trans}\n";
	if($ref{$trans} eq "piRNA"){
		#print "$read\t$trans\t$seq\n";
                if(!exists $hash_pi{$read} && !exists $hash_t{$read}){
                        $total_piRNA++;
                        $hash_pi{$read}=$trans;
                        $tr{$trans}++;
                        $mul_tr{$trans}++;
                }else{
			next if(exists $hash_t{$read});
                        if(!exists $hash1{$read}){
                                $hash1{$read}=1;$tr{$hash_pi{$read}}--;next;
                        }else{
                                next;}
                }
        }else{next;}
}


open OUT,"> $out/$sam.tRNA.Count_RPM.xls"or die $!;
open OU,"> $out/$sam.piRNA.Count_RPM.xls"or die $!;
print OUT"GeneID\ttype\tuniqCount\tuniqRPM\tmuiCount\tmuiRPM\ttotalCount\n";
print OU"GeneID\ttype\tuniqCount\tuniqRPM\tmuiCount\tmuiRPM\ttotalCount\n";
foreach my $i(keys %tr){
	if($ref{$i} eq "tRNA"){
		#muit reads
		my $num_mul=$mul_tr{$i};
		my $mul_CPM=($num_mul*1000000)/$total_tRNA;			
		#uniq reads
		my $CPM=($tr{$i}*1000000)/$total_tRNA;
		print OUT"$i\t$ref{$i}\t$tr{$i}\t$CPM\t$num_mul\t$mul_CPM\t$total_tRNA\n";
	}else{
		#muit reads
		my $num_mul=$mul_tr{$i};
		my $mul_CPM=($num_mul*1000000)/$total_piRNA;
		#uniq reads
		my $CPM=($tr{$i}*1000000)/$total_piRNA;
                print OU"$i\t$ref{$i}\t$tr{$i}\t$CPM\t$num_mul\t$mul_CPM\t$total_piRNA\n";
		}
}

