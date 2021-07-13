#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 5
#SBATCH --partition=large
#SBATCH --job-name nanolyse.job
#SBATCH --mem=1G
#SBATCH --time=01:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

export PATH="/nesi/nobackup/uoo02752/nematode/bin/miniconda3/bin:$PATH"

cat Nem.ont.merged.fastq | NanoLyse | gzip > m.neg_nanopore_filtered.fastq.gz
