#!/usr/bin/perl -w


use strict;

#my $out="../Result";
open IN,"/zfssz5/BC_PUB/Software/03.Soft_ALL/samtools-1.7/samtools view -hF 4 $ARGV[0]|"or die $!;
#my $sam=$ARGV[1];

##***********
my %ref; #
open REF,"$ARGV[1]"or die $!;

while(<REF>){
        chomp;
	next if(/^#/);
	my($na,$seq,$end)=(split/\t/,$_)[0,2,4];
	my $star=$end-length($seq)+1;
	$ref{$na}=[$star,$end];
}

my(%hash,%hash1);
my %ge;

my $total=0;my %h;
#open OU,">aaaa";
while(<IN>){
	if(/^@/){print;next;
	}else{
		my($read,$trans,$star,$seq)=(split/\t/,$_)[0,2,3,9];
#		if(!exists $h{$read}){$h{$read}=1;$total++;}
		my $end=$star+length($seq)-1;
		if($trans=~/^hsa-miR/ || $trans=~/^hsa-let/){
			if(abs($star-$ref{$trans}->[0])> 2 || abs($end-$ref{$trans}->[1])> 5){if(!exists $hash{$read}){$hash{$read}=1;next;}
			}else{
				if(!exists $h{$read}){$h{$read}=1;$total++;}
				print;next;}
		}else{print;next;}
	}
}

print STDERR "$total\n"; 
