#!/usr/bin/perl

use strict;
use warnings;

############### CHECK Arguments ####################
if (@ARGV != 3){
	print "\nUsage: $0 <MultiFasta file> <Primer Forward> <Primer Reverse>\n\n";
	print "The output file are multiFasta files\n";
	print "One file per Primer\n";
	die;
}

open(IN, "$ARGV[0]") or die "erreur $!";
open(OUT4F,">MultiFasta_$ARGV[1].seq") or die "erreur $!";
open(OUT1492R,">MultiFasta_$ARGV[2].seq") or die "erreur $!";

my $A4= my $A1492 = 0;

while (<IN>){
      chomp;

      if(substr($_,0,1) eq ">"){
            $A4=0;
            $A1492=0;
            if($_=~m/_A4F_/){
                  print OUT4F "$_\n";
                  $A4=1;
            }
            if($_=~m/_A1492R_/){
                  print OUT1492R "$_\n";
                  $A1492=1;
            }
      }
      elsif($_=~m/^[ATCGNatcgn]/){
            if($A4==1 and $A1492==0){        ###Check if this test is working or not###
                  print OUT4F "$_\n";
            }
            if($A4==0 and $A1492==1){
                  print OUT1492R "$_\n";
            }
      }
}
close IN;
close OUT4F;
close OUT1492R;