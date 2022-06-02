# bwa read alignment

Written by: Eric Juo
First created: 2022/06/01
Latest modified: 2022/06/02

## Run pipeline
```
snakemake --cores 16 --use-singularity
```



## Package installation
### Install miniconda
Download miniconda tarball
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
Restart bash shell to activate base conda environment
```
exec bash
```
Add conda-forge and bioconda channel
```
conda config --add channels conda-forge
conda config --add channels bioconda
```
Create a new conda environment and install mamba and snakemake
```
conda create -n bioinfo mamba snakemake
```
Activate bioinfo environment
```
conda activate bioinfo
```
Install singularity (docker image runner)
```
mamba install -c conda-forge singularity
```
Install fastqc
```
mamba install fastqc
```