#!usr/bin/perl -w
use strict;
use Getopt::Long;
use FindBin '$Bin';
use myConfig;

##################check soft/ref path 
for(keys %_tool_){
        if(-e $_tool_{$_}){next;
        }else{print"ERROR: '$_tool_{$_}' does not exists, please check you path\n" ;  exit;}
}
for(keys %_ref_){
        if(-e $_ref_{$_}){next;
        }else{print"ERROR: '$_ref_{$_}' does not exists, please check you path\n" ; exit;}
}


##################usage
my $usage=<<'USAGE';
Discription: PALM-Seq pipeline (for SE)
Usage: perl $0 -f fq.list
Author: Taifu Wang 
USAGE

my ($help,$file);
GetOptions(
        'f=s' => \$file,
        'h=s' => \$help,
);
die $usage if($help||!$file);




#=pod
open IN,"$file"or die $!;

`mkdir shell`unless(-e "shell");
`mkdir Result`unless(-e "Result");
`mkdir Result/Filter`unless(-e "Result/Filter");
`mkdir Result/rmRNA`unless(-e "Result/rmRNA");
`mkdir Result/miRNA`unless(-e "Result/miRNA");
`mkdir Result/tpiRNA`unless(-e "Result/tpiRNA");
`mkdir Result/otherRNA`unless(-e "Result/otherRNA");
`mkdir Result/mRNA`unless(-e "Result/mRNA");
`mkdir Result/Expre`unless(-e "Result/Expre");
`mkdir Result/Genome`unless(-e "Result/Genome");


