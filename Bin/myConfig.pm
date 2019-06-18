package myConfig;
use base qw(Exporter);
our @ISA = qw(Exporter);
our @EXPORT = qw(%_tool_ %_ref_ %_para_);

##software
our %_tool_ = (
	gzip => "/bin/gzip",
	bgzip => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/RNAseq/software/bgzip",
	samtools => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/RNAseq/software/samtools",
	bowtie => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/RNAseq/software/bowtie",
	cutadapt => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/RNAseq/software/cutadapt",
	rsem  => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/RNAseq/software/rsem",
	STAR => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/RNAseq/software/STAR"
);

##refrence
our %_ref_ = (	
	rRNAref => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19_rRNA_Y_RNA.fa", #bowtie index for rRNA and YRNA refrence
	miRNAref => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/index/bowtie1/hg19.miRNA.fa", #bowtie index for miRNA refrence
	tpiRNAref => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19.t_piRNA.fa", #bowtie index for tRNA and piRNA refrence
	RNAref => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/index/bowtie1/hg19.lnc_mRNA.fa", #bowtie index for lncRNA and mRNA refrence
	RSEMref => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/index/rsem/hg19.lnc_mRNA.fa", #RSEM index for lncRNA and mRNA refrence
	otherref => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19_Genocode.fa", #RSEM index for otherRNA refrence
	Starref => "/zfssz2/ST_MCHRI/REPRO/Project/P17Z10200N0384/wangtaifu/cfRNA_science_2018/sci_pipe-2019-4-22/align_stat/index/hg19", #Star index for hg19 genome refrence	
	sym2tran => "/zfssz2/ST_MCHRI/REPRO/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/ref/Sym2Tran/Sym2Tran.type.txt", #geneID transID Type
	mi_des => "/zfssz2/ST_MCHRI/REPRO/Project/P17Z10200N0384/wangtaifu/cfRNA_pipe/cfRNA_data_2019-3/miRNA_Test/ref/BowtieIndex/miRNA.des" #  the position of  mature miRNAs in harpin miRNAs
);

##parameters
our %_para_ = (
	bow_para => "-v 1 -p 8 -a --best --strata --norc", #parameters for bowtie
	Cut_para1 => "-q 15,15 -u 4 -m 0 --max-n 0.1 -O 1 -a file:/zfssz2/ST_MCHRI/REPRO/Pipeline/Software/Cutadapt/Bgi500_SE100_1.fa -e 0.1", #parameters for Cutadapt
	Cut_para2 => "-q 15,15 -m 17 --max-n 0.1 -O 1 -a file:/zfssz2/ST_MCHRI/REPRO/Pipeline/Software/Cutadapt/Bgi500_SE100_2.fa -e 0.1", #parameters for Cutadapt
	Star_para => "--runThreadN 10"
);

=pod
for(keys %_tool_){
	if(-e $_tool_{$_}){next;
	}else{print"$_tool_{$_} does not exists, please check you path" &&  exit;}
}
=cut
