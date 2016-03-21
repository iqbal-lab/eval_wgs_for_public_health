
# Hackathon goals

 - Evaluate Oxford COMPASS pipeline for PHE/Genomes Canada use
 - Set up reusable tests for future versions and updates of pipelines
 - Oxford: look at Cortex and Platypus 
 - Australia: look at Nullarbor
 - Canada: 
 - Use these tests to evaluate any pipeline mods


# Tests

We have set up a variety of tests:

 1. "Spiked references": create 4 modified versions of M. tuberculosis reference genome with increasing numbers of SNPs added (distributed uniformly). Use real/empirical Illumina data from the same type strain: a pipeline should call precisely the SNPs we put into the reference, in theory. In practise, one does need to handle mutations that have occurred in the strain since the reference was assembled.

 2. Walker cluster data: a dataset of ~50 samples from a well studied outbreak. Dataset contains two clusters, plus non-cluster samples. 

 3. Resistotyping: the Walker cluster dataset also has standard DST data for comparison with in silico predictions.

 4. Single-sample with "gold-standard" truth. [yadda yadda there is no truth etc]: the F11 sample from A. Earle's Pileon paper has a high quality reference genome, plus manually curated whole genome alignment and associated variant calls, ranging across the mutation spectrum from SNPs, through indels, to large SVs and regions where roughly decribed events occur. Goal: measure proportion of genome accessible, false negative rate across the mutation spectrum, false positive rate across the mutation spectrum.

 5. Species identification: dataset of ~300 Mycobacterial samples with HAIN assay truth for species.


 6. If we have time we also have replicates

# Deliverables

There are some extra deliverables, over and above what we said above:

 1. Automated analysis of callsets against the above datasets/tests
 2. Maybe reorganise this repo so one directory per test, plus a summary markup file per test?



