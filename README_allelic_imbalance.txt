#Performing Allelic Imbalance Analysis
#the allelic_imbalance_chip and allelic_imbalance_control directories contains I/O samples for ATF2/3 (chip and control)
#the allelic_imbalance_scripts directory itself contains scripts used


#download the set of Common SNPs from dbSNP build 138
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/snp138Common.txt.gz

#remove uncommon chromosomes (like M) - only leave chromosomes 1-22, X, Y to get a snp138Common.genomic.single.brief.vcf 

wget https://www.encodeproject.org/files/ENCFF005MDO/@@download/ENCFF005MDO.bam
wget https://www.encodeproject.org/files/ENCFF994ZHD/@@download/ENCFF994ZHD.bam
wget https://www.encodeproject.org/files/ENCFF478PVM/@@download/ENCFF478PVM.bam
wget https://www.encodeproject.org/files/ENCFF039PAG/@@download/ENCFF039PAG.bam
wget https://www.encodeproject.org/files/ENCFF488YYE/@@download/ENCFF488YYE.bam

#get allele frequency for each SNP
#can get the hg19.fa in a different directory (or as shown previously)

#ATF2
perl bam2vcf.pl -t 0 -l 101 -r hg19.fa -s snp138Common.genomic.single.brief.vcf -x -u -t 0 -v ENCFF396BCM.bam > ENCFF396BCM.bam.vcf

perl bam2vcf.pl -t 0 -l 101 -r hg19.fa -s snp138Common.genomic.single.brief.vcf -x -u -t 0 -v ENCFF994ZHD.bam > ENCFF994ZHD.bam.vcf

#ATF3
perl bam2vcf.pl -t 0 -l 101 -r hg19.fa -s snp138Common.genomic.single.brief.vcf -x -u -t 0 -v ENCFF478PVM.bam > ENCFF478PVM.bam.vcf

perl bam2vcf.pl -t 0 -l 101 -r hg19.fa -s snp138Common.genomic.single.brief.vcf -x -u -t 0 -v ENCFF039PAG.bam > ENCFF039PAG.bam.vcf

#control
perl bam2vcf.pl -t 0 -l 101 -r hg19.fa -s snp138Common.genomic.single.brief.vcf -x -u -t 0 -v ENCFF488YYE.bam > ENCFF488YYE.bam.vcf 

#combine replicates
perl combine_vcf.pl -x -v ENCFF396BCM.bam.vcf ENCFF994ZHD.bam.vcf > ATF2.vcf

perl combine_vcf.pl -x -v ENCFF478PVM.bam.vcf ENCFF039PAG.bam.vcf > ATF3.vcf




#combine vcf files
ls ATF2.vcf ATF3.vcf > vcf.ATF.list
perl combine_vcf.pl -l vcf.ATF.list -x -v > pool.ATF.snp138Common.count.vcf

ls ENCFF488YYE.bam.vcf > vcf.control.list
perl combine_vcf.pl -l vcf.control.list -x -v > pool.control.snp138Common.count.vcf


#combine
#get the list of SNPs we would like to focus on: unambiguous strand (i.e., major allele>0.9)
perl call_snv_strand.pl -v -s 0.9 pool.ATF.snp138Common.count.vcf > pool.ATF.snp138Common.09.strand.vcf

perl call_snv_strand.pl -v -s 0.9 pool.control.snp138Common.count.vcf > pool.control.snp138Common.09.strand.vcf

#convert to bed
perl vcf2bed.pl -v pool.ATF.snp138Common.09.strand.vcf pool.ATF.snp138Common.09.strand.bed


#get sequences of the reference and alternative alleles
perl vcf2fasta.pl -org hg19 -ext 10 -v pool.ATF.snp138Common.09.strand.vcf pool.ATF.snp138Common.09.strand.ref.21nt.fa pool.ATF.snp138Common.09.strand.alt.21nt.fa

perl vcf2fasta.pl -org hg19 -ext 10 -v pool.control.snp138Common.09.strand.vcf pool.control.snp138Common.09.strand.ref.21nt.fa pool.control.snp138Common.09.strand.alt.21nt.fa

#convert vcf to count files
perl summarize_snv.pl -v -l pool.ATF.snp138Common.09.strand.vcf  -s --keep-score ATF2.vcf ATF2.snp.count.txt

perl summarize_snv.pl -v -l pool.ATF.snp138Common.09.strand.vcf  -s --keep-score ATF3.vcf ATF3.snp.count.txt

perl summarize_snv.pl -v -l pool.control.snp138Common.09.strand.vcf  -s --keep-score ENCFF488YYE.bam.vcf control.snp.count.txt

-------------

#ATF2
#get the motif sites overlapping with the SNP

PatternMatch -c TGACTCA -m 3 -b pool.ATF.snp138Common.09.strand.ref.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.ATF.snp138Common.09.strand.ref.21nt.TGACTCA.txt

PatternMatch -c TGACTCA -m 3 -b pool.ATF.snp138Common.09.strand.alt.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.ATF.snp138Common.09.strand.alt.21nt.TGACTCA.txt



#ATF2 CONTROL
PatternMatch -c TGACTCA -m 3 -b pool.control.snp138Common.09.strand.ref.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.control.snp138Common.09.strand.ref.21nt.TGACTCA.txt

PatternMatch -c TGACTCA -m 3 -b pool.control.snp138Common.09.strand.alt.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.control.snp138Common.09.strand.alt.21nt.TGACTCA.txt



#ATF3

PatternMatch -c TCACGTG -m 3 -b pool.ATF.snp138Common.09.strand.ref.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.ATF.snp138Common.09.strand.ref.21nt.TCACGTG.txt

PatternMatch -c TCACGTG -m 3 -b pool.ATF.snp138Common.09.strand.alt.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.ATF.snp138Common.09.strand.alt.21nt.TCACGTG.txt

#ATF3 CONTROL
PatternMatch -c TCACGTG -m 3 -b pool.control.snp138Common.09.strand.ref.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.control.snp138Common.09.strand.ref.21nt.TCACGTG.txt

PatternMatch -c TCACGTG -m 3 -b pool.control.snp138Common.09.strand.alt.21nt.fa | awk '{if($2>=5 && $3<=16) {print $1}}' | sort | uniq -c | awk '{print $2"\t"$1}' > pool.control.snp138Common.09.strand.alt.21nt.TCACGTG.txt












