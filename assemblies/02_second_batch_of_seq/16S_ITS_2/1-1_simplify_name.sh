#!/bin/bash


################ Trimming ##################
for file in MultiFasta-A*.fasta
do
      perl 1-2_simplify_name.pl $file
done
