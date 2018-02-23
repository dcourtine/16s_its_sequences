#!/bin/bash

for file in MultiFasta_A*.seq
do
      echo "$file" 
      grep ">" $file |wc -l
      echo "$file.final"
      grep ">" $file.final |wc -l
      cp $file.final $file.final.corrected
done
