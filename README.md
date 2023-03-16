## Introduction:
FullCfRNAtools v1.0  

This pipeline is designed for PALM-seq which is a new method to get all sorts of RNA in one library  

## Requirements:
	1. Bgzip/gzip  
	2. cutadapt  
	3. bowtie  
	4. samtools  
	5. rsem  
	6. STAR  

## Description
### workflow  
![62U%RAA(~CY1FAB}JU%TEHB](https://user-images.githubusercontent.com/19549825/138585110-124e2ddd-d837-40df-9e5d-77e609b935c9.png)  

### Perl script 
1. Final_cfRNAPipe.pl :Generate all shell scripts for all given samples  
2. Remove_har_miRNA.pl :Remove harpin miRNA from miRNA mapping result  
2. miRNA_Count_RPM.pl :Count the miRNA reads and scale to RPM  
4. tpiRNA_Count_RPM.pl :Count the tRNA and piRNA reads and scale to RPM  

## Citation:  
[Liu Z, Wang T, Yang X, Zhou Q, Zhu S, Zeng J, Chen H, Sun J, Li L, Xu J, Geng C, Xu X, Wang J, Yang H, Zhu S, Chen F, Wang WJ. Polyadenylation ligation-mediated sequencing (PALM-Seq) characterizes cell-free coding and non-coding RNAs in human biofluids. Clin Transl Med. 2022 Jul;12(7):e987. doi: 10.1002/ctm2.987. PMID: 35858042; PMCID: PMC9299576.](https://pubmed.ncbi.nlm.nih.gov/35858042/)
