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
pilon --genome ref --frags file --vcf > gardy_f11_pilon_SRR974838.vcf (SEE LINK IN THIS DIRECTORY FOR THIS FILE)
grep 1/1 in vcf ---> gardy_f11_pilon_SRR974838.variantsonly.vcf (SEE FILE IN THIS DIRECTORY)

Then...
filter using mask file to get rid of variants in 10% of Mtb genome that is super-repetitive (Carlos' NC018143.2 self-blast repeats in \masks) ---> gardy_f11_pilon_SRR974838.repmasked.variantsonly.vcf (SEE FILE IN THIS DIRECTORY)





