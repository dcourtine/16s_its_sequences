#!/bin/bash

#Ajoute la sequence du 16S-ITS de 11 génomes de Thermococcus de référence
#fait l'alignement avec Muscle (ajouter d'autres outils si nécessaire)
#fait une sauvegarde de l'alignement

for file in All_fasta_aligned/*.fasta
do
      cat 16S-ITS-thermococcales-publies.txt $file >$file.complete
done

date 


#For more detailed options about Muscle see http://www.drive5.com/muscle/manual/options.html
cd All_fasta_aligned/
for file in *.fasta.complete
do
       muscle -in $file -out $file.msf -msf -maxiters 32
       cp $file.msf $file.msf.save
       #cp $file.msf $file.msf.finish
done

date






