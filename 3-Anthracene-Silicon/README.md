# Chapter 3: Steric-Induced Bending and Energy Level Shifts in 9-Anthracene on Si(111)

## 📘 Overview
Inputs and outputs used to generate the data shown in chapter 3. The contents include inputs and outputs for reported Gaussian calculations, a Mathematica notebook used to process some data, inputs and outputs to the FCClasses3.0 program, and inputs and outputs for reported VASP calculations and BOMD simulations.


## 🗂 Contents
- `Gaussian_functional-testing/` input and log files from Gaussian checking the first excitation energy for different functionals and basis sets.
- `Gaussian_NBO_analysis/` output from Gaussian natural bonding obrital (NBO) calculations and Mathematica notebook for analysis
- `OPA-spectra/` input files for FCClasses3.0 used to generate the one-photon absorption spectra from Gaussian and the final spectrum.
- `VASP/` OUTCARs and POSCARs from VASP calculations and inputs and xml files from BOMD simulations. Original DOSCAR files are too large, so the processed data is available as an alternative in a CSV file. Code used to process the data is available in `VASP-postprocessing`
