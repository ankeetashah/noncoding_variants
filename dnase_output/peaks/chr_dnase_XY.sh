#!/bin/sh

for i in X Y
do
        grep -w "chr$i" filtered.peaks.narrowPeaks.sort2 > chr$i.dnase
done 
