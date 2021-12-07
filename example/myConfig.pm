package myConfig;
use base qw(Exporter);
our @ISA = qw(Exporter);
our @EXPORT = qw(%_tool_ %_ref_ %_para_);

##software
our %_tool_ = (
	gzip => "/bin/gzip",
	bgzip => "/example_path/RNA/RNAseq/software/bgzip",
	samtools => "/example_path/RNA/RNAseq/software/samtools",
	bowtie => "/example_path/RNA/RNAseq/software/bowtie",
	cutadapt => "/example_path/RNA/RNAseq/software/cutadapt",
	rsem  => "/example_path/RNA/RNAseq/software/rsem",
	STAR => "/example_path/RNA/RNAseq/software/STAR"
);

##refrence
our %_ref_ = (	
	rRNAref => "/example_path/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19_rRNA_Y_RNA.fa", #bowtie index for rRNA and YRNA refrence
	miRNAref => "/example_path/RNA/database/RNA_ref/cfRNA_ref/index/bowtie1/hg19.miRNA.fa", #bowtie index for miRNA refrence
	tpiRNAref => "/example_path/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19.t_piRNA.fa", #bowtie index for tRNA and piRNA refrence
	RNAref => "/example_path/RNA/database/RNA_ref/cfRNA_ref/index/bowtie1/hg19.lnc_mRNA.fa", #bowtie index for lncRNA and mRNA refrence
	RSEMref => "/example_path/RNA/database/RNA_ref/cfRNA_ref/index/rsem/hg19.lnc_mRNA.fa", #RSEM index for lncRNA and mRNA refrence
	otherref => "/example_path/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19_Genocode.fa", #RSEM index for otherRNA refrence
	Starref => "/example_path/align_stat/index/hg19", #Star index for hg19 genome refrence	
	sym2tran => "/example_path/RNA/database/RNA_ref/cfRNA_ref/ref/Sym2Tran/Sym2Tran.type.txt", #geneID transID Type
	mi_des => "/example_path/BowtieIndex/miRNA.des" #  the position of  mature miRNAs in harpin miRNAs
);

##parameters
our %_para_ = (
	bow_para => "-v 1 -p 8 -a --best --strata --norc", #parameters for bowtie
	Cut_para1 => "-q 15,15 -u 4 -m 0 --max-n 0.1 -O 1 -a file:/example_path/Cutadapt/Bgi500_SE100_1.fa -e 0.1", #parameters for Cutadapt
	Cut_para2 => "-q 15,15 -m 17 --max-n 0.1 -O 1 -a file:/example_path/Cutadapt/Bgi500_SE100_2.fa -e 0.1", #parameters for Cutadapt
	Star_para => "--runThreadN 10"
);

=pod
for(keys %_tool_){
	if(-e $_tool_{$_}){next;
	}else{print"$_tool_{$_} does not exists, please check you path" &&  exit;}
}
=cut
