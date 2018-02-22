# 16s_its_sequences
This directory summarize the framework used to sequence, check and assemble 16SrRNA-ITS sequences.
Different assembly where performed. One for each seqeuncing batch.

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



