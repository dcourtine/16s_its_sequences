# 16s_its_sequences
This directory summarize the framework used to sequence, check and assemble 16SrRNA-ITS sequences.
Different assembly where performed. One for each seqeuncing batch.

## Table of content
1. [Description of the data used](#description)
2. [Primer list](#primer)
3. [Assembly strategies](#assembly)
	1. [First batch of strains](#batch1)
	2. [Second batch of strains](#batch2)
		1. [16S_ITS_1 - only 16S](#batch2-1-1)
		2. [16S_ITS_1 - Add ITS](#batch2-1-2)
		3. [16S_ITS_2](#batch2-2)
		4. [16S_ITS_3](#batch2-3)
4. [Add metadata to defline](#defline)
5. [Plot strains origins of map](#printOnMap)
6. [16SrRNA and ITS phylogenetic tree](#phyloTree)

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

#### July 2015

Here, it is the re-sequencing of the runs that failed in June 2016.
I did a test on 8 strains with the primer A71R\_MOD,  present in `data/2015/3_primers_27-07-2015/test-primer-A71R-modifiee`

Two primers were modified: A4F by A4F\_Thermocc, and A71R by A71R\_MOD
Number of re-sequencing for each primer and plate:

Plate | A4F\_Thermocc | A1492R | A71R\_MOD |
------|:-------------:|:------:|:---------:|
16S\_ITS\_1 | 7 | 7 | 88 |
16S\_ITS\_2 | 6 | 3 | 96 |
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

## Assembly strategies <a name="assembly"></a>
### First batch of strains <a name="batch1"></a>
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

**Note**: In the four files `MultiFasta_*.seq.final`, reads are present in the same order.

**Note 2:** The script had a small bug, that duplicated the AMTC10 sequence.

**Note 3:** I fixed it in this current version.

6. Trimm sequences + Reverse complement

RC has to be applied only on *A1492R*, *A958R* and *A71R* reads.

This step is done with a Perl and a Bash script.
First, the script `trimm_and_RC_seq.sh` take `*.seq.final` and trim each sequences between 2 positions.
To modify these positions, just do it in the `trimm_and_RC_seq.sh` script.
The output is a new fasta file with a `trimm<upper_threshold>` extention.
After, the script **reverse and completent** all reads present in `*R.seq.final.trimm<upper_threshold>`

**Note:** This step is done with `revseq`, a tool from the [EMBOSS:6.5.7.0 package](http://emboss.sourceforge.net/).

The output of this tool is new fasta file: `trimm<upper_threshold.RC>`, with 60 nuccleotides displayed per line.

7. Group all reads belonging to a strain in a single file

First, create a new directory: `mkdir seq_to_align`
Then run the Perl script `perl create_seq_to_align.pl <upper_threshold>`
**Be carreful to the infile names used within this Perl script.**

8. Read alignment

This section required the file `16S-ITS-thermococcales-publies.txt`, present in the working dir.
It is a regular Fasta file containing the 16SrRNA-ITS sequences of 10 *Thermococcus*,
extracted from public complete genomes, and the *tRNA-Ala* from *Thermococcus kodakaraensis*.
(I removed the *Thermococcus barophilus* sequence.)
Here, the tool [Muscle v3.8.31](http://www.drive5.com/muscle/) is employed to align reads
with the help of the 11 *Thermococcus* sequences.

To run the script: `bash align.sh`. 
**Please CHECK all dirs & files paths before running the script.**
The script make a copy of the alignement as `seq_to_align/<strainID>.complete.msf.save`

9. Quality check

For this step, the principle is simple:
* Open the file `<strain>.complete.msf` in a sequence browser like [Seaview](http://doua.prabi.fr/software/seaview).
* Order sequences in the "descending" order:
	* 16S-ITS from complete genomes
	* then tRNA-Ala
	* then reads
		* A4F
		* A958R
		* A1492R
		* A71R
* Browse the alignment to resolve conficts in reads overlapping regions
* To raise a confict, you have to search the position in the electropherogram
* To open such file on MacOS, I used [4Peaks v1.8](https://nucleobytes.com/4peaks/index.html). 
* I correct errors directly in the alignment
* When all errors are resolved, I keep only the 4 reads in the alignment (Select all 16S-ITS + tRNA-Ala ==> Edit/Delete seq.)
* I Delete all gap-only sites ==> Edit/Del. gap-only sites
* Then, select the 4 reads and ==> Edit/Concensus sequence
* I delete the 4 reads, rename the consensus and save the result as Fasta file


### Second batch of strains <a name="batch2"></a>
In this section, I will describe the assembly process employ to reconstruct 16SrRNA-ITS sequences
for strains sequenced in June 2015.

Like the primer *A71R* failed for many strains, I first assembly *A4F* and *A1492R* reads together.

#### First plate: 16S_ITS_1
##### Assemble 16S <a name="batch2-1-1"></a>
Here, 96 strains are concerned.
First move to the correct directory and add directory and data:
```
cd assemblies/02_second_batch_of_seq/16S_ITS_1/
mkdir 01_16S_only
cp ../../../../data/2015/3_primers_23-06-2015_stage_Amaia/16S_ITS_1/COL15-1F0J_TRUE_data/MultiFasta_16S_ITS_1-A1492R.fasta .
cp ../../../../data/2015/3_primers_23-06-2015_stage_Amaia/16S_ITS_1/COL15-1F0J_TRUE_data/MultiFasta_16S_ITS_1-A4F.fasta .
```

1. Simplify names

Run the Bash script: `bash 1-1_simplify_name-16S-only.sh`. This script will run the Perl script `1-2_simplify_name-16S-only.pl`.

2. Compare the 2 Multifasta files to highlight missing reads

Run the Perl script `perl 2-1_compare_2_files-16S-only.pl`, then check the number of strains present in each file:
`bash ./2-2_copy_file-16S-only.sh`. This script copies `MultiFasta*.final` in `MultiFasta*.final.corrected`.

3. Trimming and Reverse Complement

This step is done with 2 Bash/Perl scripts. Simply run `bash 3-1_trimm_and_RC_seq-16S-only.sh`.
Modify the *trimming threshold* directly within the Bash script.

The script output warnings for too short reads and output a logfile: `MultiFasta*.final.corrected.trimm<threshold>.log`.
The logfile points reads whith undetermined nucleotides \( \!\[ATGCatgc\]\).

**Here, lot of fails for both *A4F* and *A1492R* reads...**

4. Merge reads

Run `Perl 4-create_seq_to_align-16S-only.pl <trimming cutoff>`
All files will be output in the directory `All_fasta_aligned/`.

5. Align reads

This is done with Muscle (same as above). The script `5-align-16S-only.sh` concatenate 16S-ITS sequences (11)
of complete genomes + tRNA-Ala with the 2 reads for each strain.
Then MUSCLE to align these sequences, with the "help" of full 16S-ITS sequences.
And the script make a copy of the alignment file: `*.fasta.msf` in `*.fasta.msf.save`.

**Important**: Manual check of each alignment to highlight any "N" that can be still present on reads 
( = that was not removed with the trimming step).

6. Quality check

At this step, the "pipeline" differ from what was done in "batch 1 quality check".

This parts involve 3 scripts:
1. `6-1-consambig-16S-only.sh`
2. `6-2-keep-primer-16S-only.pl`
3. `6-3-clear_consambig-16S-only.pl`

The first is used to runs the 2 Perl scripts. They work as follow: "6-2" take a `msf`file as input
(ex: `E14D5.fasta.complete.msf`) and output an alignment file in msf format too, but **with only the 2 reads A4F and A1492R**.
The output file has a `*.keepprimer` extension.

Then the Bash script make a copy of the `*.keepprimer` in `*.keepprimer.corrected`.

Then I use the **consambig** tool from the EMBOSS package. It outputs a file `*.keepprimer.consambig`.

Then bash script runs the Perl script "6-3...". This Perl script use the `*.keepprimer.consambig` as input.
The output is a fasta file file the consensus sequence `*.keepprimer.consambig.fasta` and an error file `*.keepprimer.consambig.err`.
This "log" file points beginning & end of the overlapping section (upper case, while non overlapping = lowercase),
and also points IUPAC characters different than [ATGCatcg].
**\!\!\!** Files `*.keepprimer.consambig.fasta` are **wrong** fasta

Then run the following lines of code:
```bash
mkdir -p All_fasta_aligned/All_keepprimer_corrected/All_fasta_finished
mv All_fasta_aligned/*.keepprimer.corrected All_fasta_aligned/All_keepprimer_corrected
cd All_fasta_aligned/All_keepprimer_corrected
ls | cut -d "." -f 1 >liste_keepprimer_corrected.txt
#make sure that this file, liste_keepprimer_corrected.txt has a strain ID in the last line
#tail liste_keepprimer_corrected.txt
```
**Important:** manual curation of each alignment, to **resolve** overlapping errors.
Use the electropherograms to currate alignment!!. Do it with *SeavieW* and *4Peaks*.
Before closing, `Edit/del. gap-only sites`, and save it.

7. Generate the fasta file

First, come back to the "homedir": `cd ../..`. 
Use the Bash script `7-cons.sh`, that uses the `cons` tool from the EMBOSS package.

In the script, there is a step with a grep that highlight remaining "N" in the final fasta file.
It is important to note in a file *strains ID* in a text file and remove all file belonging to this strains 
and keep in a separated directory the file with their reads: `All_fasta_aligned/<strainID>.fasta`.

Example of script to do it, assuming that strains ID are in the file `failed_strains.txt`:
```bash 
#Create the directory
if [ ! -d "All_fasta_aligned/Failed_sequences" ]; then
	mkdir All_fasta_aligned/Failed_sequences
fi

#loop over the file with strain ID
while read line
do
	mv All_fasta_aligned/${line}.fasta All_fasta_aligned/Failed_sequences
	rm All_fasta_aligned/${line}.fasta.comple*
	rm All_fasta_aligned/All_fasta_finished/${line}.*
	rm All_fasta_aligned/All_fasta_finished/All_fasta_finished/${line}-16S.fasta
done<failed_strains.txt
```

8. Failed strains for 16S alignment:

* E10P10
* E10P11
* E10P13
* E14D3
* E14P22
* E15D17
* E15D24

##### Assemble ITS to the 16S <a name="batch2-1-2"></a>

In this section, I will merge 16S sequence and its corresponding ITS.
Come back to the root of this project, then `cd assemblies/02_second_batch_of_seq/16S_ITS_1/02_16S_ITS`.

Sequences of *A71R* primers comme from June and July 2015: `COL15-1HME`==> 8 sequences; `COL15-1HVS` ==> 88 reads.
Respectivelly present in `data/2015/3_primers_27-07-2015/test-primer-A71R-modifiee/COL15-1HME`
(for strains *E12D9, E12D10, E12D13, E13P1, E13P2, E13P3, E13P4 and E13P5*) 
and  `data/2015/3_primers_27-07-2015/COL15-1HVS/16S_ITS_1_A71R2` for the 88 other strains.

Concatenate all good reads in `MultiFasta_COL15-1HME_AND_COL15-1HVS.seq`.

Run:
```bash
perl 0_split_mother_file.pl MultiFasta_COL15-1HME_AND_COL15-1HVS.seq
bash 1-1_simplify_name.sh
bash 2-2_copy_file.sh
bash 3-1_trimm_and_RC_seq.sh
cat ../01_16S_only/All_fasta_aligned/All_keepprimer_corrected/All_fasta_finished/*-16S.fasta >16S_ITS_1-16Sonly.fasta
mkdir All_fasta_aligned
perl 4-create_seq_to_align.pl <trimming cutoff> 16S_ITS_1-16Sonly.fasta
bash 5-align.sh
bash 6-1-consambig.sh
mkdir All_fasta_aligned/All_keepprimer_corrected
mv All_fasta_aligned/*.corrected All_fasta_aligned/All_keepprimer_corrected/
```
Then browse all alignment in `All_fasta_aligned/All_keepprimer_corrected/*.corrected` to resolve overlapping conflicts.
Use the `All_fasta_aligned/*.err` as a guide and also eletropherograms.
In Seaview, `Edit/del. gap-only sites` and save the alignment.

Then:
```bash
cd All_fasta_aligned/All_keepprimer_corrected
ls | cut -d "." -f 1 >liste_keepprimer_corrected.txt
#make sure that this file, liste_keepprimer_corrected.txt has a strain ID in the last line
#tail liste_keepprimer_corrected.txt
cd ../..
bash 7-cons.sh
```

Then establish a list of failed strains.
```bash
if [ ! -d "All_fasta_aligned/Failed_sequences" ]; then
	mkdir All_fasta_aligned/Failed_sequences
fi
#loop over the file with strain ID
while read line
do
	mv All_fasta_aligned/${line}.fasta All_fasta_aligned/Failed_sequences
	rm All_fasta_aligned/${line}.fasta.comple*
	rm All_fasta_aligned/All_keepprimer_corrected/${line}.*
	rm All_fasta_aligned/All_keepprimer_corrected/All_fasta_finished/${line}-*.fasta
done<failed_strains.txt
```

**For the "failed" runs, do it one by one for each strain.**

##### Failed strains
Concerning failed strains, resequencing were done 


#### Second plate: 16S_ITS_2 <a name="batch2-2"></a>

Data are present in 5 directories:
* `data/2015/3_primers_23-06-2015_stage_Amaia/16S_ITS_2/COL15-1F0E/16S_ITS_2_A1492` : **A1492R**
* `data/2015/3_primers_27-07-2015/COL15-1HVS/16S_ITS_2_14922` : **A1492R**, resequencing of failed strains
* `data/2015/3_primers_23-06-2015_stage_Amaia/16S_ITS_2/COL15-1F0E/16S_ITS_2_A4F` : **A4F**
* `data/2015/3_primers_27-07-2015/COL15-1HVS/16S_ITS_2_A4F2` : **A4F_Thermocc**, resequencing of failed strains
* `data/2015/3_primers_27-07-2015/COL15-1HVS/16S_ITS_2_A71R2` : **A71R_MOD**

**Here the pipeline used is the same as for the first batch of sequences**, available [here](#batch1).
Scripts are present in `cd assemblies/02_second_batch_of_seq/16S_ITS_2`.
First, `cat ../../../<ABOVE-PATHS>/*.seq >MultiFasta-A71R.fasta`.
Then, `bash 1-1_simplify_name.sh`. Then `perl 2-1_compare_3_files.pl` ==> **here be carrefull of infiles names!**,
modify lines \#83, 113, 129, 160, 172, 204, 228 and 260 within the script.
Then trim all reads and reverse-complement `*R.fasta.final.trimm<threshold>` reads, with the script `3-1_trimm_and_RC_seq.sh`. 
By default, the scrip trims positions 0..25 and 800..END. Change thresholds directly within the Bash script.

Then `mkdir All_fasta_aligned/`, and `perl 4-create_seq_to_align.pl <threshold>`.
Then last script to launch is `bash 5-align.sh`.

Finish with a manual curation of alignments.
Eletropherograms are present in the same dir as data (*cf* some line above for paths).
And **follow** [first batch of strains, point 9](#batch1)

#### Third plate: 16S_ITS_3 <a name="batch2-3"></a>

Data are present in 3 directories:
* `data/2015/3_primers_23-06-2015_stage_Amaia/16S_ITS_3/COL15-1F0R/16S_ITS_3_A4F` : **A4F** 
* `data/2015/3_primers_23-06-2015_stage_Amaia/16S_ITS_3/COL15-1F0R/16S_ITS_3_A1492` : **A1492R**
* `data/2015/3_primers_27-07-2015/COL15-1HVS/16S_ITS_3_A71R2` : **A71R_MOD**, 25 over 27 strains.

Here, for **A4F** and **A1492R**, discard reads `T-BAROSSII100` and `IRI51A`.
The first because there is another read called `T-BAROSSII10` that is exatly the same.
They were amplified by PCR from a 1/10 an 1/100 dillution of the DNA matrix.
The second, `IRI51A` failed during PCR amplification.

For assembly, follow same instructions as [16S_ITS_2](#batch2-2).
The working directory is `assemblies/02_second_batch_of_seq/16S_ITS_3`.
So 
```bash
cd assemblies/02_second_batch_of_seq/16S_ITS_3`
cp ../16_ITS_2/*.?? .
```
And let's go!

##Add metadata to defline <a name="defline"></a>

In this section, I will add metadata about strains within their defline.

All steps will be performed in `cd defline/` (from the root of the current repository) 
From the file `UBOCC_v4.xls`, I selected fields that look interesting. Here is the list of fields:

`Strain_name|origin_geographic_area|origin_locality|origin_habitat|origin_sample_date|temperature|ph|salinity|salinity_unit|latitude|longitude|depth|`

I take care of renaming strains properly according to their 16SrRNA-ITS sequence name. 

First, concatenate all 16S-ITS sequences from the 2 batchs of strains in a single file in this directory.
The name of this file must be `souchotheque-16S_ITS.fasta`.
Then, `perl add_defline_to_seq-V3.pl`, this script reads two `.csv` files of metadata and output two files:
* `complete_defline_Thermococale_culture_collection.txt`
* `souchotheque-16S_ITS-new-deflines.fasta`

In this directory, there is a second Perl script, `gps_coordinates.pl`.
This script reads the Fasta `souchotheque-16S_ITS-new-deflines.fasta`, extract GPS coordinates if available,
and output a 3-columns table `souchotheque_gps_coordinates.csv` where GPS coordinates are given in Decimal Degrees
(Lat: -90..90; Lon: -180..180). The **aim** of this file is to be used to plot these positions on a map (using *R*).

##Plot strains origin on map <a name="printOnMap"></a>

In this part will be present scripts used to obtain a global overview of the strains geographic origin.

Go to: `cd plot_strains_on_map` and execute the R script `plot_coord_on_map.r`.
With RStudio it is easier, uncomment the line `#print(map)` gives you a preview of your work before printing the map in a file.

##Phylogenetic tree <a name="phyloTree"></a>

In this section, we will build a phylogenetic tree with the concatenation of 16S rRNA and ITS sequences. 

From the root of this repository, `mkdir phylogenetic_tree && cd phylogenetic_tree`.

To be continued...

*the main ideas: Align 16S rRNA with [SINA](https://www.arb-silva.de/aligner/); cut the ITS from this alignment.
==> with SINA, 'bases remaining unaligned at the ends should be **moved to the edge of the alignment**;
Align ITS with MUSCLE or CLUSTALW; merge both alignments; build the tree with phyml/bayes/nj;

In ARB: First, modify deflines ==> strain_id:origin:site:accession:name(=ARB id) 

E10P12:Mid-atlantic-ridge:Menez-Gwen:NA:spec100

See '16S-ITS.ift' to import in ARB and 'damien3.eft' to export them with only the ARB id (aka 'name').*




