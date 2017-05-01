#!/bin/bash

ls *filtered.sort.fa > dup

cat dup | while read i

do

        awk '/^>/{f=!d[$1];d[$1]=1}f' $i > $i.dup.fa
done 

