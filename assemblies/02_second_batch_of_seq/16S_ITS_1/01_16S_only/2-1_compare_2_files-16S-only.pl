#!/usr/bin/perl

###################
#     Après ce script:
#     Trimm des sequences avec "trimm_seq.sh"
#
###################

use strict;
use warnings;
my %A4F;
my %A1492R;
my @ls=`ls simplify.*`;
for(my $i=0; $i<=$#ls; $i++){
      chomp ($ls[$i]);
      print "$ls[$i]\n\n";
}     
      
open(IN, "$ls[0]") or die "erreur $!";          
      while(<IN>){                              
      chomp;
	  # Check that the read line correspond to A1492R 
      if("$ls[0]" =~m/A1492R/){
            $A1492R{$_."--"}+=1;
      }
	  # Check that the read line correspond to A4F 
      elsif("$ls[0]" =~m/A4F/){
            $A4F{$_."--"}+=1;
      }
}
close IN;

open(IN, "$ls[1]") or die "erreur $!";
      while(<IN>){
      chomp;
      if("$ls[1]" =~m/A1492R/){
            $A1492R{$_."--"}+=1;
      }
      elsif("$ls[1]" =~m/A4F/){
            $A4F{$_."--"}+=1;
      }
}
close IN;


my @liste_nom_seq;
foreach my $k(sort {$a cmp $b} keys(%A1492R)){
      if(defined($A4F{$k})){        ##vérifier que le nom de la séquence est présente dans les 2 fichiers
            #print OUT "$k\n";
            push(@liste_nom_seq,$k);      #créer un tableau avec le noms de seq classés dans l'ordre
      }
}
for (my $i=0;$i<=$#liste_nom_seq;$i++){
    #  print"$liste_nom_seq[$i]\n";
}

#close OUT;
print"Nombre de séquences communes: $#liste_nom_seq+1\n";




####################################################################################
########## Récupérer les séquences ###########   Avec @liste_nom_seq
my $seq="";
my $nom="";

open(IN1, "MultiFasta_16S_ITS_1-A1492R.fasta") or die "erreur $!";
my %h1492;
while(<IN1>){
      chomp;
      if($_=~m/\r/){
            $_=~s/\r//;
      }
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $h1492{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @li= split("_", $_);
#		$li[0] =~s/>//;
		$nom = $li[0]."--";		#Nom de la seq = nom de l'echantillon seul
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$h1492{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN1;

# #Trimming des sequences:
# foreach my $k(keys(%h1492)){
#       my $new_k="";
#       if(length($h1492{$k}) > 900){
#             $new_k=substr($h1492{$k},0,900);
#             $h1492{$k}=$new_k;
#       }
# }

#Writing output:
open (OUT1, ">MultiFasta_16S_ITS_1-A1492R.fasta.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq
      foreach my $k(keys(%h1492)){        #parcours du hash h1492 pour avoir les seq des seq communes
      
            $k=~s/\s//;
            $liste_nom_seq[$i]=~s/\s//;
            if ($liste_nom_seq[$i] eq $k ){ 
                  my $new_name=$k." A1492R";
				  $new_name =~ s/--//;
                  print OUT1 "$new_name\n$h1492{$k}\n";
            }
      }
}
close OUT1;

            #################################
open(IN3, "MultiFasta_16S_ITS_1-A4F.fasta") or die "erreur $!";
my %h4;
$seq="";
$nom="";
while(<IN3>){
      chomp;
      if($_=~m/\r/){
            $_=~s/\r//;
      }
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $h4{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @li= split("_", $_);
##		$li[0] =~s/>//;
		$nom = $li[0]."--";		#Nom de la seq = ligne entière
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$h4{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN3;

# #Trimming des sequences:
# foreach my $k(keys(%h4)){
#       my $new_k="";
#       if(length($h4{$k}) > 900){
#             $new_k=substr($h4{$k},0,900);
#             $h4$k}=$new_k;
#       }
# }

#Writing output:
open (OUT3, ">MultiFasta_16S_ITS_1-A4F.fasta.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq communes

      foreach my $k(sort {$a cmp $b} keys(%h4)){        #parcours du hash h4 pour avoir les seq des seq communes   
      
            $k=~s/\s//;
            $liste_nom_seq[$i]=~s/\s//;
            if ($liste_nom_seq[$i] eq $k ){
                  my $new_name=$k." A4F";      
				  $new_name =~ s/--//;
                  print OUT3 "$new_name\n$h4{$k}\n";
           }
      }
}
close OUT3;


