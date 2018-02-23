#!/usr/bin/perl
use strict;
use warnings;

#     This script clean the input sequence of the "n"
#     and return a fasta file with some IUPAC nucleotides
#     Moreover, it point the possible error in the sequence
#     due to consambig (EMBOSS) programm
#

####################################################
if (@ARGV != 3){
	print "\nUsage: $0 <infile: consambig result> <Outfile: fasta format> <list of failed character>\n\n";
	print "the Outfile will be the sequence of the 16S-ITS of the strain\n";
	print "Without the \"N\" characters due to consambig programm that put\n\n";
	print "an undefined character when it find a dot for each line in the alignment file.\n\n";
	die;
}
####################################################

open (IN, "$ARGV[0]") or die "error $!";
open (OUT,">$ARGV[1]") or die "error $!";
open(OUTERR,">$ARGV[2]") or die "error $!";

my $seq="";
my @tseq;

while(<IN>){
      chomp;
      if(substr ($_, 0,1) eq ">") {
		push(@tseq,$_);
	}
	else {
		$seq = $seq.$_;
	}
}
push(@tseq, $seq);
close IN;

for(my $i=0;$i<=$#tseq;$i++){
      #print "$tseq[$i]\n\n";
      if($i==1){
            $tseq[$i]=~s/[nN]//g;
      }
}
print OUT "$tseq[0]\n";
print OUTERR "$tseq[0]\n";

my $IUPAC="";
my $lowerChar="";
my $lengthSeq=length($tseq[1]);
my $posC=0;
my $countlines=2; #set the firt line that can be taken into account 

while($posC<$lengthSeq){
      my $substring=substr($tseq[1],$posC,60);
      print OUT "$substring\n";
      $posC=$posC+60;
      if($substring=~m/[ATCG]+[atcg]+[ATCG]+/g){      #MIDDLE of the line
            print OUTERR "$substring\tline $countlines\t\"MIDDLE\"\n";
      }
      if($substring=~m/[ATCG]+[atcg]+/g){              #at the END of the line
            print OUTERR "$substring\tline $countlines\t\"END\"\n";
      }      
      if($substring=~m/^[atcg]+[ATCG]+/g){              #at the BEGINNING of the line
            print OUTERR "$substring\tline $countlines\t\"BEGINNING\"\n";
      }       
      if ($substring=~m/[RYSWKMBDHVryswkmbdhv]+/g){      #IUPAC error
            print OUTERR "$substring\tline $countlines\tIUPAC error\n";
      }
      $countlines++;
}
close OUT;      
close OUTERR;
