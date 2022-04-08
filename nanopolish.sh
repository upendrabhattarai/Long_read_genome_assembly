#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 30
#SBATCH --job-name nanopolishNem
#SBATCH --mem=10G
#SBATCH --time=7-00:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

#nanopolish will load Python/3.8.2 which is a built in dependency 
module purge
module load nanopolish/0.13.3-gimkl-2020a-Python-3.9.9
module load SAMtools/1.12-GCC-9.2.0
module load minimap2/2.20-GCC-9.2.0


nanopolish index -d /nesi/nobackup/uoo02752/nematode/nematode_nanopore/0.all_fast5/fast5.files basecalled.fastq
minimap2 -ax map-ont -t 10 assembly.fasta basecalled.fastq | samtools sort -o basecalled.sorted.bam -T reads.tmp
samtools index basecalled.sorted.bam  

nanopolish_makerange.py assembly.fasta | parallel --results nanopolish.results -P 1 \
nanopolish variants --consensus -o polished.{1}.vcf -w {1} -r basecalled.fastq -b basecalled.sorted.bam -g assembly.fasta -t 30 --min-candidate-frequency 0.1
