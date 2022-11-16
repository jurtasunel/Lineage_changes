#!/bin/bash

### This script updates pangolin to the latest version.

cd /home/gabriel/pangolin
source ~/miniconda3/etc/profile.d/conda.sh
conda init

conda activate pangolin
git pull
python setup.py install
conda env update -f environment.yml
pip install git+https://github.com/cov-lineages/pangoLEARN.git --upgrade
echo "Execute as: pangolin seqs.fasta"


