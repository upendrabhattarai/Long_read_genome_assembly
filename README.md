# Long_read_genome_assembly
This is a compilation of the scripts I used for genome assembly using long read sequencing data (ONT)
Workflow
1. Basecalling (Guppy)
2. Checking the quality of our data (pycoQC)
3. Filtering reads (Nanolyse)
4. Removing adapters (Porechop)
5. Quality check (nanoQC)
6. Genome assembler
    - Flye
    - Canu
    - Redbean
7. Assembly polishing with Racon




## 1. Basecaling (Guppy)
We sequenced the genome using minion without live basecalling. So we are going to use guppy (v5.0.7) on GPU (In Nesi) for basecalling, we will use disable_qscore_filtering becasue we don't want to separate reads based on their quality scores in to pass and fail folders instead get all the fastq files in one folder and then decide on quality filtering.

Here is the script to [run](guppy.sl)

```
sbatch guppy.sl
```
## 2. Checking the quality of our data (pycoQC)
We can check the quality of our data using pycoQC, we can install it using miniconda, lets activate our miniconda using `conda activate` from `miniconda2/bin` directory

```
conda create -n pycoQC python=3.6
# or just
conda install -c bioconda pycoqc # pycoQC was built in python3 so need python3 environment.
```
pycoQC uses `sequencing_summary.txt` generated by guppy or other basecaller as an input. 
Script to [run](pycoqc.sl)

```
sbatch pycoqc.sl
```
PycoQC produces an interactive html report, as the one in here:
[PycoQC Report](pycoQC_output.html)


## 3. Filtering reads (Nanolyse)
We have used `DNACS` during nanopore sequencing library preparation so we will use `Nanolyse` to remove lamda DNA from our fastq files
We can install Nanolyse using miniconda environment, see [Nanolyse page on how](https://github.com/wdecoster/NanoLyse)
Let's run this [script](nanolyse.sl) to process our data with nanolyse.

```
sbatch nanolyse.sl
```
This will remove all the lamda DNA in our data
I have had problem running Nanolyse: that it couldn't find the lamdaDNA file `dna_cs.fasta` to filter out, in that case [here](dna_cs.fasta) is the lamda dna sequence copy it in your working directory and slightly change `nanolyse.sl` script as:

```
cat Nem.ont.merged.fastq | NanoLyse --reference ./dna_cs.fasta | gzip > m.neg_nanopore_filtered.fastq.gz
```

## 4. Removing adapters (Porechop)
We can use Porechop to remove adapters. Adapters on the ends are trimmed off and if on middle, they are treated as chimeric and chopped into seperate reads [Porechop](https://github.com/rrwick/Porechop#quick-usage-examples)
We used a flag `--trim_barcodes` with `Guppy` during base calling so the adapters on ends of the reads are already removed, however porechop helped remove adapters from middle of the reads.
Porechop is available as a module in Nesi so no need to install it we can run it with this [script](porechop.sl)

```
sbatch porechop.sl
```

## 5. Quality check (nanoQC)
We can install nanoQC using conda [see nanoQC](https://github.com/wdecoster/nanoQC)
Lets check the quality of our processed data
[script](nanoqc.sl)

```
sbatch nanoqc.sl
```

## 6. Genome assembler
We will use flye assembler for our data. I have tried several assemblers on this data with trimmed (based on quality scores) and untrimmed input reads. Flye assembly had the highest busco scores, however it produces bigger assembly (length and number of contigs). Below are the scripts to run each of assembler.

### 6.1 Flye
Flye is available as module in `Nesi` so no need to install it. We can run it with the script below, it will also run 3 iteration of genome polishing `-i 3`
[script](flye.sl)

```
sbatch flye.sl
```

### 6.2 Canu
Canu is also available in Nesi as module, so no need to install it. It performs reads trimming, correction and assembly. We can either run these three steps separately or run them all together. check out [canu](https://canu.readthedocs.io/en/latest/quick-start.html) for more details.
With the script below we can run all three steps of canu together and get an assembly for our input data. Options below like `minReadLength=500 minOverlapLength=300 correctedErrorRate=0.146` are tuned for our low coverage ONT data.
[script](canu.sl)

```
sbatch canu.sl
```

### 6.3 Redbean
Redbean previously known as wtdbg2 is also available as module in `Nesi`. We will run this assembler two times with two different (kmer) settings and merge those two assemblies to get the best out of it.

[Script for running first Redbean](redbean_1.sl)

```
sbatch redbean_1.sl
```

[Script for running second Redbean](redbean_2.sl)

```
sbatch redbean_2.sl
```

After getting these two Redbean assembly, we will run quast to quickly check their quality and busco score and we will use the assembly with better busco score as primary and merge another in to that.

## 7. Assembly polishing with Racon
We will run 5 iteration of racon, it utilizes minimap2 to map the reads to the draft assembly and polishes it.
[script](racon.5ite.sl)

```
sbatch racon.5ite.sl
```


## 8. Polishing with Medaka
Medaka installation with conda is easier, we can just follow the steps in this [link](https://nanoporetech.github.io/medaka/installation.html)
And run medaka for each of 5 iterations of racon output
[Script](medaka.sl)

```
sbatch medaka.sl
```
## 9. Polishing with nanopolish
We can also use nanopolish to polish the assembly.






