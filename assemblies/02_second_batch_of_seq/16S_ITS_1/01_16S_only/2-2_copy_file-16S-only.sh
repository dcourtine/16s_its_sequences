#!/bin/bash

#for file in MultiFasta_A*.seq
for file in MultiFasta_16S_ITS_1-A*.fasta
do
      echo "$file" 
      grep ">" $file |wc -l
      echo "$file.final"
      grep ">" $file.final |wc -l
      cp $file.final $file.final.corrected
done
