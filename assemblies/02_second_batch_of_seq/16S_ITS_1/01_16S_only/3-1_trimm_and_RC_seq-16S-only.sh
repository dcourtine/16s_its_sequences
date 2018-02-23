#!/bin/bash

#
#     The trimming cutoff need to be precise in this script, else the Perl programm will abort
#


################ Trimming ##################
for file in *.final.corrected
do
      perl 3-2_trimm_fasta_sequences-16S-only.pl $file $file.trimm750 25 750 $file.trimm750.log

done


################## RC #####################
for file in *R.fasta.final.corrected.trimm750

      do revseq -tag 0 -sequence $file -outseq $file.RC
done 
date

################# Create the folder for the next step ##############
mkdir All_fasta_aligned/
