#!/usr/bin/perl
use strict;
use warnings;

#
#     This script clear the alignment file (.msf) from sequences of "reference strains"
#     employed to perform the alignment.
#
#     Note: "If loops (line 45-53-61) may contain some mistakes
#


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
            if($countLines == 3){         #pour imprimer les lignes trois par trois
                  print OUT "\n";
                  $countLines=0;
            }
      }
      if($imprim==0 and $_=~m/_A1492R   /){
            $countLines++;
            print OUT "$_\n";
            if($countLines == 3){         #idem
                  print OUT "\n";
                  $countLines=0;
            }
      }
      if($imprim==0 and $_=~m/_A71R   /){#idem, il faut rajouter des boucles pour les autres primers
            $countLines++;                #et modifier la condition de la variable $countLines
            print OUT "$_\n";
            if($countLines == 3){         #idem
                  print OUT "\n";
                  $countLines=0;
            }
      }
}
close IN;
close OUT;

print "$name\n";  #print le nom de la seq entrain d'être traitée dans la stdout
                  #pour que le nom de la sequence apparaisse dans le prochain script (consambig)
