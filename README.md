# 16s_its_sequences
This directory summarize the framework used to sequence, check and assemble 16SrRNA-ITS sequences.
Different assembly where performed. One for each seqeuncing batch.

## Table of content
1. [Description of the data used](#description)
2. [Primer list](#primer)
3. [Assembly strategy](#assembly)

## Description of the data used <a name="description"></a>
### List of the different sequencing invoices
0. Nolwen's data
1. December 2014
2. March 2015
3. June 2015
4. July 2015

**Note: For each invoice, _DeliveryForm_ and _productionSheet_ are present in a directory** `documents` **next to the raw data.** 

#### Nolwen's data
I recovered only the sequences provided by Beckman Coulter Genomics, in Fasta format.
Eletropherogram are not available for these 96 strains sequenced with A8F and A1492R primers.

PATH to data: `data/2014/06-2014_nolwen_leost`

#### December 2014
Few months after the start of my thesis, I first finish 16S sequences produced by Nolwen Leost during her intership \(DUT, from April to June 2014\).
I had sequencing runs produced with primers A8F and A1492R on 96 _Thermococcales_ strains in theory.
Due to assembly failure with those 2 runs, I used a new sequencing run with the primer A958R to assemble the full 16S sequence. 

PATH to data: `data/2014/A958R_09-12-2014/COL14-0X1K`

#### March 2015
This sequencing run dealt with 96 strains and the A71R primer.
Strains was the one sequenced by Nolwen (A8F - A1492R) and Damien (A958R)

PATH to data: `data/2015/A71R_13-03-2015/COL15-15FG`

##### Note about these data (December 2014 / March 2015)
The majority of strains were sequenced with the 4 primers, but it was not the case for some of them.
The table bellow summarize the differences between these 4 sequencing runs

Strain |A8F | A1492R | A958R | A71R | Remark
-------|----|--------|-------|------|-------
AMTc06 | sequenced | sequenced | NA | NA | Not present in UBOCC
AMTc57 |NA | NA | sequenced | sequenced| 
AMTc70 |NA | NA | sequenced | sequenced | 
AMTc101 | sequenced | sequenced | NA | NA |
IRI01c | sequenced | sequenced | NA | NA |
IRI09c |NA | NA | sequenced | sequenced |
IRI19c | sequenced | sequenced | NA | NA |
IRI21c |NA | NA | sequenced | sequenced |
IRI30c | sequenced | sequenced | NA | NA |
IRI31b |NA | NA | sequenced | sequenced |

#### June 2015
Here, after the Amaia's intership (April-June 2015), 219 \(2 \* 96 + 27\) strains were sequenced with A4F, A1492R and A71R primers.
The sequencing plates are:
	* 16S\_ITS\_1
	* 16S\_ITS\_2
	* 16S\_ITS\_3

Some failure appeared for the A4F and A1492R primers.
Many sequences failed with the A71R primer.

PATH to data: `data/2015/3_primers_23-06-2015_stage_Amaia/16S_ITS_?`

#### July 2016

Here, it is the re-sequencing of the runs that failed in June 2016.
I did a test on 8 strains with the primer A71R\_MOD,  present in `data/2015/3_primers_27-07-2015/test-primer-A71R-modifiee`

Two primers were modified: A4F by A4F\_Thermocc, and A71R by A71R\_MOD
Number of re-sequencing for each primer and plate:

Plate | A4F\_Thermocc | A1492R | A71R\_MOD |
------|:-------------:|:------:|:---------:|
16S\_ITS\_1 | 7 | 7 | 88 |
16S\_ITS\_3 | 6 | 3 | 96 |
A6S\_ITS\_3 | \- | \- | 25 |

PATH to data: `data/2015/3_primers_27-07-2015/COL15-1HVS`

## Primer list<a name="primer"></a>
* A4F: _5'-TCC GGT TGA TCC TGC CRC-3'_
* A4F\_Thermocc: _5'-TCC GGT TGA TCC TGC CGC-3'_
* A8F: _5'-TCC GGT TGA TCC TGC C-3'_
* A958R: _5'-YCC GGC GTT GAM TCC AAT T-3'_ 
* A1492R: _5'-GGC TAC CTT GTT ACG ACT T-3'_
* A71R: _5'-TCG GYG CCC GAG CCG AGC CAC CC-3'_
* A71R\_MOD: _5'-TCG GYG CCC GAG CCG AGC CA-3'_

## Assembly strategy <a name="assembly"></a>
### First batch of strains
Here I will present the the assembly of the strains sequenced by Nowlven and the my 2 additionnal sequencing runs.

1. For each run, we need the files `MultiFasta_*.seq`.

And copy them in the working directory:
```bash
cd assemblies/01_first_batch_of_seq/
cp ../../data/2014/06-2014_nolwen_leost/MultiFasta_140620.seq MultiFasta_A8F.seq
cp ../../data/2014/A958R_09-12-2014/MultiFasta_141211.seq MultiFasta_A958R.seq
cp ../../data/2015/A71R_13-03-2015/MultiFasta_150318.seq MultiFasta_A71R.seq

cp MultiFasta_A8F.seq MultiFasta_A1492R.seq
```
With a text editor, keep A8F reads in `MultiFasta_A8F.seq` file and keep A1492R in `MultiFasta_A1492R.seq` file.

2. Important, ensure that all strains have the same name.

For example: `AMTC-01_A71R_1` *vs.* `AMTC01_A8F_1` *vs.* `AMTC_01_A958R_1`.
Here I kept the annotation `AMTC01_`. It is important to use `_` between strain and primer IDs. 

3. Recover the name of each strain in the 4 files
```bash
for file in Multifasta*
do
	grep ">" $file >grep.$file
done
```
4. Recover a simplify version of each strain name
```bash
for file in grep.Multifasta*
do
	perl simplify_name.pl $file
done
```
This script will output a symplify version of the defline for each strain in a particular primer file.

Before, in `grep.MultiFasta_A8F.seq`:
```
>AMTC01_A8F_1 status=passed nucl=551 crlStart=20 crlStop=551 crlLen=532 order=COL14-0E54
>AMTC02_A8F_2 status=Passed nucl=1237 crlStart=17 crlStop=759 crlLen=743 order=COL14-0E54
```
After, in `simplify.grep.MultiFasta_A8F.seq`
```
>AMTC01
>AMTC02
```
5. Compare the 4 primer files

The aim at this step is to find strains that were sequenced with the 4 primers.
If a seqeucing failed for one or more primer, the strain is discarded.

Run the script: `perl compare_4_files.pl`
It read files present in `ls simplify.*` --> it used to be A1492R, then A71R, then A8F and A958R.
Then the script check that a strain is present in the four primer files.
Then it read `Multifasta_*.seq`, extract the "good" reads \(= strains with 4 reads\),
and write then out in `MultiFasta_*.seq.final`.

**Note**: in the four files `MultiFasta_*.seq.final`, reads are present in the same order.

**Note 2**: the script had a small bug, that duplicated the AMTC10 sequence.

I fixed it in this current version.

6. Trimm sequences + Reverse complement

RC has to be applied only on *A1492R*, *A958R* and *A71R* reads.

This step is done with a Perl and a Bash script.
First, the script `trimm_and_RC_seq.sh` take `*.seq.final` and trim each sequences between 2 positions.
To modify these positions, just do it in the `trimm_and_RC_seq` script.
The output is a new fasta file with a `trimm<upper_threshold>` extention.
After, the script **Reverse and Completent** all reads present in `R.seq.final.trimm<upper_threshold>`

**Note:** This step is done with `revseq`, a tool from the [EMBOSS:6.5.7.0 package](http://emboss.sourceforge.net/).

The output of this tool is new fasta file: `trimm<upper_threshold.RC>`, with 60 nuccleotides displayed per line.

7. Group all reads belonging to a strain in a single file

First, create a new directory: `mkdir seq_to_align`
Then run the Perl script `perl create_seq_to_align.pl <upper_threshold>`

**Be carreful to the infile names used within this Perl script.**

8. Read alignment

This section required the file `16S-ITS-thermococcales-publies.txt`, present in the working dir.
It is a regular Fasta file containing the 16SrRNA-ITS sequences of 11 *Thermococcus*,
extracted from public complete genomes, and the *tRNA-Ala* from *Thermococcus kodakaraensis*.

Here, the tool [Muscle v3.8.31](http://www.drive5.com/muscle/) is employed to align reads
with the help of the 12 *Thermococcus* sequences.

To run the script: `bash align.sh`. 
**Please CHECK all dir & file paths before running the script.**
The script make a copy of the alignement as `seq_to_align/<strainID>.complete.msf.save`



 



