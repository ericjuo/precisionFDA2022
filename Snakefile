# This pipeline is to conduct pre-alignment QC and read mapping paired end reads to hg19
#
# Created by Eric Juo
# June 2, 2022

# Set global variables
lab = ["LAB" + str(i+1) for i in range(3)]
replicate = ["LIB" + str(i+1) for i in range(4)]
pair = ["R1", "R3"]


# Output files
rule all:
    input:
        expand("reports/fastqc/pre_alignment/PanelA/PanelA_{lab}_{replicate}_{pair}_fastqc.html", lab=lab, replicate=replicate, pair=pair),
        "reports/multiqc/pre_alignment/PanelA/multiqc_report.html",


# Generate pre-alignment QC reports for each paired reads
rule pre_alignment_qc:
    input: 
        expand("../data/{{panel}}/FASTQ/{{panel}}_{lab}_{replicate}_{pair}.fastq.gz", lab=lab, replicate=replicate, pair=pair) 
    output:
        expand("reports/fastqc/pre_alignment/{{panel}}/{{panel}}_{lab}_{replicate}_{pair}_fastqc.html", lab=lab, replicate=replicate, pair=pair)
    params: 
        outdir = "reports/fastqc/pre_alignment/{panel}/"
    threads: 16
    shell:
        "mkdir -p reports/fastqc/pre_alignment/{wildcards.panel} && fastqc -t {threads} -o {params.outdir} {input}"

# Generate multiqc report
rule pre_alignment_multiqc:
    input:
        expand("reports/fastqc/pre_alignment/{{panel}}/{{panel}}_{lab}_{replicate}_{pair}_fastqc.html", lab=lab, replicate=replicate, pair=pair)
    output:
        "reports/multiqc/pre_alignment/{panel}/multiqc_report.html"
    params:
        indir = "reports/fastqc/pre_alignment/{panel}/"
    singularity:
        "docker://registry.hub.docker.com/ewels/multiqc"
    shell:
        "multiqc -f -n {output} {params.indir}"


    