#!/usr/bin/perl

use strict;
use warnings;

##
## input Fasta file with following description line for example:
## >AMTC57_A4F_52 status=ok nucl=1068 crlStart=11 crlStop=856 crlLen=846 order=COL15-1F0E
## or
## >E10P10_A4F_5-181253_I2.ab1
##
## The Output description line will be: ">AMTC57_A4F"
##
if (@ARGV != 1){
      print"Please, give an infile in the command line\n";
      die
}

open(F1, "$ARGV[0]") or die "erreur $!";
open (OUT, ">simplify.$ARGV[0]") or die "erreur $!";

while(<F1>){
      chomp;
      if ($_ =~m/(>.+?)_A\d+[F,R]/){      ##### ancienne version: =~m/>(.+)_A/
            print OUT "$1 \n";
      }
}
close F1;
close OUT;
