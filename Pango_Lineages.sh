#!/bin/bash

# Call the conda profile and activate pangolin.
source ~/miniconda3/etc/profile.d/conda.sh
conda activate
conda init
conda activate pangolin

# Call the Rscript to generate the lineage changes csv.
Rscript /home/gabriel/Desktop/Jose/Projects/Lineage_changes/Scripts/Pango_Lineages.R

# Remove intermediate files
#rm pango.fasta lineage_report.csv



