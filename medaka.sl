#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
#SBATCH --partition=large
#SBATCH --job-name flye.med
#SBATCH --mem=50G
#SBATCH --time=24:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread


export PATH=/nesi/nobackup/uoo02752/.conda/envs/python2/bin:$PATH


#==========> medaka consensus for flye_02 after 1 runs of racon
medaka_consensus -t 10 -m r941_min_fast_g303 -i /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/ew_all_nanopore_filt_trim.fq -d /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/f.auri.flye.racon1.fasta -o ./flye.1R_med

#==========> medaka consensus for flye_02 after 2 runs of racon
medaka_consensus -t 10 -m r941_min_fast_g303 -i /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/ew_all_nanopore_filt_trim.fq -d /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/f.auri.flye.racon2.fasta -o ./flye.2R_med

#==========> medaka consensus for flye_02 after 3 runs of racon
medaka_consensus -t 10 -m r941_min_fast_g303 -i /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/ew_all_nanopore_filt_trim.fq -d /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/f.auri.flye.racon3.fasta -o ./flye.3R_med

#==========> medaka consensus for flye_02 after 4 runs of racon
medaka_consensus -t 10 -m r941_min_fast_g303 -i /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/ew_all_nanopore_filt_trim.fq -d /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/f.auri.flye.racon4.fasta -o ./flye.4R_med

#==========> medaka consensus for flye_02 after 5 runs of racon
medaka_consensus -t 10 -m r941_min_fast_g303 -i /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/ew_all_nanopore_filt_trim.fq -d /nesi/nobackup/uoo02752/earwig/earwig_nanopore/5.polishing/2.flye.polish/1.racon/f.auri.flye.racon5.fasta -o ./flye.5R_med
