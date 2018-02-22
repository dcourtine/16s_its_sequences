#!/usr/bin/perl

###################
#
#     Trimm des sequences avec "trimm_seq.sh"
#     Après ce script
#
###################

use strict;
use warnings;
my %A8F;
my %A958R;
my %A1492R;
my %A71R;
my @ls=`ls simplify.*`;
for(my $i=0; $i<=$#ls; $i++){
      chomp ($ls[$i]);
      print "$ls[$i]\n";
}     
      
#### Point the sequences that are present for a given primer.
open(IN, "$ls[0]") or die "erreur $!";
while(<IN>){
	chomp;
	$_ =~s/ //;
	$A1492R{$_."_"}+=1;
}
close IN;

open(IN, "$ls[1]") or die "erreur $!";
while(<IN>){
    chomp;
	$_ =~s/ //;
    $A71R{$_."_"}+=1;
}
close IN;

open(IN, "$ls[2]") or die "erreur $!";
while(<IN>){
    chomp;
	$_ =~s/ //;
    $A8F{$_."_"}+=1;
}
close IN;

open(IN, "$ls[3]") or die "erreur $!";
while(<IN>){
	chomp;
	$_ =~s/ //;
    $A958R{$_."_"}+=1;
}
close IN;

#open(OUT, ">toto.txt") or die "erreur $!";


### Target sequences that are present in the 4 primers files
my @liste_nom_seq;
foreach my $k(sort {$a cmp $b} keys(%A71R)){
      if(defined($A8F{$k})){              ##vérifier que le nom de la séquence est présente dans les 4 fichiers
#            print"$k\n";
            if (defined($A1492R{$k})){
                  if(defined($A958R{$k})){
                        #print OUT "$k\n";
                        push(@liste_nom_seq,$k);      #créer un tableau avec le noms de seq classés dans l'ordre
#						print"$k\n";
                  }
            }
      }
}
#for (my $i=0;$i<=$#liste_nom_seq;$i++){
#      print"$liste_nom_seq[$i]\n";
#}

#close OUT;
print"Nombre de séquences communes: $#liste_nom_seq+1\n";


####################################################################################
###### Récupérer les séquences ######   Avec @liste_nom_seq
my $seq="";
my $nom="";

open(IN1, "MultiFasta_A1492R.seq") or die "erreur $!";
my %h1492;
while(<IN1>){
      chomp;
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $h1492{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @li= split("_", $_);
#		$li[0] =~s/>//;
		$nom = $li[0]."_";		#Nom de la seq = ligne entière
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
            if ($liste_nom_seq[$i] =~m/$k/ ){    ####### BUG!!!####
                my $new_name=$k." A1492R";
				$new_name =~s/_ / /;

#				print"Dans la table:\t$liste_nom_seq[$i]\tcle du hash:\t$k\n";

                print OUT1 "$new_name\n$h1492{$k}\n";
            }
      }
}
close OUT1;

             ##############################           
open(IN2, "MultiFasta_A71R.seq") or die "erreur $!";
my %h71;
$seq="";
$nom="";
while(<IN2>){
      chomp;
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $h71{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @li= split("_", $_);
		$nom = $li[0]."_";		#Nom de la seq = ligne entière
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$h71{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN2;

# #Trimming des sequences:
# foreach my $k(keys(%h71)){
#       my $new_k="";
#       if(length($h71{$k}) > 900){
#             $new_k=substr($h71{$k},0,900);
#             $h71{$k}=$new_k;
#       }
# }

#Writing output:
open (OUT2, ">MultiFasta_A71R.seq.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq
      foreach my $k(keys(%h71)){        #parcours du hash h1492 pour avoir les seq des seq communes
            if ($liste_nom_seq[$i] =~m/$k/ ){    ####### BUG!!!####
                my $new_name=$k." A71R";
				$new_name =~s/_ / /;
                print OUT2 "$new_name\n$h71{$k}\n";
            }
      }
}
close OUT2;
            #################################
open(IN3, "MultiFasta_A8F.seq") or die "erreur $!";
my %h8;
$seq="";
$nom="";
while(<IN3>){
      chomp;
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $h8{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @li= split("_", $_);
##		$li[0] =~s/>//;
		$nom = $li[0]."_";		#Nom de la seq = ligne entière
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$h8{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN3;

# #Trimming des sequences:
# foreach my $k(keys(%h8)){
#       my $new_k="";
#       if(length($h8{$k}) > 900){
#             $new_k=substr($h8{$k},0,900);
#             $h8{$k}=$new_k;
#       }
# }

#Writing output:
open (OUT3, ">MultiFasta_A8F.seq.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq communes

      foreach my $k(sort {$a cmp $b} keys(%h8)){        #parcours du hash h8 pour avoir les seq des seq communes   
            
           if ($liste_nom_seq[$i] =~m/$k/ ){          
                my $new_name=$k." A8F";               #avant: $new_name=">".$k." A8F";
                $new_name =~s/_ / /;
				print OUT3 "$new_name\n$h8{$k}\n";
           }
      }

}
close OUT3;


############################################################
#####!!!! L'expression réguilière trouve que AMTC10 et AMTC101 et AMTC102 sont identiques!!!!!!
############################################################




             #################################
open(IN4, "MultiFasta_A958R.seq") or die "erreur $!";
my %h958;
$seq="";
$nom="";
while(<IN4>){
       chomp;
       if (substr ($_, 0,1) eq ">") {
             if ($seq ne "") {
 		      $h958{$nom}=$seq;	#on associe la séquence avec le nom du géne
 		}
 		my @li= split("_", $_);
# 		$li[0] =~s/>//;
 		$nom = $li[0]."_";		#Nom de la seq = ligne entière
 		$seq="";	        #réinitialisation de la variable.
 	}
 	else {
 		$seq = $seq.$_;
 	}
}
$h958{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN4;

# #Trimming des sequences:
# foreach my $k(keys(%h958)){
#       my $new_k="";
#       if(length($h958{$k}) > 900){
#             $new_k=substr($h958{$k},0,900);
#             $h958{$k}=$new_k;
#       }
# }

#Writing output:
open (OUT4, ">MultiFasta_A958R.seq.final") or die "erreur $!";
for (my $i=0;$i<=$#liste_nom_seq;$i++){   #Parcours du tableau contenant tous les noms de seq
       foreach my $k(keys(%h958)){        #parcours du hash h1492 pour avoir les seq des seq communes
             if ($liste_nom_seq[$i] =~m/$k/ ){
                my $new_name=$k." A958R";
                $new_name =~s/_ / /;
				print OUT4 "$new_name\n$h958{$k}\n";
             }
       }
}
close OUT4;                  
                   
