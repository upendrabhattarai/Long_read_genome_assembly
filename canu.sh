#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
#SBATCH --partition=bigmem
#SBATCH --job-name canu
#SBATCH --mem=100G
#SBATCH --time=72:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load Canu/2.1.1-GCC-9.2.0

canu \
-p m.neg -d canu.nem.337 genomeSize=337m minReadLength=500 minOverlapLength=300 correctedErrorRate=0.146 \
useGrid=true gridOptions="--time=72:00:00 --partition=bigmem --account=uoo02752 --hint=nomultithread" \
-nanopore-raw m.neg_ont_nanolyse_porechop.fastq.gz
