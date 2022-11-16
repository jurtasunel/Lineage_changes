#!/bin/bash

### This script produces a report of the pangolin lineage changes, sends it attached by email and moves it to the Reports folder.

# Call the script to update pangoling.
echo "Updating pangolin"
bash pangolin_update.sh

# Call the conda profile and activate pangolin.
echo "Initializing conda"
source ~/miniconda3/etc/profile.d/conda.sh
conda activate
conda init
conda activate pangolin

# Call the Rscript to generate the lineage changes csv.
echo "Calling Pango_Lineages.R script"
Rscript Pango_Lineages.R

# Remove intermediate files and move the result files to the Reports folder.
rm pango.fasta lineage_report.csv 
mv *.csv  /home/gabriel/Desktop/Jose/Projects/Lineage_changes/Reports/

