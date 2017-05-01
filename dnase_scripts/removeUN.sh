#!/bin/sh

for f in GM12878_1 GM12878_2 GM12878_3 GM12878_4 GM12878_5
do
        sed -i -e '/chrM/d;/random/d;/chrUn/d' $f.bed
done
