#!/bin/bash


################ Trimming ##################
for file in MultiFasta_16S_ITS_1-A*.fasta
do
      perl 1-2_simplify_name-16S-only.pl $file

done
