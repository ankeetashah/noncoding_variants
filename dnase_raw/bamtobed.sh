#!/bin/sh
for f in GM12878_1 GM12878_2 GM12878_3 GM12878_4 GM12878_5
do
bedtools bamtobed -i $f.clean.bam > $f.bed
done
