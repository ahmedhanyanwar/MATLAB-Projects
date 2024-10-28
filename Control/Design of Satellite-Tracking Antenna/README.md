# MATLAB Project: Design of Satellite-Tracking Antenna

This project focuses on analyzing a control system using MATLAB. It includes Simulink models and MATLAB scripts for processing and visualizing system dynamics.

## Contents

- **AddPoles.mat**: MATLAB data file containing information related to pole placement.
- **AddZeros.mat**: MATLAB data file containing information related to zero placement.
- **Assignment.pdf**: Details regarding the assignment.
- **Report.pdf**: Final report summarizing the findings of the project.
- **AddPoles.slx**: Simulink model for analyzing pole placements.
- **AddZeros.slx**: Simulink model for analyzing zero placements.
- **Dominant_poles_zeros.slx**: Simulink model focusing on the effects of dominant poles and zeros.
- **main.m**: MATLAB script for performing transfer function analysis and simulations.

## Overview

The project involves creating and analyzing transfer functions for a given control system. The main components of the project are detailed below:

### main.m

This script is designed to define the transfer function, perform various analyses, and visualize the system's response.

#### Key Tasks:
- **Transfer Function Definition**: Defines the transfer function of the control system based on parameters like inertia, damping, and feedback gain.
- **State-Space Representation**: Converts the transfer function into its state-space form for further analysis.
- **Stability Analysis**: Calculates the maximum feedback gain for a stable closed-loop system and checks for overshoot constraints.
- **Response Analysis**: Plots step responses for different feedback gains and analyzes system performance characteristics.
- **Pole-Zero Analysis**: Generates pole-zero plots to visualize the locations of system poles and zeros in the complex plane.
- **Root Locus Analysis**: Illustrates the movement of system poles with varying feedback gain.
- **Steady-State Error Calculation**: Computes the steady-state errors for various feedback gains.

### Simulink Models

- **AddPoles.slx**: Simulink model representing the analysis of pole placements.
- **AddZeros.slx**: Simulink model representing the analysis of zero placements.
- **Dominant_poles_zeros.slx**: Simulink model for studying the impact of dominant poles and zeros on system behavior.

## Usage

To run this project, follow these steps:

1. Ensure you have MATLAB and Simulink installed (the project was developed in MATLAB R2020a).
2. Download or clone this repository to your local machine.
3. Open the `main.m` script in MATLAB and run it to perform the analysis.
4. Open the relevant Simulink models to visualize the system's dynamics.

## Dependencies

- MATLAB (version R2020a or later)
- Simulink

## Acknowledgements

This project was completed as part of an assignment. Special thanks to the instructors and peers for their guidance and support.
