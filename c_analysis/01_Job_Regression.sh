#!/bin/bash
#SBATCH --account=psyc010162
#SBATCH --job-name=regression
#SBATCH --output=regression_slurm.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --mem=1000M

#Put path in variable
CODE="${HOME}/scratch/MR-E-Value/code/c_analysis"

#Load R
module add languages/r/4.0.3
#Loads R

#Run R script
cd $CODE
R CMD BATCH --no-save --no-restore regression.R regression_r_log.txt


