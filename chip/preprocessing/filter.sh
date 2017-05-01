#!/bin/bash

ls *.bed.sort2 > chip
ls ../../dnase/output/peaks/*.dnase > dnase

cat chip | while read i
do
        echo $i 
        cat dnase | while read j 
        do
                echo $j
                python ../../scripts/filter.py $i $j $i.filtered
        done 
done 

