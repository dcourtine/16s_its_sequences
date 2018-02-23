#!/usr/bin/perl
use strict;
use warnings;

####################################################
if (@ARGV != 2){
	print "\nUsage: $0 <infile msf format> <Outfile>\n\n";
	print "the Outfile will be composed of only primers sequences\n\n";
	die;
}
####################################################

open(IN, "$ARGV[0]") or die "erreur $!";
open(OUT, ">$ARGV[1]") or die "erreur $!";

my $name="";
my $imprim=1;
my $countLines=0;
while(<IN>){
      chomp;
      if($imprim==1){
            if($_=~m/Name: /){     #print que les lignes de description correspondant a nos primers
                  if($_=~m/_A\d+[FR]   /){
                        print OUT "$_\n";
                  }
                  if($_=~m/Name: (.+)_A\d+/){
                        $name=$1;
                  }
            }
            else {print OUT "$_\n";}
      }
      if($_ =~m/\/\//){
            $imprim=0;
            print OUT"\n";
      }
      
      if($imprim==0 and $_=~m/_A4F   /){  #print les lignes correspondant a 1 primer
            $countLines++;
            print OUT "$_\n";
            if($countLines == 2){         #pour imprimer les lignes deux par deux
                  print OUT "\n";
                  $countLines=0;
            }
      }
      if($imprim==0 and $_=~m/_A1492R   /){#idem, il faut rajouter des boucles pour les autres primers
            $countLines++;
            print OUT "$_\n";
            if($countLines == 2){         #idem
                  print OUT "\n";
                  $countLines=0;
            }
      }
}
close IN;
close OUT;

print "$name\n";  #print le nom de la seq entrain d'être traitée dans la stdout
                  #pour que le nom de la sequence apparasse dans le prochain script (consambig)
