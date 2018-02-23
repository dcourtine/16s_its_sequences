#!/usr/bin/perl

use strict;
use warnings;

#     
#           !!!!For A71R ONLY!!!!!
#

############### CHECK Arguments ####################
if (@ARGV != 1){
	print "\nUsage: $0 <MultiFasta file> \n\n";
	print "The output file are multiFasta files\n";
	print "One file per Primer\n";
	die;
}

open(IN, "$ARGV[0]") or die "erreur $!";
open(OUT71R,">MultiFasta_A71R.seq") or die "erreur $!";

my $A71 = 0;

while (<IN>){
      chomp;
      if(substr($_,0,1) eq ">"){
            print OUT71R "$_\n";
      }
      
      elsif($_=~m/^[ATCGNatcgn]/){
            print OUT71R "$_\n";
      }
}
close IN;
close OUT71R;