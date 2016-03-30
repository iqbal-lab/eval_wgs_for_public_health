# REPLICATES TESTS

First/second column are the first replicate and second replicate

Then for each pipeline we are calculating 4 different statistics:
* **_isec**: intersection (means the number of things called in first and second that match perfectly)
* **_or1**: **o**nly in **r**eplicate **1** (variants only found in replicate one, but not in two)
* **_or2**: **o**nly in **r**eplicate **2** (variants only found in replicate two, but not in one)
* **_mm**: Mismatches, means things called different in replicate1 and in replicate2. Both passing QC filters
* **_mmf**: Mismatches, means things called different in replicate1 and in replicate2. One of them failing QC filters
* **_mmz**: Mismatches, means things called different in replicate1 and in replicate2. One of them being called HZ
* **_mmfz**: Mismatches, means things called different in replicate1 and in replicate2. None of them passing filters

[REPLICATES.tsv](./REPLICATES.tsv)
