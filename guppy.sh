#!/bin/bash -e

#SBATCH --job-name=guppy               
#SBATCH --account=uoo02752
#SBATCH --time=10:00:00
#SBATCH --partition=gpu         # guppy runs faster in gpu partition in nesi, than other partition
#SBATCH --gres=gpu:1            # some configuration for gpu partition, that i don't understand, suggested by nesi support
#SBATCH --mem=6G                # memory 6gb
#SBATCH --ntasks=4              # ntask set to 4
#SBATCH --cpus-per-task=1       # cpu per task set to 1
#SBATCH --output=%x-%j.out      # %x gives job name and %j gives job number, this is slurm output file
#SBATCH --error=%x-%j.err       # similar slurm error file
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz


#Instructions on running guppy-gpu on NeSI Mahuika cluster :https://support.nesi.org.nz/hc/en-gb/articles/4546820344079-ont-guppy-gpu
module purge
module load ont-guppy-gpu/5.0.7

guppy_basecaller -i path/to/fast5/files -s ./ --flowcell FLO-MIN106 --kit SQK-LSK109 --num_callers 4 -x auto --recursive --trim_barcodes --disable_qscore_filtering
