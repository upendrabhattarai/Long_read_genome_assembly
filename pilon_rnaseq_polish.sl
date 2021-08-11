#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 10
#SBATCH --partition=hugemem
#SBATCH --job-name pilon
#SBATCH --mem=140G
#SBATCH --time=100:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load Bowtie2/2.4.1-GCC-9.2.0
module load SAMtools/1.12-GCC-9.2.0
module load Python/3.9.5-gimkl-2020a
module load Pilon/1.24-Java-15.0.2

bowtie2-build genome_assembly.fasta ew
bowtie2 -p 10 --local -x ew -1 RNA_Seq_reads_R1_trim.fq.gz -2 RNA_Seq_reads_R2_trim.fq.gz | samtools sort > genome_assembly.fasta.bam
samtools index genome_assembly.fasta.bam genome_assembly.fasta.bai

##To run Pilon
java -Xmx140G -jar $EBROOTPILON/pilon.jar --genome genome_assembly.fasta --frags genome_assembly.fasta.bam --fix snps,indels --output genome_assembly.pilon1 \
--gapmargin 1 --mingap 10000000 --threads 10 --verbose --changes 2>Pilon.stderr.txt 1>Pilon.stdout.txt

bowtie2-build genome_assembly.pilon1.fasta ew1
bowtie2 -p 10 --local -x ew1 -1 RNA_Seq_reads_R1_trim.fq.gz -2 RNA_Seq_reads_R2_trim.fq.gz | samtools sort > genome_assembly.pilon1.fasta.bam
samtools index genome_assembly.pilon1.fasta.bam genome_assembly.pilon1.fasta.bai

##To run Pilon
java -Xmx140G -jar $EBROOTPILON/pilon.jar --genome genome_assembly.pilon1.fasta --frags genome_assembly.pilon1.fasta.bam --fix snps,indels --output genome_assembly.pilon2 \
--gapmargin 1 --mingap 10000000 --threads 10 --verbose --changes 2>Pilon1.stderr.txt 1>Pilon1.stdout.txt

bowtie2-build genome_assembly.pilon2.fasta ew2
bowtie2 -p 10 --local -x ew2 -1 RNA_Seq_reads_R1_trim.fq.gz -2 RNA_Seq_reads_R2_trim.fq.gz | samtools sort > genome_assembly.pilon2.fasta.bam
samtools index genome_assembly.pilon2.fasta.bam genome_assembly.pilon2.fasta.bai

##To run Pilon
java -Xmx140G -jar $EBROOTPILON/pilon.jar --genome genome_assembly.pilon2.fasta --frags genome_assembly.pilon2.fasta.bam --fix snps,indels --output genome_assembly.pilon3 \
--gapmargin 1 --mingap 10000000 --threads 10 --verbose --changes 2>Pilon2.stderr.txt 1>Pilon2.stdout.txt
