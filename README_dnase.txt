#get DNase BED files from ENCODE as mentioned in dnase_raw/getbam.txt

#next, run dnase_raw/cleanbam.sh on your bam files

#finally, convert your bam to bed using dnase_raw/bamtobed.sh and remove chrUN by running dnase_scripts/removeUN.sh

#use JAMM to call peaks
mkdir dnase_output/peaks
JAMM-JAMMv1.0.7.5/JAMM.sh -s [input_directory_of_all_bed] -g dnase_size/hg19.bed -f 1 -b 100 -o dnase_output/peaks

cd dnase_output/peaks
#run dnase_output/peaks/sort.sh
#then run dnase_output/peaks/chr_dnase.sh and dnase_output/peaks/chr_XY.sh after to remove any unknown chromosomes
