#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
#SBATCH --partition=bigmem
#SBATCH --job-name racon.flye.nem
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load Racon
module load minimap2

#======> Correction 1 X Racon
minimap2 -t 10 assembly.fasta m.neg_ont_nanolyse_porechop.fastq > m.neg.flye.gfa1.paf
racon -t 10 m.neg_ont_nanolyse_porechop.fastq m.neg.flye.gfa1.paf assembly.fasta > m.neg.flye.racon1.fasta

#======> Correction 2 X Racon
minimap2 -t 10 m.neg.flye.racon1.fasta m.neg_ont_nanolyse_porechop.fastq > m.neg.flye.gfa2.paf
racon -t 10 m.neg_ont_nanolyse_porechop.fastq m.neg.flye.gfa2.paf m.neg.flye.racon1.fasta > m.neg.flye.racon2.fasta

#======> Correction 3 X Racon
minimap2 -t 10 m.neg.flye.racon2.fasta m.neg_ont_nanolyse_porechop.fastq > m.neg.flye.gfa3.paf
racon -t 10 m.neg_ont_nanolyse_porechop.fastq m.neg.flye.gfa3.paf m.neg.flye.racon2.fasta > m.neg.flye.racon3.fasta

#======> Correction 4 X Racon
minimap2 -t 10 m.neg.flye.racon3.fasta m.neg_ont_nanolyse_porechop.fastq > m.neg.flye.gfa4.paf
racon -t 10 m.neg_ont_nanolyse_porechop.fastq m.neg.flye.gfa4.paf m.neg.flye.racon3.fasta > m.neg.flye.racon4.fasta

#======> Correction 5 X Racon
#minimap2 -t 10 m.neg.flye.racon4.fasta m.neg_ont_nanolyse_porechop.fastq > m.neg.flye.gfa5.paf
#racon -t 10 m.neg_ont_nanolyse_porechop.fastq m.neg.flye.gfa5.paf m.neg.flye.racon4.fasta > m.neg.flye.racon5.fasta
