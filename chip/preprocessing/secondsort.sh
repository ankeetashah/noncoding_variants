#!/bin/bash

ls *filtered > filtered

cat filtered | while read i
do
        echo $i 
        cat $i | sort | uniq > $i.sort
done 

ls *filtered.sort > filtered.sort

