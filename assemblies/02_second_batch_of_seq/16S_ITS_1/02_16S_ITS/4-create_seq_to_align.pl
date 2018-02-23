#!/usr/bin/perl
use strict;
use warnings;

####################################################
if (@ARGV != 2){
	print "\nUsage: $0 <Final Trimming Cutoff used> <file containing 16S sequences>\n\n";
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

# my %A4F;
# my %A1492R;
my %A71R;
my %ribosomal;

my $seq="";
my $nom="";
# open(IN1, "MultiFasta_A4F.seq.final.corrected.trimm$ARGV[0]") or die "erreur $!";
# while(<IN1>){
#       chomp;
#             if (substr ($_, 0,1) eq ">") {
#             if ($seq ne "") {
# 		      $A4F{$nom}=$seq;	#on associe la séquence avec le nom du géne
# 		}
# 		my @nomc=split(" ",$_);
# 		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
# 		$seq="";	        #réinitialisation de la variable.
# 	}
# 	else {
# 		$seq = $seq.$_;
# 	}
# }
# $A4F{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
# close IN1;
##################################################
# $seq="";
# $nom="";
# open(IN3, "MultiFasta_A958R.seq.final.corrected.trimm$ARGV[0].RC") or die "erreur $!";
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
# $seq="";
# $nom="";
# open(IN4, "MultiFasta_A1492R.seq.final.corrected.trimm$ARGV[0].RC") or die "erreur $!";
# while(<IN4>){
#       chomp;
#             if (substr ($_, 0,1) eq ">") {
#             if ($seq ne "") {
# 		      $A1492R{$nom}=$seq;	#on associe la séquence avec le nom du géne
# 		}
# 		my @nomc=split(" ",$_);
# 		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
# 		$seq="";	        #réinitialisation de la variable.
# 	}
# 	else {
# 		$seq = $seq.$_;
# 	}
# }
# $A1492R{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
# close IN4;
#############################################

open(IN5, "MultiFasta_A71R.seq.final.corrected.trimm$ARGV[0].RC") or die "erreur $!";
while(<IN5>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A71R{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split("_",$_);
		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A71R{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN5;

#############################################
$seq="";
$nom="";
open(IN6, "$ARGV[1]") or die "erreur $!";
while(<IN6>){
      chomp;
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $ribosomal{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		$nom = $_;		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$ribosomal{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN6;

#####################################################################################
#####################################################################################
# foreach my $k(keys(%ribosomal)){
#       print"$k\n$ribosomal{$k}\n";
# }



foreach my $k(sort {$a cmp $b} keys(%A71R)){
      #print"$k\n$A4F{$k}\n";
      my $new_name=$k.".fasta";     #nom du futur fichier
      $new_name=~s/>//;             #enlève le chevron dans le nom du fichier
      
      open(OUT, ">All_fasta_aligned/$new_name") or die "erreur $!";
            my $A71=$k."_A71R";     
            print OUT "$A71\n$A71R{$k}\n";
            
            my $ribo=$k."_16S";     
            print OUT "$ribo\n$ribosomal{$k}\n";
      close OUT
}


