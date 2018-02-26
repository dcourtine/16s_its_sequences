#!/usr/bin/perl
use strict;
use warnings;


#     This script read the 3 files with trimmed sequences (trimmed and Reverse-Complement
#     for reverse sequencing primers).
#
#     Then it creates a file per sample (e.g.:Titi.fasta, containing sequences associated 
#           to A4RF, A1492R and A71R sequencing runs)
#     This file will be aligned with Muscle in the following script (5-align.sh)
#


####################################################
if (@ARGV != 1){
	print "\nUsage: $0 <Final Trimming Cutoff used>\n\n";
	print "The trimming cutoff must be a positive integer, e.g: 800\n\n";
	die;
}

sub isint{
   my $val = shift;
   return ($val =~ m/^\d+$/);
}

if(!isint($ARGV[0])){
      die "\nThe script aborted because of trimming cutoff is not a positive integer\n\n";
}
####################################################

my %A4F;
my %A1492R;
my %A71R;

my $seq="";
my $nom="";
open(IN1, "MultiFasta-A4F.fasta.final.trimm$ARGV[0]") or die "erreur $!";
while(<IN1>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A4F{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split(" ",$_);
		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A4F{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN1;
##################################################
# $seq="";
# $nom="";
# open(IN3, "MultiFasta-A958R.fasta.final.trimm$ARGV[0].RC") or die "erreur $!";
# while(<IN3>){
#       chomp;
#             if (substr ($_, 0,1) eq ">") {
#             if ($seq ne "") {
# 		      $A958R{$nom}=$seq;	#on associe la séquence avec le nom du géne
# 		}
# 		my @nomc=split(" ",$_);
# 		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
# 		$seq="";	        #réinitialisation de la variable.
# 	}
# 	else {
# 		$seq = $seq.$_;
# 	}
# }
# $A958R{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
# close IN3;
#############################################
$seq="";
$nom="";
open(IN4, "MultiFasta-A1492R.fasta.final.trimm$ARGV[0].RC") or die "erreur $!";
while(<IN4>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A1492R{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split(" ",$_);
		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A1492R{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN4;
#############################################
$seq="";
$nom="";
open(IN5, "MultiFasta-A71R.fasta.final.trimm$ARGV[0].RC") or die "erreur $!";
while(<IN5>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A71R{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split(" ",$_);
		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A71R{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN5;
#####################################################################################
#####################################################################################

foreach my $k(sort {$a cmp $b} keys(%A4F)){
#Here, any problem of AMTc10 matching AMTc101, beacause there is no REGEX!!
#only key matching
	my $new_name=$k.".fasta";     #nom du futur fichier
    $new_name=~s/>//;             #enlève le chevron dans le nom du fichier
      
    open(OUT, ">All_fasta_aligned/$new_name") or die "erreur $!";
	my $A4=$k."_A4F";
	print OUT "$A4\n$A4F{$k}\n";
	
	my $A1492=$k."_A1492R";     
	print OUT "$A1492\n$A1492R{$k}\n";
	
	my $A71=$k."_A71R";     
	print OUT "$A71\n$A71R{$k}\n";
	close OUT
}


