#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
#SBATCH --partition=large
#SBATCH --job-name flye.nematode
#SBATCH --mem=50G
#SBATCH --time=72:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load Flye/2.7.1-gimkl-2020a-Python-2.7.18

flye --nano-raw m.neg_ont_nanolyse_porechop.fastq.gz \
--genome-size 337m -o ./M.neg_flye -t 10 -i 3
