#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
#SBATCH --partition=large
#SBATCH --job-name wtdbg2_2.1
#SBATCH --mem=50G
#SBATCH --time=48:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load wtdbg/2.5-GCC-9.2.0

wtdbg2 -x ont -g 67m -t 10 -i m.neg_ont_nanolyse_porechop.fastq.gz \
-fo m.neg_wtdbgp0k17 -p 0 -k 17 -S 2 -L 5000 --edge-min 2 —rescue-low-cov-edges -A --aln-dovetail -1     # for denovo assembly

wtpoa-cns -t 10 -i m.neg_wtdbgp0k17.ctg.lay.gz -fo m.neg_wtdbgp0k17.ctg.fa    # for consensus
