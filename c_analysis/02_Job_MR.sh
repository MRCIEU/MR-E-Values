#!/bin/bash
#SBATCH --account=psyc010162
#SBATCH --job-name=MR
#SBATCH --output=MR_slurm.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=10:00:00
#SBATCH --mem=10000M

#Put path in variable
CODE="${HOME}/scratch/MR-E-Value/code/c_analysis"

#Load R
module add languages/r/4.0.3
#Loads R

#Run R script
cd $CODE
R CMD BATCH --no-save --no-restore MR.R MR_r_log.txt


