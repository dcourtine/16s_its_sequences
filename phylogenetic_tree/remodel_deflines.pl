#!/opt/local/bin/perl
use strict;
use warnings;

if($#ARGV ne 0){
	print"usage: perl $0 <fasta-file-with-metadata>\n";
	die;
}

open(IN, "$ARGV[0]") or die "erreur $!";
my $outfile = $ARGV[0];
$outfile =~s/.+\///;
$outfile =~s/\.fasta//;
$outfile = $outfile."-ARB-defline.fasta";
open(OUT, ">$outfile") or die "error $!";

my $specCount = 100;
while(<IN>){
	chomp;
	my $defline = "";
	if(substr($_, 0, 1) eq ">"){
		my @t = split('\|', $_);
		$defline = $t[0];
		# geography
		if(defined $t[1]){
			if($t[1] ne ""){
				$defline = $defline.":$t[1]";
			}
			else{
				$defline = $defline.":NA";
			}
		}
		else{
			$defline = $defline.":NA";
		}
		#hydrothermal site
		if(defined $t[2]){
			if($t[2] ne ""){
				$defline = $defline.":$t[2]";
				$defline =~s/°/'/g;
			}
			else{
				$defline = $defline.":NA";
			}
		}
		else{$defline = $defline.":NA";}
		# arb id
		$defline = $defline.":NA:spec$specCount";
		$specCount++;
		print OUT "$defline\n";
	}
	else{print OUT "$_\n";}
}
close IN;
close OUT;



