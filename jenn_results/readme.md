Flowchart:
bwa mem
samtools view -bS
samtools sort
samtools index

Then one of the following...

Option 1
samtools mpileup -q 20 -u ---> gardy_f11_with_indels
Option 2
samtools mpileup -q 20 -u ref file -I ---> gardy_f11_without_indels
Option 3
pilon --genome ref --frags file --vcf ---> gardy_f11_pilon

Then one of the following...
filter on mask file (nucmer repeats)
filter on 150bp threshold




