# 16s_its_sequences
This directory summarize the framework used to sequence, check and assemble 16SrRNA-ITS sequences.
Different assembly where performed. One for each seqeuncing batch.

## Description of the data used
### List of the different sequencing invoices
1. December 2015
2. March 2016
3. June 2015
4. July 2015

#### December 2015
Few months after the start of my thesis, I first finish 16S sequences produced by Nolwen Leost during her intership \(DUT, from April to June 2014\).
I had sequencing runs produced with primers A8F and A1492R on 96 _Thermococcales_ strains in theory.
Due to assembly failure with those 2 runs, I used a new sequencing run with the primer A958R to assemble the full 16S sequence. 

#### March 2016
This sequencing run dealt with 96 strains and the A71R primer.
Strains was the one sequenced by Nolwen (A8F - A1492R) and Damien (A958R)

##### Note about these data (December 2015 / March 2016)
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

#### June 2016
Here, after the Amaia's intership (April-June 2015), 219 \(2 \* 96 + 27\) strains were sequenced with A4F, A1492R and A71R primers.
The sequencing plates are:
	*16S_ITS_1
	*16S_ITS_2
	*16S_ITS_3

Some failure appeared for the A4F and A1492R primers.
Many sequences failed with the A71R primer.

#### July 2016
Here, it is the re-sequencing of the failed runs we encountered in June 2016.
Two primers were modified: A4F by A4F\_Thermocc, and A71R by A71R\_MOD

## Primer list
* A4F: _5'-TCC GGT TGA TCC TGC CRC-3'_
* A4F\_Thermocc: _5'-TCC GGT TGA TCC TGC CGC-3'_
* A8F: _5'-TCC GGT TGA TCC TGC C-3'_
* A958R: _5'-YCC GGC GTT GAM TCC AAT T-3'_ 
* A1492R: _5'-GGC TAC CTT GTT ACG ACT T-3'_
* A71R: _5'-TCG GYG CCC GAG CCG AGC CAC CC-3'_
* A71R\_MOD: _5'-TCG GYG CCC GAG CCG AGC CA-3'_


