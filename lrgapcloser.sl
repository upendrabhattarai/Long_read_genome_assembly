#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
##SBATCH --qos=debug
#SBATCH --partition=large,bigmem
#SBATCH --job-name lr-gapNEM
#SBATCH --mem=20G
##SBATCH --time=00:15:00
#SBATCH --time=72:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load BWA/0.7.17-gimkl-2017a
export PATH=/nesi/nobackup/uoo02752/bin/LR_Gapcloser/src/:$PATH

sh LR_Gapcloser.sh -i Nem.flyeV2.5lrscaff.fasta -l m.neg_ont_nanolyse_porechop.fasta -s n -t 10 -r 15
