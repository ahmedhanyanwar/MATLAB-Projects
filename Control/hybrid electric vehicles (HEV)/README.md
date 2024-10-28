# MATLAB Project: hybrid electric vehicles (HEV) Transfer Function

This project focuses on analyzing transfer functions using MATLAB. It includes Simulink models and MATLAB scripts for processing and visualizing system dynamics.

## Contents

- **Assignment_details.pdf**: Details regarding the assignment.
- **Report.pdf**: Final report summarizing the findings of the project.
- **tfFile.mat**: Contains the variables and data necessary for the analysis.
- **TransferFunction.slx**: Simulink model file representing the transfer function analysis.
- **tfFile.m**: MATLAB script to load data from `tfFile.mat` and perform analysis.

## Overview

The project involves creating and analyzing transfer functions for a given system. The main components of the project are detailed below:

### tfFile.m

This script is designed to load the necessary variables from the `tfFile.mat` file and define parameters for the transfer function analysis. 

#### Key Variables:
- `ETAtot_Kt`: Total efficiency coefficient.
- `Kb`: Gain constant.
- `Kcs`: Controller gain.
- `Kf`: Feedback gain.
- `Kss`: Steady-state gain.
- `PCwAvor_Itot`: Total power coefficient.
- `Ra_inv`: Inverse resistance.
- `r_Itot`: Total resistance.

### TransferFunction.slx

This is a Simulink model that utilizes the loaded variables to simulate the transfer function dynamics. It serves as a visual representation of the system's behavior.

## Usage

To run this project, follow these steps:

1. Ensure you have MATLAB and Simulink installed (the project was developed in MATLAB R2020a).
2. Download or clone this repository to your local machine.
3. Open the `tfFile.m` script in MATLAB and run it to load the variables.
4. Open the `TransferFunction.slx` model in Simulink to visualize the system.

## Dependencies

- MATLAB (version R2020a or later)
- Simulink

## Acknowledgements

This project was completed as part of an assignment. Special thanks to the instructors and peers for their guidance and support.