while(<IN>){
	chomp;
	my ($sam,$fq)=(split/\s+/,$_,2)[0,1];
	open OUT,">shell/$sam.sh"or die $!;
	if($fq=~/\s+/){
		`mkdir Result/Raw`unless(-e "Result/Raw");	
############gzip -dc lane1 lane2 >lane
		print OUT"echo ==========merge 2lane start at : `date` ==========\n";	
		print OUT"$_tool_{'bgzip'} -dc $fq > ../Result/Raw/$sam.fq && $_tool_{'bgzip'} ../Result/Raw/$sam.fq && \\\n";	
		print OUT"echo ==========merge 2lane end at : `date` ==========\n";
		$fq="../Result/Raw/$sam.fq.gz";
	}
############filter+RmRNA
	`mkdir Result/Filter/$sam`unless(-e "Result/Filter/$sam");
	`mkdir Result/rmRNA/$sam`unless(-e "Result/rmRNA/$sam");
###filter
	print OUT"echo ==========Cutadapt start at : `date` ==========\n";
	print OUT"$_tool_{'cutadapt'} $_para_{'Cut_para1'} --too-short-output ../Result/Filter/$sam/$sam\_low17_00.fq.gz -o ../Result/Filter/$sam/$sam.clean_00.fq.gz $fq > ../Result/Filter/$sam/$sam.Cutadapt_00.stat && \\\n";
	print OUT"$_tool_{'cutadapt'} $_para_{'Cut_para2'} --too-short-output ../Result/Filter/$sam/$sam\_low17.fq.gz -o ../Result/Filter/$sam/$sam.clean.fq.gz ../Result/Filter/$sam/$sam.clean_00.fq.gz > ../Result/Filter/$sam/$sam.Cutadapt.stat && \\\n";
	print OUT"echo ==========filter end at : `date` ==========\n";

###rm_rRNA
	print OUT"echo ==========rmRNA start at : `date` ==========\n";
	print OUT"$_tool_{'bowtie'} $_para_{'bow_para'} --un ../Result/rmRNA/$sam/$sam.rmRNA.fq $_ref_{'rRNAref'} ../Result/Filter/$sam/$sam.clean.fq.gz -S ../Result/rmRNA/$sam/$sam.sam 2> ../Result/rmRNA/$sam/$sam.Map2GeneStat.xls && \\\n";
	print OUT"$_tool_{'samtools'} view -hb ../Result/rmRNA/$sam/$sam.sam -o ../Result/rmRNA/$sam/$sam.bam && \\\n";
	print OUT"$_tool_{'bgzip'} ../Result/rmRNA/$sam/$sam.rmRNA.fq && \\\n";
	print OUT"rm ../Result/rmRNA/$sam/$sam.sam && \\\n";

############
	`mkdir Result/Expre/$sam`unless(-e "Result/Expre/$sam");
############bowtie miRNA
	`mkdir Result/miRNA/$sam`unless(-e "Result/miRNA/$sam");
	print OUT"echo ==========miRNA bowtie start at : `date` ==========\n";
	print OUT"$_tool_{'bowtie'} $_para_{'bow_para'} --un ../Result/miRNA/$sam/$sam.miRNA.fq  $_ref_{'miRNAref'} ../Result/rmRNA/$sam/$sam.rmRNA.fq.gz -S ../Result/miRNA/$sam/$sam.sam  2> ../Result/miRNA/$sam/$sam.Map2GeneStat.xls && \\\n";
	print OUT"perl $Bin/Remove_har_miRNA.pl ../Result/miRNA/$sam/$sam.sam $_ref_{'mi_des'}  2> ../Result/miRNA/$sam/$sam.total |$_tool_{'samtools'} view -hb -o ../Result/miRNA/$sam/$sam.bam && \\\n";
	print OUT"perl $Bin/miRNA_Count_RPM.pl ../Result/miRNA/$sam/$sam.bam $sam ../Result/Expre/$sam $_ref_{'sym2tran'} && \\\n";
	print OUT"$_tool_{'bgzip'} ../Result/miRNA/$sam/$sam.miRNA.fq && \\\n";
        print OUT"rm ../Result/miRNA/$sam/$sam.sam && \\\n";
	print OUT"echo ==========miRNA bowtie end at : `date` ==========\n";

############bowtie t-piRNA
	`mkdir Result/tpiRNA/$sam`unless(-e "Result/tpiRNA/$sam");
        print OUT"echo ==========t-piRNA bowtie start at : `date` ==========\n";
        print OUT"$_tool_{'bowtie'} $_para_{'bow_para'} --un ../Result/tpiRNA/$sam/$sam.tpiRNA.fq  $_ref_{'tpiRNAref'} ../Result/miRNA/$sam/$sam.miRNA.fq.gz -S ../Result/tpiRNA/$sam/$sam.sam  2> ../Result/tpiRNA/$sam/$sam.Map2GeneStat.xls && $_tool_{'samtools'} view -hb ../Result/tpiRNA/$sam/$sam.sam -o ../Result/tpiRNA/$sam/$sam.bam && \\\n";
	print OUT"perl $Bin/tpiRNA_Count_RPM.pl ../Result/tpiRNA/$sam/$sam.bam $sam ../Result/Expre/$sam $_ref_{'sym2tran'} && \\\n";
        print OUT"$_tool_{'bgzip'} ../Result/tpiRNA/$sam/$sam.tpiRNA.fq && \\\n";
        print OUT"rm ../Result/tpiRNA/$sam/$sam.sam && \\\n";
        print OUT"echo ==========t-piRNA bowtie end at : `date` ==========\n";

###########bowtie mRNA
	`mkdir Result/mRNA/$sam`unless(-e "Result/mRNA/$sam");	
	print OUT"echo ==========mRNA bowtie start at : `date` ==========\n";
        print OUT"$_tool_{'bowtie'} $_para_{'bow_para'} --un ../Result/mRNA/$sam/$sam.un_mRNA.fq $_ref_{'RNAref'} ../Result/tpiRNA/$sam/$sam.tpiRNA.fq.gz -S ../Result/mRNA/$sam/$sam.sam  2> ../Result/mRNA/$sam/$sam.Map2GeneStat.xls && $_tool_{'samtools'} view -hb ../Result/mRNA/$sam/$sam.sam -o ../Result/mRNA/$sam/$sam.bam && \\\n";
	print OUT"$_tool_{'bgzip'} ../Result/mRNA/$sam/$sam.un_mRNA.fq && \\\n";
	print OUT"rm ../Result/mRNA/$sam/$sam.sam && \\\n";

        print OUT"echo ==========mRNA bowtie end  at : `date` ==========\n";

	#`mkdir Result/RPKM/$sam`unless(-e "Result/RPKM/$sam");
	print OUT"$_tool_{'rsem'}/rsem-calculate-expression -p 8 --seed-length 17 --no-bam-output --bam  ../Result/mRNA/$sam/$sam.bam $_ref_{'RSEMref'} ../Result/Expre/$sam/$sam && \\\n";
        print OUT"echo ==========RSEM end at : `date` ==========\n";

###########bowtie otherRNA
	`mkdir Result/otherRNA/$sam`unless(-e "Result/otherRNA/$sam");
	print OUT"echo ==========otherRNA bowtie start at : `date` ==========\n";
	print OUT"$_tool_{'bowtie'} $_para_{'bow_para'} --un ../Result/otherRNA/$sam/$sam.un_otherRNA.fq  $_ref_{'otherref'} ../Result/mRNA/$sam/$sam.un_mRNA.fq.gz -S ../Result/otherRNA/$sam/$sam.sam  2> ../Result/otherRNA/$sam/$sam.Map2GeneStat.xls && $_tool_{'samtools'} view -hb ../Result/otherRNA/$sam/$sam.sam -o ../Result/otherRNA/$sam/$sam.bam && \\\n";
        print OUT"$_tool_{'bgzip'} ../Result/otherRNA/$sam/$sam.un_otherRNA.fq && \\\n";
        print OUT"rm ../Result/otherRNA/$sam/$sam.sam && \\\n";
        print OUT"echo ==========otherRNA bowtie end at : `date` ==========\n";	

###########STAR Genome
	`mkdir Result/Genome/$sam`unless(-e "Result/Genome/$sam");
	print OUT"echo ==========STAR Genome start at : `date` ==========\n";
	print OUT"$_tool_{'STAR'} $_para_{'Star_para'} --genomeDir $_ref_{'Starref'} --readFilesIn ../Result/otherRNA/$sam/$sam.un_otherRNA.fq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../Result/Genome/$sam/$sam --outReadsUnmapped Fastx --outSAMtype BAM SortedByCoordinate && \\\n";	
	print OUT"echo ==========STAR Genome end at : `date` ==========\n";

}

print "All scripts have been generated, go to the shell/ and running ....\n";
