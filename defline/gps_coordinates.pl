#!/usr/bin/perl

use strict;
use warnings;

my $degree_lat="";
my $minute_lat="";
my $second_lat="";
my $dd_lat="";
my $sign_lat="";

my $degree_long="";
my $minute_long="";
my $second_long="";
my $dd_long="";
my $sign_long="";

open(IN, "souchotheque-16S_ITS-new-deflines.fasta") or die "erreur $!";
open(OUT, ">souchotheque_gps_coordinates.csv") or die "erreur $!";
print OUT"Strain,Latitude,Longitude\n";
while(<IN>){
      chomp;
      $degree_lat="";
      $minute_lat="";
      $second_lat="";
      $dd_lat="";
      $sign_lat="";
      
      $degree_long="";
      $minute_long="";
      $second_long="";
      $dd_long="";
      $sign_long="";


      if(substr($_,0,1) eq ">"){
            $_.="END";
            my @temp = split('\|', $_);
            $temp[0]=~s/\>//;
            if($temp[9]eq "" or $temp[10]eq ""){
                  $temp[9]="NA";
                  $temp[10]="NA";
            }
            else{
                        ##########

                  #my @temp1=split("°",$temp[9]);
                  #print"$temp1[0]\n";
                  $temp[9]=~s/\s//g;
                  $temp[9]=~s/°/;/g;
                  $temp[9]=~s/'/;/g;
                  $temp[9]=~s/"/;/g;
                  my @split=split(";",$temp[9]);
                  $degree_lat=$split[0];
                  $minute_lat=$split[1];
                  $second_lat=$split[2];
                  $sign_lat=$split[3];
                  
                        ##########
                  $dd_lat.=$degree_lat;
                  $minute_lat=$minute_lat/60;
                  $minute_lat=sprintf"%.2f", $minute_lat;
                  $dd_lat+=$minute_lat;
                  $second_lat=$second_lat/3600;
                  $second_lat=sprintf"%.4f", $second_lat;
                  $dd_lat+=$second_lat;
                  if($sign_lat eq "N"){
                       $dd_lat="+".$dd_lat; 
                  }
                  elsif($sign_lat eq "S"){
                       $dd_lat="-".$dd_lat; 
                  }
                        ##########
                  $temp[10]=~s/\s//g;
                  $temp[10]=~s/°/;/g;
                  $temp[10]=~s/'/;/g;
                  $temp[10]=~s/"/;/g;
                  my @split2=split(";",$temp[10]);
                  $degree_long=$split2[0];
                  $minute_long=$split2[1];
                  $second_long=$split2[2];
                  $sign_long=$split2[3];
                  
                        ##########
                  $dd_long.=$degree_long;
                  $minute_long=$minute_long/60;
                  $minute_long=sprintf"%.2f", $minute_long;
                  $dd_long+=$minute_long;
                  $second_long=$second_long/3600;
                  $second_long=sprintf"%.4f", $second_long;
                  $dd_long+=$second_long;
                  if($sign_long eq "E"){
                       $dd_long="+".$dd_long; 
                  }
                  elsif($sign_long eq "W"){
                       $dd_long="-".$dd_long; 
                  }

#                  print"$temp[9]\t $dd_lat\n";
#                  print"$temp[10]\t $dd_long\n\n";

                  
                  print OUT "$temp[0],$dd_lat,$dd_long\n";
            }    
      }
}
close IN;
close OUT;

#     12° 49' 51" N
#
#     N==>+
#     S==>-

#     E==>+
#     W==>-
#
#     Then to convert from a degrees minutes seconds format to a decimal degrees format, one may use the formula

#     decimal degrees = degrees + minutes/60 + seconds/3600. 
#
#
#
#
#
#
