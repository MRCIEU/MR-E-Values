#!/bin/bash
#SBATCH --account=psyc010162
#SBATCH --job-name=extract_schizophrenia_dates
#SBATCH --output=extract_schizophrenia_dates_slurm.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=22
#SBATCH --time=20:00:00
#SBATCH --mem=100000M
#SBATCH --partition=mrcieu

###############################
# EXTRACT SCHIZOPHRENIA DATES #
###############################

#Put data filepath in variable
DATA="$HOME/scratch/MR-E-Value/data"
CODE="$HOME/scratch/MR-E-Value/code/a_extract_data/"

#Get column numbers for ICD dates and baseline date
head -n1 $DATA/data.50982.tab | sed 's/\t/\n/g' | nl | grep -n "f.41280.0."
head -n1 $DATA/data.50982.tab | sed 's/\t/\n/g' | nl | grep -n "f.53.0."

#Put columns in file
cut -f90 $DATA/data.50982.tab > $DATA/baseline.txt
cut -f16171-16413 $DATA/data.50982.tab > $DATA/icd10dates.txt

#Check
head -n1 $DATA/baseline.txt
head -n1 $DATA/icd10dates.txt

#########################
# EXTRACT CORRECT DATES #
#########################

#Run R code
module add languages/r/4.0.3
cd $CODE
R CMD BATCH --no-save --no-restore process_schizophrenia_dates.R process_schizophrenia_dates_r_log.txt

#Replace header
sed  -i '1i SCHZ_Before_Baseline' $DATA/date_SCHZ_excld.txt

#Count cases
echo "count cases"
grep -c 1 $DATA/date_SCHZ_excld.txt
grep -c 0 $DATA/date_SCHZ_excld.txt

#Add IDs
cut -f1 $DATA/data.50982.tab > $DATA/IDs.txt
paste $DATA/IDs.txt $DATA/date_SCHZ_excld.txt > $DATA/exclude.txt
