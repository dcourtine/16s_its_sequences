#!/usr/bin/perl

use strict;
use warnings;

open(F1, "$ARGV[0]") or die "erreur $!";
open (OUT, ">simplify.$ARGV[0]") or die "erreur $!";

while(<F1>){
      chomp;
      if ($_ =~m/(>.+)_A\d+[F,R]/){      ##### ancienne version: =~m/>(.+)_A/
            print OUT "$1 \n";
      }
}
close F1;
close OUT;