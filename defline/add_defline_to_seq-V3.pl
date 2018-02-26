#!/usr/bin/perl

use strict;
use warnings;

#This script will add some parameters in the defline of a sequence in a fasta format


##############################################################################
########     Read the first CSV file   ########

my %csv1;               #key=strain name; Values=array of the rest of the line
my %seq2sampleCode;     #key=strain name with longer defline; Value= "origin_sample_code"

open (CSV1, "metadonnees_thermocc_final-feuille1.csv") or die "erreur $!";
while(<CSV1>){
      chomp;

      #print"$_\nvoid line\n";
     
      if($_=~m/^[1234567890]{4};.+/){     #match all lines except the description one.
            my @temp=split(";",$_);       #==> each strain has a 4-digits code
            $temp[1]=~s/\s//g;            #Remove all spaces in name of strains
            my @newArray;
            for(my $i=0;$i<=$#temp;$i++){
                  if($temp[$i]eq""){
                        $temp[$i]="$i=void";
                  }
                  push(@newArray, $temp[$i]);
            }
            $csv1{$temp[1]}=\@newArray;   #put the reference of the array in the Hash table
            
            #print"@newArray\n\n";
            #print"$temp[19]\n";
      }
}
close CSV1;

foreach my $k (keys(%csv1)){        #Browse the first Hash in order to get the first part of the new sequence name
      my @myArray=@{$csv1{$k}};     #Retrive the array associated before to this key 
      #print"$k\n@myArray\n\n";
      my $newKey=">".$k."|";
      $myArray[16]=~s/\s/\//;       #Replace the space by a slash in "g l-1"
      $myArray[16]=~s/l/L/;         #upper case the "l" in "g l-1"
      $myArray[16]=~s/-1//;       #remove the "-1" ing l-1"

            #Add defined fields to the sequence defline
      $newKey=$newKey.$myArray[3]."|".$myArray[4]."|".$myArray[5]."|".$myArray[8]."|".$myArray[13]."|".$myArray[14]."|".$myArray[15]."|".$myArray[16]." ".$myArray[17]."|"; #Add a pipe between 15 & 16==> 15: salinity; 16-17: salinity unit;
      $newKey=~s/\d{1,2}=void//g;    #Replace, for example, "4=void" by "" in the defline. This notation was a help for earlier int he script
      #print"$newKey\n";
      $seq2sampleCode{$newKey}=$myArray[7];     #put the new seq name and the sample code associated into a Hash table     
}

##############################################################################
########     Read the second CSV file   ########


my %csv2;               #key=origin_sample_code; Values=array of the rest of the line

open (CSV2, "metadonnees_thermocc_final-feuille2-V2.csv") or die "erreur $!";
while(<CSV2>){
      chomp;
      if(substr($_,0,11) ne "sample_code"){     #Match all lines except the description line (the first)
            my @temp2=split(";",$_);       #==> each strain has a 4-digits code
            my @newArray2;
            for(my $i=0;$i<=$#temp2;$i++){
                  if($temp2[$i]eq""){
                        $temp2[$i]="$i=void";
                  }
                  push(@newArray2, $temp2[$i]);
            }
            $csv2{$temp2[0]}=\@newArray2;        #put the reference of the array in the hash
      }
}
close CSV2;

foreach my $k (keys(%csv2)){        #Browse the first Hash in order to get the first part of the new sequence name
      my @myArray2=@{$csv2{$k}};     #Retrive the array associated before to this key 
      #print"$k\n@myArray2\n\n";
}

##############################################################################
########     Write the final defline for each sequence   ########

my %finalStrainName;    #key: strain name; Value: final defline for the strain

open(OUT,">complete_defline_Thermococale_culture_collection.txt") or die "erreur $!";
print OUT"Strain_name|origin_geographic_area|origin_locality|origin_habitat|origin_sample_date|temperature|ph|salinity|salinity_unit|latitude|longitude|depth|\n";

