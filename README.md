## Introduction:
FullCfRNAtools v1.0  

Author: Taifu Wang(mail:wangtaifu@genomics.cn)  

This pipeline is designed for PALM-seq which is a new method to get all sorts of RNA in one library  

## Usage:
Requirements: 
	1. Bgzip/gzip  
	2. cutadapt  
	3. bowtie  
	4. samtools  
	5. rsem  
	6. STAR  

Install :  
	Simply download it and unzip it  
	Go to the Bin,and runing the perl scripts  


## Description

### Perl script: 
1. Final_cfRNAPipe.pl :Generate all shell scripts for all given samples  
2. Remove_har_miRNA.pl :Remove harpin miRNA from miRNA mapping result  
2. miRNA_Count_RPM.pl :Count the miRNA reads and scale to RPM  
4. tpiRNA_Count_RPM.pl :Count the tRNA and piRNA reads and scale to RPM  


