#!/bin/sh

for f in GM12878_1 GM12878_2 GM12878_3 GM12878_4 GM12878_5
do
        samtools idxstats $f.bam | cut -f 1 | grep -v MT | xargs samtools view -b $f.bam > $f.clean.bam
done



