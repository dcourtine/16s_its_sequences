#!/usr/bin/perl

use strict;
use warnings;

#######
# Use a (multi)Fasta file as input and return a (multi)fasta file as output
#
# Script designed By Damien Courtine, 28/04/2015
#######

############### CHECK Arguments ####################
if (@ARGV != 5){
	print "\nUsage: $0 <Fasta file> <Output file> <Trimming START> <Trimming END> <Log File>\n\n";
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
####################################################################################

my $start=$ARGV[2];
my $length=$ARGV[3];
my $stop=$length-$start;

open(IN,"$ARGV[0]") or die "erreur $!";
open(OUT,">$ARGV[1]") or die "erreur $!";

my $seq="";
my $nom="";
my %hseq;

while(<IN>){
       chomp;
       if (substr ($_, 0,1) eq ">") {     #check for the sequence name, start with ">"
            if ($seq ne "") {            #If $seq is not empty
                  if(length($seq) >= $ARGV[3]){
                        my $trimmseq=substr($seq,$start,$stop);      #Trimm the sequence here, then write it in OUT output file
                        print OUT "$trimmseq\n";
                        $hseq{$nom}=$trimmseq;
                        }
                  elsif(length($seq) < $ARGV[3] and length($seq) > 100){ #sequence smaller than upper trimming threshold  
                        my $length_seq=length($seq);
                        my $new_seq=substr($seq,$start,$length_seq);        #trimm only the beginning of the sequence
                        print OUT "$new_seq\n";
                        $hseq{$nom}=$new_seq;
                  }
                  else{
                        print OUT "$seq\n";
                        $hseq{$nom}=$seq;
                        my $len_temp=length($seq);
                        print "\nThe sequence of $nom is too short, only $len_temp nucc, be carreful!\n\n";
                  }

 		}
 		print OUT "$_\n";             #Print the name of the next sequence
 		$nom=$_;
 		$seq="";                      #reset the seq variable, containing the past sequence
 	}
 	else {
 		$seq = $seq.$_;
 	}
}			  
###Trimm and print the last sequence###
if(length($seq) >= $ARGV[3]){
      my $trimmseq=substr($seq,$start,$stop);      #Trimm the sequence here, then write it in OUT output file
      print OUT "$trimmseq\n";
      $hseq{$nom}=$trimmseq;
      }
elsif(length($seq) < $ARGV[3] and length($seq) > 100){ #sequence smaller than upper trimming threshold  
      my $length_seq=length($seq);
      my $new_seq=substr($seq,$start,$length_seq);        #trimm only the beginning of the sequence
      print OUT "$new_seq\n";
      $hseq{$nom}=$new_seq;
}
else{
      print OUT "$seq\n";
      $hseq{$nom}=$seq;
      my $len_temp=length($seq);
      print "\nThe sequence of $nom is too short, only $len_temp nucc, be carreful!\n\n";
}
close IN;
close OUT;

print"\nTrimming of $ARGV[0] done!\n";
print"The trimming  started at position $start and finished at position $length, ";
print"for a total of $stop nucleotides/amino acids\n\n";
################################################################################################
### Analyse sequences for the presence of "N" ###

open (OUT2,">$ARGV[4]") or die "error $!";
foreach my $k(sort{$a cmp $b} keys(%hseq)){
      my $value=$hseq{$k};
      my $len=length($value);
      print OUT2"$k\tsequence length: $len";
      if($value =~m/[Nn]+/g){
            print OUT2"\tcontains some undeterminded character(s)\n";
      }
      else{print OUT2 "\tSequence ready for next step\n";}
}
print OUT2"\n\tCheck the chromatogramm and edit the fasta file in Seaview!\n\n"; 