foreach my $k (keys (%seq2sampleCode)){
#      print"$k\n$seq2sampleCode{$k}\n\n";
      my $valueC=$seq2sampleCode{$k};     #Contain the origin_sample_code
      my $newKey2=$k;
      
      if($valueC =~m/\d{1,2}=void/){
            $newKey2=$newKey2."|||";
            print OUT "$newKey2\n";
            
            
            my $tempKey=$newKey2;
            $tempKey=~s/\|/::/g;          #Replace pipes by double double dots, pipes cause error in split function
            my @name= split("::", $tempKey);
            $finalStrainName{$name[0]}=$newKey2;

      }
      else{
            my @myArray2=@{$csv2{$valueC}};     #Contain all parameters of the current origin_sample_code
            #print"$k\torigin_sample_code: $valueC\n@myArray2\n\n";
            if($myArray2[13] ne "13=void"){
       #          $myArray2[13]=" ".$myArray2[13];    #add a space before "N|S"
                  $myArray2[13]=$myArray2[13];

            }
            if($myArray2[16] ne "16=void"){
       #          $myArray2[16]=" ".$myArray2[16];    #add a space before "E|W"
                  $myArray2[16]=$myArray2[16];

            }
            if($myArray2[12]=~m/(\d+),\d+/){    #transform latitude minutes-decimal to minute-seconds
                  $myArray2[12]=$1;
            }
            if($myArray2[15]=~m/(\d+),\d+/){    #transform longitude minutes-decimal to minute-seconds
                  $myArray2[15]=$1;
            }
            
            if($myArray2[12] ne "12=void" and $myArray2[15] ne "15=void"){
                  $newKey2=$newKey2.$myArray2[11]."°".$myArray2[12]."'".$myArray2[25]."\"".$myArray2[13]."|".$myArray2[14]."°".$myArray2[15]."'".$myArray2[27]."\"".$myArray2[16]."|".$myArray2[20]."|";
            }
            
            elsif($myArray2[12] eq "12=void" and $myArray2[15] eq "15=void" and $myArray2[14] ne "14=void"){
                  $newKey2=$newKey2.$myArray2[11]."°0'0\"".$myArray2[13]."|".$myArray2[14]."°0'0\"".$myArray2[16]."|".$myArray2[20]."|";
            }
            
            elsif($myArray2[11] ne "11=void"){
                  if($myArray2[12] eq "12=void"){
                        if($myArray2[14] eq "14=void"){
                              if($myArray2[15] eq "15=void"){
                                    $newKey2=$newKey2.$myArray2[11]."°0'0\"".$myArray2[13]."||".$myArray2[20]."|";
                              }
                        }
                  }
            }
            elsif($myArray2[11] eq "11=void" and $myArray2[14] eq "14=void"){
                  $newKey2=$newKey2."||".$myArray2[20]."|";
            }
                        
#            $newKey2=$newKey2.$myArray2[11]."°".$myArray2[12].$myArray2[13]."|".$myArray2[14]."°".$myArray2[15].$myArray2[16]."|".$myArray2[20]."|";
            $newKey2=~s/\d{1,2}=void//g;
            $newKey2=~s/°\|/\|/g;     #Remove "°" character if it is alone with a pipe as following character
            $newKey2=~s/\s/-/g;
            print OUT "$newKey2\n";
            
            my $tempKey=$newKey2;
            $tempKey=~s/\|/::/g;
            my @name= split("::", $tempKey);
            $finalStrainName{$name[0]}=$newKey2;

      }
}
close OUT;

##############################################################################
########     Write the final fasta file, with update defilnes  ########

my %hseq;   #key: strain name; Value: 16S-ITS nucleotide sequence
my $seq="";
my $nom="";

open(FASTA,">souchotheque-16S_ITS-new-deflines.fasta") or die "erreur $!";
open(IN,"souchotheque-16S_ITS.fasta") or die "erreur $!";
while(<IN>){
      chomp;
      if (substr ($_, 0,1) eq ">") {
            if ($seq ne "") {
		      $hseq{$nom}=$seq;	#joining strain name and sequence
		}
		my @nomc=split("_",$_);
		$nom = $nomc[0];		#
		$seq="";	        #reset variable containing sequence
	}
	else {
		$seq = $seq.$_;
	}
}
$hseq{$nom} = $seq;
close IN;

my %NewFinalStrainName;       #Like %finalStrainName, but keys are all in uppercase

##################################################
foreach my $k(keys(%finalStrainName)){
      #print"$k\n$finalStrainName{$k}\n\n";

      my $newK=uc $k;                     #Upper Case of all keys
      $NewFinalStrainName{$newK}=$finalStrainName{$k};  
}

##################################################

foreach my $k (keys(%NewFinalStrainName)){
      #print"$k\n$NewFinalStrainName{$k}\n\n";
}
##################################################

foreach my $k(keys(%hseq)){

      #print"$k\n$hseq{$k}\n\n";

      if(defined($NewFinalStrainName{$k})){
            print FASTA"$NewFinalStrainName{$k}\n$hseq{$k}\n";
      }
      else{
            print FASTA "$k||||||||||||\n$hseq{$k}\n";
      }   
}
close FASTA
