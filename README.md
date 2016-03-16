<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Hackathon](#hackathon)
	- [Resources directories in cyloid](#resources-directories-in-cyloid)
		- [BAMS and references](#bams-and-references)
		- [Scripts](#scripts)
	- [Bam files QC](#bam-files-qc)
	- [Cortex vs platypus vs compass using 4 different references and 4 different samples](#cortex-vs-platypus-vs-compass-using-4-different-references-and-4-different-samples)
	- [Workbench (playing with vcf's)](#workbench-playing-with-vcfs)
		- [Basics](#basics)
		- [Displaying VCF records](#displaying-vcf-records)
			- [Displaying ALL vcf records:](#displaying-all-vcf-records)
			- [Displaying only one record](#displaying-only-one-record)
		- [Intersecting VCF's](#intersecting-vcfs)
		- [VCF union and difference](#vcf-union-and-difference)
		- [VCF Subsetting](#vcf-subsetting)



# Hackathon




## Resources directories in cyloid

All data is found under: **/data2/users/ALL/HACKATHON/**.
**FASTA** files for the **references** are found in /data2/users/ALL/HACKATHON/**references**.

### BAMS and references

The insilico mutations for the references are described in a **JSON** file found in /data2/users/ALL/HACKATHON/references/**InsilicoMuts.json**.

bams for the clusters and resistant samples are found in **/data2/users/ALL/HACKATHON/bams**.

bams for the H37rv samples are found in **/data2/users/ALL/HACKATHON/bams-h37rv**

If you want to access the bams in a more **human readable** format and better structured check **/data2/users/ALL/HACKATHON/bams_readable**

Tests have been executed under:  **/data2/users/ALL/HACKATHON/TESTS** where we can find directories for:
**CORTEX**, **COMPASS** and **PLATYPUS**.

### Scripts

Under each of the TEST directories you will find directories called **python** containing some scripts.

**/data2/users/ALL/HACKATHON/TESTS/[CORTEX/COMPASS/PLATYPUS]/python/analyze.py**: This script reads  the vcf outputs and generates statistics + pkl file containing info for the workbench.

## Bam files QC
[all BAM (clusters) flagstat QC](./allsamplesflagstat.tsv)

[all BAM (clusters) cov stats](./allsamples_cov.tsv)

[H37rv BAMs flagstat QC](./insilicoflagstats.tsv)

[H37rv cov stats](./insilico_covs.tsv)


## Cortex vs platypus vs compass using 4 different references and 4 different samples

The references used are H37rv with {82,926,8844,87977} mutations introduced insilico
The samples used are h37rv type strains used in several miseq runs as controls, and they
have different number of reads. I lebelled them by the number of MB they occupy {63,83,192,306}.

| Field | Description |
|------:|:------------|
| ID | H37rv version |
| REF | Reference version|
| RIGHT_MUT_DETECTED_RIGHT_PLACE| Mutations matching **in silico** padded mutations |
| PERC_TRU_POS | % of insilico mutations found |
| WRONG_MUT_DETECTED_RIGHT_PLACE | Mutations found not maching the in silico ones |
| QCFAIL_RIGHT_PLACE | insilico mutations that were nor called because of QC failure |
| MUT_WRONG_PLACE | Mutations found outside the in silico set |
| MUT_CALLED_REF | In silico position that match the reference, not the in silico mut |
| HETZ_RIGHT_PLACE| Hetz calls in in silico positions |
| MISSEDPOSITIONS | In silico positions that either don't have coverage or are not present as vcf records |
| MUTSININDELS |in silico mutations that are found within the span of an insertion/deletion|


SEE: [insilicotests.tsv](./insilicotests.tsv)

## Workbench (playing with vcf's)

There is a workbench setup (python app) in order to play and compare different VCF's.

### Basics
It is located in Cycloid (**/data2/users/ALL/HACKATHON/workbench**), demo:
```python
cd /data2/users/ALL/HACKATHON/workbench
python wb.py
1. 11
2. 192
3. 25
4. 306
5. 63
6. 83
Choose a bam version (Mbytes): 2
1. 82
2. 87977
3. 8844
4. 926
Choose a reference version (#Spiked mutations): 4
Variables cmp,ctx and plt have been loaded with information for the differnt variantcallers
----------------------------------------
Sample [COMPASS] vs ref [926] (1006 positions)
	MISSEDPOSITIONS: 3 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 899 positions
	HETZ_RIGHT_PLACE: 1 positions
	QCFAIL_RIGHT_PLACE: 24 positions
	MUT_WRONG_PLACE: 80 positions
--------------------------------------------
----------------------------------------
Sample [CORTEX] vs ref [926] (979 positions)
	MISSEDPOSITIONS: 53 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 846 positions
	HETZ_RIGHT_PLACE: 27 positions
	MUT_WRONG_PLACE: 53 positions
--------------------------------------------
----------------------------------------
Sample [PLATYPS] vs ref [926] (991 positions)
	MISSEDPOSITIONS: 13 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 754 positions
	QCFAIL_RIGHT_PLACE: 159 positions
	MUT_WRONG_PLACE: 65 positions
--------------------------------------------
```
When you execute wb.py first of all you must choose a reference and a bam file. After that, **three python variables** will be loaded with the information for the different callers, **cmp** for Compass, **ctx** for Cortex and **plt** for Platypus. NOTE: Not all the VCF records are stores in those variable, only the **classiffied  ones**.

Then an **IPython** console will be opened so you can interact with the three variables.

In the code above, you can see the contents of the three variables.

when printing a variable:

```python
print cmp
----------------------------------------
Sample [COMPASS] vs ref [926] (1006 positions)
	MISSEDPOSITIONS: 3 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 899 positions
	HETZ_RIGHT_PLACE: 1 positions
	QCFAIL_RIGHT_PLACE: 24 positions
	MUT_WRONG_PLACE: 80 positions
--------------------------------------------
```

In the heder we can see the sample name, the reference used, (in this case a reference with 926 in silico mutations) and the number of positions recorded from the vcf (1006).
Below, you can see the different classifications, and you can query them:

```python
In [1]: cmp.MISSEDPOSITIONS
Out[1]: {3931604, 3949076, 4201268}
```

### Displaying VCF records
If you want to see the vcf records:

```python
In [3]: cmp._QCFAIL_RIGHT_PLACE() # That will open /usr/bin/less with VCF record information

CMP: R00000371  127495  .       G       A       236.00  K0.90;z ABQ4=35.750;BCALL=N;BaseCounts=30,0,2,0;BaseCounts4=22,0,2,0;DM4=-1.410;DM4L=-1.627;DP=32;DP4=1,1,8,14;DPT4L=-4.363;DZ4=-1.354;DZ4L=-1.709;GC=77.230
-----------------------------
CMP: R00000371  334937  .       T       G       109.00  B1;f0.35        ABQ4=37.600;BCALL=G;BaseCounts=0,2,12,3;BaseCounts4=0,0,5,0;DM4=-2.575;DM4L=-4.838;DP=17;DP4=0,0,5,0;DPT4L=-31.339;DZ4=-2.467;DZ4L=-4.621;GC
-----------------------------
CMP: R00000371  338513  .       T       C       106.00  n5      ABQ4=35.000;BCALL=C;BaseCounts=2,8,0,0;BaseCounts4=0,4,0,0;DM4=-2.637;DM4L=-2.488;DP=11;DP4=0,0,2,2;DPT4L=-11.601;DZ4=-2.525;DZ4L=-2.490;GC=85.150;M
...
...
```

#### Displaying ALL vcf records:
use .show() method
#### Displaying only one record
use **[ ]** operator:
```python
In [23]: cmp[4241412]
Out[23]: 'CMP: R00000371\t4241413\t.\tT\tC\t232.00\tPASS\tABQ4=36.458;BCALL=C;BaseCounts=0,63,0,0;BaseCounts4=0,59,0,0;DM4=0.736;DM4L=0.451;DP=63;DP4=0,0,30,29;DPT4L=13.089;DZ4=0.694;DZ4L=0.175;GC=66.340;MQ=60;MQ4=60;PCALL4=1.000;PCONS4=1.000;SBR=0\tGT:DP\t1/1:59'

```

###  Intersecting VCF's
You can perform **intersections** operations as well with de **.intersect()** method:

```python
In [4]: cmp
Out[4]:
----------------------------------------
Sample [COMPASS] vs ref [926] (1006 positions)
	MISSEDPOSITIONS: 3 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 899 positions
	HETZ_RIGHT_PLACE: 1 positions
	QCFAIL_RIGHT_PLACE: 24 positions
	MUT_WRONG_PLACE: 80 positions
--------------------------------------------

In [5]: ctx
Out[5]:
----------------------------------------
Sample [CORTEX] vs ref [926] (979 positions)
	MISSEDPOSITIONS: 53 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 846 positions
	HETZ_RIGHT_PLACE: 27 positions
	MUT_WRONG_PLACE: 53 positions
--------------------------------------------

In [6]: ctx.intersect(cmp)
Out[6]:
----------------------------------------
Sample [( CORTEX ^ COMPASS )] vs ref [926] (979 positions)
	MISSEDPOSITIONS: 3 positions
	MUT_WRONG_PLACE: 53 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 845 positions
--------------------------------------------

```
### VCF union and difference

You can perform set union and set substraction as well:

```python
In [11]: cmp - ctx
Out[11]:
----------------------------------------
Sample [( COMPASS - CORTEX )] vs ref [926] (27 positions)
	MUT_WRONG_PLACE: 27 positions
--------------------------------------------

In [12]: cmp + plt
Out[12]:
----------------------------------------
Sample [( COMPASS U PLATYPS )] vs ref [926] (1013 positions)
	MISSEDPOSITIONS: 13 positions
	MUT_WRONG_PLACE: 87 positions
	QCFAIL_RIGHT_PLACE: 174 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 906 positions
--------------------------------------------
```

### VCF Subsetting

If you want just a subset of several positions from your VCF you can use **[]** operator to do that:

```python
In [15]: print cmp.QCFAIL_RIGHT_PLACE
set([3712385, 127494, 4060302, 3712153, 3735839, 623911, 1276841, 2439595, 1170480, 3947313, 1277618, 1191839, 2196161, 2029125, 1990470, 338512, 334936, 1619033, 3931099, 2551019, 2302448, 890739, 2973180, 3796094])

In [16]: print cmp.MISSEDPOSITIONS
set([3949076, 3931604, 4201268])

In [17]: print cmp.HETZ_RIGHT_PLACE
set([127494])

In [18]: cmp[[3712385,3949076,127494]]
Out[18]:
----------------------------------------
Sample [COMPASS (subset)] vs ref [926] (3 positions)
	MISSEDPOSITIONS: 1 positions
	HETZ_RIGHT_PLACE: 1 positions
	QCFAIL_RIGHT_PLACE: 2 positions
--------------------------------------------
```

You can do useful things like **How did QCFAIL_RIGHT_PLACE positions in PLATYPUS perform in COMPASS**??

```python
In [22]: cmp[plt.QCFAIL_RIGHT_PLACE]
Out[22]:
----------------------------------------
Sample [COMPASS (subset)] vs ref [926] (159 positions)
	QCFAIL_RIGHT_PLACE: 9 positions
	RIGHT_MUT_DETECTED_RIGHT_PLACE: 150 positions
--------------------------------------------
```
