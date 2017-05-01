#!/bin/bash

sort -k1,1n -k2,2n -k3,3n filtered.peaks.narrowPeak > filtered.peaks.narrowPeak.sort1
bedtools sort -i filtered.peaks.narrowPeak.sort1 > filtered.peaks.narrowPeak.sort2

