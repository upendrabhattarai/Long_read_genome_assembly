#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 5
#SBATCH --partition=large
#SBATCH --job-name pycoqc
#SBATCH --mem=2G
#SBATCH --time=00:20:00
#SBATCH --account=uoo02752
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

export PATH="/nesi/nobackup/uoo02752/nematode/bin/miniconda3/bin:$PATH"

pycoQC -f ../../sequencing_summary.txt -o pycoQC_output.html
