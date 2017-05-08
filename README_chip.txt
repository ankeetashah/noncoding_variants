#first get raw BED files by running chip/raw/get_files.sh

#preprocessing steps
#run chip/preprocessing/sort.sh

#filter these peaks to be only those in open chromatin regions by filtering with dnase data
#run chip/preprocessing/filter.sh

#sort again to rearrange chromosomes in lexicographical order by running chip/preprocessing/secondsort.sh

#get fasta files by running chip/fasta/getfasta.sh

#remove duplicates with chip/fasta/duplicatefasta.sh

#finally, create a directory for pssms from meme
mkdir pssm_meme

meme ./seqs-sampled -oc meme_out -mod zoops -nmotifs 20 -minw 6 -maxw 50 -bfile ./background -dna -maxsize 8000000 -revcomp -nostatus

#all ouptut files with motif logos are in the pssm_meme/ directory 
