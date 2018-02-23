#!/bin/bash


################ Trimming ##################
for file in MultiFasta_A*.seq
do
      perl 1-2_simplify_name.pl $file

done