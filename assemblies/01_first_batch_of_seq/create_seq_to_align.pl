#!/usr/bin/perl
use strict;
use warnings;

####################################################
if (@ARGV != 1){
	print "\nUsage: $0 <Trimming Cutoff used>\n\n";
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

my %A8F;
my %A958R;
my %A1492R;
my %A71R;

my $seq="";
my $nom="";
open(IN1, "MultiFasta_A8F.seq.final.trimm$ARGV[0]") or die "erreur $!";
while(<IN1>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A8F{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split(" ",$_);
		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A8F{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN1;
##################################################
$seq="";
$nom="";
open(IN2, "MultiFasta_A71R.seq.final.trimm$ARGV[0].RC") or die "erreur $!";
while(<IN2>){
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
close IN2;
################################################
$seq="";
$nom="";
open(IN3, "MultiFasta_A958R.seq.final.trimm$ARGV[0].RC") or die "erreur $!";
while(<IN3>){
      chomp;
            if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $A958R{$nom}=$seq;	#on associe la séquence avec le nom du géne
		}
		my @nomc=split(" ",$_);
		$nom = $nomc[0];		#Nom de la seq = AMTC01 etc.
		$seq="";	        #réinitialisation de la variable.
	}
	else {
		$seq = $seq.$_;
	}
}
$A958R{$nom} = $seq;		#pour que la derniére séquence soit présente dans la table de Hash
close IN3;
#############################################
$seq="";
$nom="";
open(IN4, "MultiFasta_A1492R.seq.final.trimm$ARGV[0].RC") or die "erreur $!";
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
#####################################################################################
#####################################################################################

foreach my $k(sort {$a cmp $b} keys(%A8F)){
      #print"$k\n$A8F{$k}\n";
      my $new_name=$k.".fasta";
      $new_name=~s/>//;
      open(OUT, ">seq_to_align/$new_name") or die "erreur $!";
      my $A8=$k."_A8F";
      print OUT "$A8\n$A8F{$k}\n";
      
      my $A958=$k."_A958R";   
      print OUT "$A958\n$A958R{$k}\n";
      
      my $A1492=$k."_A1492R";     
      print OUT "$A1492\n$A1492R{$k}\n";
      
      my $A71=$k."_A71R";
      print OUT "$A71\n$A71R{$k}\n";
      close OUT;
}

