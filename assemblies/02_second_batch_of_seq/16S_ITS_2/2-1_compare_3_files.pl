#!/usr/bin/perl

###################
#     This script read the 3 Multifasta files created earlier 
#     
#     Then it creates 3 new Multifasta files, one for each sequencing primer
#
#     Only common sequences will be present in these files.
#
#     For example, sequencing run A4F failed for the sample "TOTO",
#     so sequences "TOTO_A1492R" and "TOTO_A71R" will be missing, while sequencing runs worked well,
#     in files "Multifasta_A4F.seq.final", "Multifasta_A1492R.seq.final" and 
#     "Multifasta_A71R.seq.final".
#
###################

use strict;
use warnings;
my %A4F;
my %A1492R;
my %A71R;
my @ls=`ls simplify.*`;
for(my $i=0; $i<=$#ls; $i++){
      chomp ($ls[$i]);
      print "$ls[$i]\n\n";
}     
      
open(IN, "$ls[0]") or die "erreur $!";          
      while(<IN>){                              
      chomp;
      if("$ls[0]" =~m/A1492R/){
            $A1492R{$_}+=1;
      }
      elsif("$ls[0]" =~m/A4F/){
            $A4F{$_}+=1;
      }
      elsif("$ls[0]" =~m/A71R/){
            $A71R{$_}+=1;
      }
}
close IN;

open(IN, "$ls[1]") or die "erreur $!";
      while(<IN>){
      chomp;
      if("$ls[1]" =~m/A1492R/){
            $A1492R{$_}+=1;
      }
      elsif("$ls[1]" =~m/A4F/){
            $A4F{$_}+=1;
      }
      elsif("$ls[1]" =~m/A71R/){
            $A71R{$_}+=1;
      }
}
close IN;

open(IN, "$ls[2]") or die "erreur $!";
      while(<IN>){
      chomp;
      if("$ls[2]" =~m/A1492R/){
            $A1492R{$_}+=1;
      }
      elsif("$ls[2]" =~m/A4F/){
            $A4F{$_}+=1;
      }
      elsif("$ls[2]" =~m/A71R/){
            $A71R{$_}+=1;
      }
}
close IN;

my @liste_nom_seq;
foreach my $k(sort {$a cmp $b} keys(%A1492R)){
      if(defined($A4F{$k})){        ##vérifier que le nom de la séquence est présente dans les 3 fichiers
            if(defined($A71R{$k})){
                  #print OUT "$k\n";
                  push(@liste_nom_seq,$k);      #créer un tableau avec le noms de seq classés dans l'ordre
            }
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

open(IN1, "MultiFasta_A1492R.seq") or die "erreur $!";
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
		$nom = $li[0];		#Nom de la seq = nom de l'echantillon seul
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
open (OUT1, ">MultiFasta_A1492R.seq.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq
      foreach my $k(keys(%h1492)){        #parcours du hash h1492 pour avoir les seq des seq communes
      
            $k=~s/\s//;
            $liste_nom_seq[$i]=~s/\s//;
            if ($liste_nom_seq[$i] eq $k ){ 
                  my $new_name=$k." A1492R";
                  print OUT1 "$new_name\n$h1492{$k}\n";
            }
      }
}
close OUT1;

            #################################
open(IN3, "MultiFasta_A4F.seq") or die "erreur $!";
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
		$nom = $li[0];		#Nom de la seq = ligne entière
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
open (OUT3, ">MultiFasta_A4F.seq.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq communes

      foreach my $k(sort {$a cmp $b} keys(%h4)){        #parcours du hash h4 pour avoir les seq des seq communes   
      
            $k=~s/\s//;
            $liste_nom_seq[$i]=~s/\s//;
            if ($liste_nom_seq[$i] eq $k ){
                  my $new_name=$k." A4F";      
                  print OUT3 "$new_name\n$h4{$k}\n";
           }
      }

}
close OUT3;

            #################################
open(IN4, "MultiFasta_A71R.seq") or die "erreur $!";
my %h71;
$seq="";
$nom="";
while(<IN4>){
      chomp;
      if($_=~m/\r/){
            $_=~s/\r//;
      }
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $h71{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @li= split("_", $_);
##		$li[0] =~s/>//;
		$nom = $li[0];		#Nom de la seq = ligne entière
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$h71{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN4;

# #Trimming des sequences:
# foreach my $k(keys(%h4)){
#       my $new_k="";
#       if(length($h4{$k}) > 900){
#             $new_k=substr($h4{$k},0,900);
#             $h4$k}=$new_k;
#       }
# }

#Writing output:
open (OUT4, ">MultiFasta_A71R.seq.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq communes

      foreach my $k(sort {$a cmp $b} keys(%h71)){        #parcours du hash h71 pour avoir les seq des seq communes   
      
            $k=~s/\s//;
            $liste_nom_seq[$i]=~s/\s//;
            if ($liste_nom_seq[$i] eq $k ){
                  my $new_name=$k." A4F";      
                  print OUT4 "$new_name\n$h71{$k}\n";
           }
      }

}
close OUT4;


############################################################
#####!!!! L'expression réguilière trouve que AMTC10 et AMTC101 et AMTC102 sont identiques!!!!!!
############################################################
# PROBLEM SOLVED



#              #################################
# open(IN4, "MultiFasta_A958R.seq") or die "erreur $!";
# my %h958;
# $seq="";
# $nom="";
# while(<IN4>){
#        chomp;
#        if (substr ($_, 0,1) eq ">") {
#              if ($seq ne "") {
#  		      $h958{$nom}=$seq;	#on associe la séquence avec le nom du géne
#  		}
#  		my @li= split("_", $_);
# # 		$li[0] =~s/>//;
#  		$nom = $li[0];		#Nom de la seq = ligne entière
#  		$seq="";	        #réinitialisation de la variable.
#  	}
#  	else {
#  		$seq = $seq.$_;
#  	}
# }
# $h958{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
# close IN4;
# 
# # #Trimming des sequences:
# # foreach my $k(keys(%h958)){
# #       my $new_k="";
# #       if(length($h958{$k}) > 900){
# #             $new_k=substr($h958{$k},0,900);
# #             $h958{$k}=$new_k;
# #       }
# # }
# 
# #Writing output:
# open (OUT4, ">MultiFasta_A958R.seq.final") or die "erreur $!";
# for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq
#        foreach my $k(keys(%h958)){        #parcours du hash h1492 pour avoir les seq des seq communes
#       
#             $k=~s/\s//;
#             $liste_nom_seq[$i]=~s/\s//;
#             if ($liste_nom_seq[$i] eq $k ){
# #                    my $new_name=$k." A958R";
#                    print OUT4 "$new_name\n$h958{$k}\n";
#              }
#        }
# }
# close OUT4;                  
#                    