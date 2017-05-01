#!/bin/bash

ls ../raw/*.bed > files
cat files | while read i
do
        sort -k1,1n -k2,2n -k3,3n $i > $i.sort
        bedtools sort -i $i.sort> $i.sort2
done
