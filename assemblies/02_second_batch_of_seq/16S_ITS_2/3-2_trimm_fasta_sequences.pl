#!/usr/bin/perl

use strict;
use warnings;

#######
# Use a (multi)Fasta file as input and return a (multi)fasta file as output
#
# Script designed By Damien Courtine, 28/04/2015
#######

############### CHECK Arguments ####################
if (@ARGV != 4){
	print "\nUsage: $0 <Fasta file> <Output file> <Trimming START> <Trimming END>\n\n";
	print "The output file is a (multi)Fasta file\n";
	print "The trimming cutoffs must be positives integers, e.g:25 800.\n";
	print "In this example, the sequence measure 775 nuccleotides/Amino acid,\nif the sequence is longer than the trimming end cutoff.\n\n";
	die;
}

sub isint{
   my $val = shift;
   return ($val =~ m/^\d+$/);
}

if(!isint($ARGV[2]) and !isint($ARGV[3])){
      die "\nThe script aborted because of trimming cutoff are not positives integers\n\n";
}
####################################################

my $start=$ARGV[2];
my $length=$ARGV[3];
my $stop=$length-$start;

open(IN,"$ARGV[0]") or die "erreur $!";
open(OUT,">$ARGV[1]") or die "erreur $!";

my $seq="";
my $nom="";
while(<IN>){
       chomp;
       if (substr ($_, 0,1) eq ">") {     #check for the sequence name, start with ">"
            if ($seq ne "") {            #If $seq is not empty
                  if(length($seq) >= $ARGV[3]){
                        my $trimmseq=substr($seq,$start,$stop);      #Trimm the sequence here, then write it in OUT output file
                        print OUT "$trimmseq\n";
                        }
                  else{ 
                        my $length_seq=length($seq);
                        my $new_seq=substr($seq,$start,$length_seq);        #trimm only the start of the sequence
                        print OUT "$new_seq\n";
                  }
 		}
 		print OUT "$_\n";            #Print the name of the sequence
 		$seq="";                      #reset the seq variable, containing the past sequence
 	}
 	else {
 		$seq = $seq.$_;
 	}
}
if(length($seq) >= $start){
	my $trimmseq=substr($seq,$start,$stop);	  #Trimm the sequence here, then write it in OUT output file
	print OUT "$trimmseq\n";
}
else{ 
	my $length_seq=length($seq);
	my $new_seq=substr($seq,$start,$length_seq);		  #trimm only the start of the sequence
	print OUT "$new_seq\n";
}			  #Trimm and print the last sequence
close IN;
close OUT;

print"\nTrimming of $ARGV[0] done!\n";
print"The trimming  started at position $start and finished at position $length, ";
print"for a total of $stop nucleotides/amino acids\n\n";
