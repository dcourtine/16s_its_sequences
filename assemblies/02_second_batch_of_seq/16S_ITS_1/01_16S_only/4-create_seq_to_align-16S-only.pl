#!/usr/bin/perl
use strict;
use warnings;

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

my $seq="";
my $nom="";
open(IN1, "MultiFasta_16S_ITS_1-A4F.fasta.final.corrected.trimm$ARGV[0]") or die "erreur $!";
while(<IN1>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A4F{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split(" ",$_);
		$nom = $nomc[0]."--";		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A4F{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN1;
##################################################

$seq="";
$nom="";
open(IN4, "MultiFasta_16S_ITS_1-A1492R.fasta.final.corrected.trimm$ARGV[0].RC") or die "erreur $!";
while(<IN4>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A1492R{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split(" ",$_);
		$nom = $nomc[0]."--";		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A1492R{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN4;
#####################################################################################
#####################################################################################

foreach my $k(sort {$a cmp $b} keys(%A4F)){
      #print"$k\n$A4F{$k}\n";
      my $new_name=$k.".fasta";     #nom du futur fichier
      $new_name=~s/>//;             #enlève le chevron dans le nom du fichier
	  $new_name=~s/--//;
      
      open(OUT, ">All_fasta_aligned/$new_name") or die "erreur $!";
      my $A4=$k."_A4F";
	  $A4=~s/--//;
      print OUT "$A4\n$A4F{$k}\n";
      
      my $A1492=$k."_A1492R";     
      $A1492=~s/--//;
	  print OUT "$A1492\n$A1492R{$k}\n";
}

