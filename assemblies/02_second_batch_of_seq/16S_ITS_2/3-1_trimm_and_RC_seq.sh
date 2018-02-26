#!/bin/bash

#
#     The trimming cutoff need to be precise in this script, else the Perl programm will abort
#


################ Trimming ##################
for file in *.fasta.final
do
      perl 3-2_trimm_fasta_sequences.pl $file $file.trimm800 25 800

done


################## RC #####################
for file in *R.fasta.final.trimm800

      do revseq -tag 0 -sequence $file -outseq $file.RC
done 
date
