#!/bin/bash


################################ DESCRIPTION ######################################################
#                                                                                                 #
#     This script clear the alignment file ($file.msf) of the "references" sequences that are used#
#     to perform the alignment. The result is available in: $file.msf.keepprimer                  #
#     Then it perform an ambiguous contig, with "CONSAMBIG", from EMBOSS.                         #
#           The result in the file:  $file.msf.keepprimer.consambig                               #
#     The aim of third part is to "clear" the consambig result, because there are many "n" at     #
#     both beginning and end of the sequence (due to alignment with full 16S)                     #
#           ==>$file.keepprimer.consambig.fasta                                                   #
#                                                                                                 #
#     Moreover, there is a kind of log file for each consensus sequence:                          #
#           ==>$file.keepprimer.consambig.err                                                     #
###################################################################################################

#
#     !!!! 6-2.....pl may contain some mistakes
#     in the three "if" loops !!!
#


######################## RIGHT LOOP ########################
for file in All_fasta_aligned/*.msf

do
      perl 6-2-keep-primer.pl $file $file.keepprimer >temp.txt
      cp $file.keepprimer $file.keepprimer.corrected
      read nom_seq < temp.txt                          #read the temporary file containing the name of the working sequence
      consambig -sequence $file.keepprimer -outseq $file.keepprimer.consambig  -name $nom_seq
      echo "$nom_seq"
      rm temp.txt
      perl 6-3-clear_consambig.pl $file.keepprimer.consambig $file.keepprimer.consambig.fasta $file.keepprimer.consambig.err
done


######################## TEST LOOP ########################
# file="All_fasta_aligned/546.fasta.complete.msf"
# 
#       perl 6-2-keep-primer.pl $file $file.keepprimer >temp.txt
#       read nom_seq < temp.txt
#       consambig -sequence $file.keepprimer -outseq $file.keepprimer.consambig  -name $nom_seq
#       rm temp.txt
#       perl 6-3-clear_consambig.pl $file.keepprimer.consambig $file.keepprimer.consambig.fasta $file.keepprimer.consambig.err
###########################################################


#################### OUTDATED ##########################
#Entrer the name of the sequence as an argument of the command.
# 
# cons -sequence $1.fasta.complete.msf.finish -outseq $1-16S_ITS.fasta -identity 1 -setcase 0.5 -plurality 1 -name $1
# 
# echo $1
#
#for file in *.msf
#################### OUTDATED ##########################