#!/bin/bash


cat ../preprocessed/filtered.sort | while read i

do
        echo $i 
        bedtools getfasta -fi ../../genome/hg19.fa -bed ../$i -fo $i.fa

done 

