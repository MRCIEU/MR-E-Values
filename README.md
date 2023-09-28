# The MR-E-Value: Smoking and Schizophrenia
This pipeline produces linear regression and Mendelian randomisation estimates for the potential causal relationship between smoking initiation and schizophrenia, using UK Biobank data, to be used to calculate the MR-E-Values.

## Directory Structure
### The project folder has the following structure:
```
MR-E-Value/code
MR-E-Value/code/a_extract_data
MR-E-Value/code/b_process
MR-E-Value/code/c_analysis
MR-E-Value/data
MR-E-Value/output
``` 
## Input Files
```
data/data-mr.txt
```
This file contains data for schizophrenia (ICD 10 codes F20-F24,F28-29), smoking (ever versus never), risk-taking (risk-taker versus not) and beta-weighted genetic risk scores for smoking (Liu, 2019) and risk-taking (Linner, 2019).
This file combines data created for Mendelian randomisations by two other pipelines. These are `MRCIEU/MultiverseMR_Smoking_Schizophrenia` and `MRCIEU/Confounder-MR` (risk-taking).
## Scripts
### a_extract_data
This section of the pipeline extracts dates for schizophrenia diagnoses and calculates whether these were before or after baseline for each individual. 
### b_process
This section of the pipeline excludes individuals with schizophrenia diagnoses before baseline and those with missing data for smoking initiation.
### c_analysis
This section of the pipeline conducts a linear regressions of schizophrenia on smoking initiation and an analogous MR. 
These effect estimates can then be entered into my shiny application (`https://mark-gibson.shinyapps.io/mr-e-values_shiny_app/`) which conducts the MR-E-Value analysis. 
This section of the pipeline also conducts MRs of both smoking initiation and schizophrenia on risk-taking to investigate it's strength as a potential confounder.
