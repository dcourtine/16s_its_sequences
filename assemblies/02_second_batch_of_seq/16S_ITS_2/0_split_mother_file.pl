#!/usr/bin/perl

use strict;
use warnings;

#
#     This script split a Multifasta file into 3 smaller Multifasta files
#     in term of primer sequencing employed
#     Here primers are A4F, A1492R and A71R
#

############### CHECK Arguments ####################
if (@ARGV != 4){
	print "\nUsage: $0 <MultiFasta file> <Primer Forward> <Primer Reverse> <Primer Reverse>\n\n";
	print "The output file are multiFasta files\n";
	print "One file per Primer\n";
	die;
}

open(IN, "$ARGV[0]") or die "erreur $!";
open(OUT4F,">MultiFasta_$ARGV[1].seq") or die "erreur $!";
open(OUT1492R,">MultiFasta_$ARGV[2].seq") or die "erreur $!";
open(OUT71R,">MultiFasta_$ARGV[3].seq") or die "erreur $!";

my $A4= my $A1492 = my $A71 = 0;

while (<IN>){
      chomp;

      if(substr($_,0,1) eq ">"){
            $A4=0;
            $A1492=0;
            $A71=0;
            if($_=~m/_A4F_/){
                  print OUT4F "$_\n";
                  $A4=1;
            }
            if($_=~m/_A1492R_/){
                  print OUT1492R "$_\n";
                  $A1492=1;
            }
            if($_=~m/_A71R_/){
                  print OUT71R "$_\n";
                  $A71=1;
            }
      }
      elsif($_=~m/^[ATCGNatcgn]/){
            if($A4==1 and $A1492==0 and $A71==0){        ###Check if this test is working or not###
                  print OUT4F "$_\n";
            }
            if($A4==0 and $A1492==1 and $A71==0){
                  print OUT1492R "$_\n";
            }
            if($A4==0 and $A1492==0 and $A71==1){
                  print OUT71R "$_\n";
            }
      }
}
close IN;
close OUT4F;
close OUT1492R;
close OUT71R;