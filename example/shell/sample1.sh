echo ==========Cutadapt start at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/cutadapt -q 15,15 -u 4 -m 0 --max-n 0.1 -O 1 -a file:/example_path/Pipeline/Software/Cutadapt/Bgi500_SE100_1.fa -e 0.1 --too-short-output ../Result/Filter/sample1/sample1_low17_00.fq.gz -o ../Result/Filter/sample1/sample1.clean_00.fq.gz /example_path/cfRNA_2019-4-18/sometest/7_Code/soft/example/data/CTL-1.fq.gz > ../Result/Filter/sample1/sample1.Cutadapt_00.stat && \
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/cutadapt -q 15,15 -m 17 --max-n 0.1 -O 1 -a file:/example_path/Pipeline/Software/Cutadapt/Bgi500_SE100_2.fa -e 0.1 --too-short-output ../Result/Filter/sample1/sample1_low17.fq.gz -o ../Result/Filter/sample1/sample1.clean.fq.gz ../Result/Filter/sample1/sample1.clean_00.fq.gz > ../Result/Filter/sample1/sample1.Cutadapt.stat && \
echo ==========filter end at : `date` ==========
echo ==========rmRNA start at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bowtie -v 1 -p 8 -a --best --strata --norc --un ../Result/rmRNA/sample1/sample1.rmRNA.fq /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19_rRNA_Y_RNA.fa ../Result/Filter/sample1/sample1.clean.fq.gz -S ../Result/rmRNA/sample1/sample1.sam 2> ../Result/rmRNA/sample1/sample1.Map2GeneStat.xls && \
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/samtools view -hb ../Result/rmRNA/sample1/sample1.sam -o ../Result/rmRNA/sample1/sample1.bam && \
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bgzip ../Result/rmRNA/sample1/sample1.rmRNA.fq && \
rm ../Result/rmRNA/sample1/sample1.sam && \
echo ==========miRNA bowtie start at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bowtie -v 1 -p 8 -a --best --strata --norc --un ../Result/miRNA/sample1/sample1.miRNA.fq  /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/index/bowtie1/hg19.miRNA.fa ../Result/rmRNA/sample1/sample1.rmRNA.fq.gz -S ../Result/miRNA/sample1/sample1.sam  2> ../Result/miRNA/sample1/sample1.Map2GeneStat.xls && \
perl /example_path/cfRNA_2019-4-18/sometest/7_Code/soft/Bin/Remove_har_miRNA.pl ../Result/miRNA/sample1/sample1.sam /example_path/Project/P17Z10200N0384/wangtaifu/cfRNA_pipe/cfRNA_data_2019-3/miRNA_Test/ref/BowtieIndex/miRNA.des  2> ../Result/miRNA/sample1/sample1.total |/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/samtools view -hb -o ../Result/miRNA/sample1/sample1.bam && \
perl /example_path/cfRNA_2019-4-18/sometest/7_Code/soft/Bin/miRNA_Count_RPM.pl ../Result/miRNA/sample1/sample1.bam sample1 ../Result/Expre/sample1 /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/ref/Sym2Tran/Sym2Tran.type.txt && \
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bgzip ../Result/miRNA/sample1/sample1.miRNA.fq && \
rm ../Result/miRNA/sample1/sample1.sam && \
echo ==========miRNA bowtie end at : `date` ==========
echo ==========t-piRNA bowtie start at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bowtie -v 1 -p 8 -a --best --strata --norc --un ../Result/tpiRNA/sample1/sample1.tpiRNA.fq  /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19.t_piRNA.fa ../Result/miRNA/sample1/sample1.miRNA.fq.gz -S ../Result/tpiRNA/sample1/sample1.sam  2> ../Result/tpiRNA/sample1/sample1.Map2GeneStat.xls && /example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/samtools view -hb ../Result/tpiRNA/sample1/sample1.sam -o ../Result/tpiRNA/sample1/sample1.bam && \
perl /example_path/cfRNA_2019-4-18/sometest/7_Code/soft/Bin/tpiRNA_Count_RPM.pl ../Result/tpiRNA/sample1/sample1.bam sample1 ../Result/Expre/sample1 /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/ref/Sym2Tran/Sym2Tran.type.txt && \
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bgzip ../Result/tpiRNA/sample1/sample1.tpiRNA.fq && \
rm ../Result/tpiRNA/sample1/sample1.sam && \
echo ==========t-piRNA bowtie end at : `date` ==========
echo ==========mRNA bowtie start at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bowtie -v 1 -p 8 -a --best --strata --norc --un ../Result/mRNA/sample1/sample1.un_mRNA.fq /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/index/bowtie1/hg19.lnc_mRNA.fa ../Result/tpiRNA/sample1/sample1.tpiRNA.fq.gz -S ../Result/mRNA/sample1/sample1.sam  2> ../Result/mRNA/sample1/sample1.Map2GeneStat.xls && /example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/samtools view -hb ../Result/mRNA/sample1/sample1.sam -o ../Result/mRNA/sample1/sample1.bam && \
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bgzip ../Result/mRNA/sample1/sample1.un_mRNA.fq && \
rm ../Result/mRNA/sample1/sample1.sam && \
echo ==========mRNA bowtie end  at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/rsem/rsem-calculate-expression -p 8 --seed-length 17 --no-bam-output --bam  ../Result/mRNA/sample1/sample1.bam /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref/index/rsem/hg19.lnc_mRNA.fa ../Result/Expre/sample1/sample1 && \
echo ==========RSEM end at : `date` ==========
echo ==========otherRNA bowtie start at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bowtie -v 1 -p 8 -a --best --strata --norc --un ../Result/otherRNA/sample1/sample1.un_otherRNA.fq  /example_path/Pipeline/Share_Pipe/RNA/database/RNA_ref/cfRNA_ref2019-4-17/index/bowtie1/hg19_Genocode.fa ../Result/mRNA/sample1/sample1.un_mRNA.fq.gz -S ../Result/otherRNA/sample1/sample1.sam  2> ../Result/otherRNA/sample1/sample1.Map2GeneStat.xls && /example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/samtools view -hb ../Result/otherRNA/sample1/sample1.sam -o ../Result/otherRNA/sample1/sample1.bam && \
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/bgzip ../Result/otherRNA/sample1/sample1.un_otherRNA.fq && \
rm ../Result/otherRNA/sample1/sample1.sam && \
echo ==========otherRNA bowtie end at : `date` ==========
echo ==========STAR Genome start at : `date` ==========
/example_path/Pipeline/Share_Pipe/RNA/RNAseq/software/STAR --runThreadN 10 --genomeDir /example_path/Project/P17Z10200N0384/wangtaifu/cfRNA_science_2018/sci_pipe-2019-4-22/align_stat/index/hg19 --readFilesIn ../Result/otherRNA/sample1/sample1.un_otherRNA.fq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../Result/Genome/sample1/sample1 --outReadsUnmapped Fastx --outSAMtype BAM SortedByCoordinate && \
echo ==========STAR Genome end at : `date` ==========
