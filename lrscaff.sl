#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
#SBATCH --partition=large
#SBATCH --job-name lrscaf.nem.large
#SBATCH --mem=45G
#SBATCH --time=20:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load minimap2

# iteration 1
minimap2 -t 10 assembly.fasta m.neg_ont_nanolyse_porechop.fastq.gz > ./aln.mm
java -Xms40g -Xmx40g -jar /nesi/nobackup/uoo02752/bin/lrscaf/target/LRScaf-1.1.11.jar --contig assembly.fasta --alignedFile aln.mm -t mm -p 10 --output ./scaffolds1

# iteration 2
minimap2 -t 10 ./scaffolds1/scaffolds.fasta m.neg_ont_nanolyse_porechop.fastq.gz > ./scaffolds1/aln.mm
java -Xms40g -Xmx40g -jar /nesi/nobackup/uoo02752/bin/lrscaf/target/LRScaf-1.1.11.jar --contig ./scaffolds1/scaffolds.fasta --alignedFile ./scaffolds1/aln.mm -t mm -p 10 --output ./scaffolds1/scaffolds2

# iteration 3
minimap2 -t 10 ./scaffolds1/scaffolds2/scaffolds.fasta m.neg_ont_nanolyse_porechop.fastq.gz > ./scaffolds1/scaffolds2/aln.mm
java -Xms40g -Xmx40g -jar /nesi/nobackup/uoo02752/bin/lrscaf/target/LRScaf-1.1.11.jar --contig ./scaffolds1/scaffolds2/scaffolds.fasta --alignedFile ./scaffolds1/scaffolds2/aln.mm -t mm -p 10 --output ./scaffolds1/scaffolds2/scaffolds3

# iteration 4
minimap2 -t 10 ./scaffolds1/scaffolds2/scaffolds3/scaffolds.fasta m.neg_ont_nanolyse_porechop.fastq.gz > ./scaffolds1/scaffolds2/scaffolds3/aln.mm
java -Xms40g -Xmx40g -jar /nesi/nobackup/uoo02752/bin/lrscaf/target/LRScaf-1.1.11.jar --contig ./scaffolds1/scaffolds2/scaffolds3/scaffolds.fasta --alignedFile ./scaffolds1/scaffolds2/scaffolds3/aln.mm -t mm -p 10 --output ./scaffolds1/scaffolds2/scaffolds3/scaffolds4

# iteration 5
minimap2 -t 10 ./scaffolds1/scaffolds2/scaffolds3/scaffolds4/scaffolds.fasta m.neg_ont_nanolyse_porechop.fastq.gz > ./scaffolds1/scaffolds2/scaffolds3/scaffolds4/aln.mm
java -Xms40g -Xmx40g -jar /nesi/nobackup/uoo02752/bin/lrscaf/target/LRScaf-1.1.11.jar --contig ./scaffolds1/scaffolds2/scaffolds3/scaffolds4/scaffolds.fasta --alignedFile ./scaffolds1/scaffolds2/scaffolds3/scaffolds4/aln.mm -t mm -p 10 --output ./scaffolds1/scaffolds2/scaffolds3/scaffolds4/scaffolds5
