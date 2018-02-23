#!/bin/bash

###############################################################################
#                              PREREQUIS:                                     #
#                                                                             #
#     Créer les fichiers "chem" et "chem2" (cf ci-dessous) avant de lancer    #
#     ce script.                                                              #
#     Et créer le fichier "liste_keepprimer_corrected.txt" dans               #
#           ==> All_fasta_aligned/All_keepprimer_corrected/                   #
#           pour faire ceci: dans le dossier "All_keepprimer_corrected/"	  #
#			mv ../*.corrected .                                               #
#           faire un "ls >liste_keepprimer_corrected.txt                      #
#           puis dans TextWrangler, supprimer ".fasta.xxx.corrected"          #     
#           NE PAS OUBLIER DE LAISSER UNE LIGNE VIDE A LA FIN                 #
#                                                                             #
#																			  #
#			!!!! $1 = liste_keepprimer_corrected.txt !!!					  #
###############################################################################

chem='All_fasta_aligned/All_keepprimer_corrected'
chem2='All_fasta_aligned/All_keepprimer_corrected/All_fasta_finished'	
	
if [ "$#" -ne 1 ]; then
	echo "usage: $0 ${chem}/liste_keepprimer_corrected.txt"
	exit 1
fi

while read ligne
do
	echo "$ligne"
	nouveauNom="$ligne""_16S-ITS"
	cons -sequence ${chem}/${ligne}.fasta.complete.msf.keepprimer.corrected -outseq ${chem2}/${ligne}-16S-ITS.fasta -identity 1 -setcase 0.5 -plurality 1 -name $nouveauNom
done < $1


echo "Recherche de \"N\" dans les nouvelles sequences... (grep insensitive case)"
for file in $chem2/*
do
      grep -H -i "N" $file
done
echo "Recherche finie!"


# 
#    Additional (Optional) qualifiers:
#    -datafile           matrix     [EBLOSUM62 for protein, EDNAFULL for DNA]
#                                   This is the scoring matrix file used when
#                                   comparing sequences. By default it is the
#                                   file 'EBLOSUM62' (for proteins) or the file
#                                   'EDNAFULL' (for nucleic sequences). These
#                                   files are found in the 'data' directory of
#                                   the EMBOSS installation.
#    -plurality          float      [Half the total sequence weighting] Set a
#                                   cut-off for the number of positive matches
#                                   below which there is no consensus. The
#                                   default plurality is taken as half the total
#                                   weight of all the sequences in the
#                                   alignment. (Any numeric value)
#    -identity           integer    [0] Provides the facility of setting the
#                                   required number of identities at a site for
#                                   it to give a consensus at that position.
#                                   Therefore, if this is set to the number of
#                                   sequences in the alignment only columns of
#                                   identities contribute to the consensus.
#                                   (Integer 0 or more)
#    -setcase            float      [@( $(sequence.totweight) / 2)] Sets the
#                                   threshold for the positive matches above
#                                   which the consensus is is upper-case and
#                                   below which the consensus is in lower-case.
#                                   (Any numeric value)
#    -name               string     Name of the consensus sequence (Any string)
