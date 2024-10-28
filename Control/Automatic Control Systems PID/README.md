# MATLAB Project: Cruise Control using PID Controller

This project focuses on implementing a PID controller for cruise control systems using MATLAB. It includes a MATLAB script for simulating the open-loop and closed-loop responses of a vehicle model.

## Contents

- **PID Lab.pdf**: Documentation regarding the PID controller lab work.
- **Report.pdf**: Final report summarizing the findings and analysis of the project.
- **PID.mlx**: MATLAB live script for simulating the cruise control system.

## Overview

The project involves creating a cruise control system using a PID controller to regulate the speed of a vehicle. The main components of the project are detailed below:

### PID.mlx

This script performs the following tasks:

1. **Open Loop Step Response**: Simulates the open-loop step response of a vehicle model defined by its mass and damping coefficient.

   #### Key Variables:
   - `m`: Vehicle mass (Kg).
   - `b`: Damping coefficient (N·s/m).
   - `plant_tf`: Transfer function representing the vehicle dynamics.

2. **Closed Loop Response**: Implements a PID controller to create a closed-loop system and simulates its step response.

   #### PID Controller Parameters:
   - `KP`: Proportional gain.
   - `KI`: Integral gain.
   - `KD`: Derivative gain.

## Usage

To run this project, follow these steps:

1. Ensure you have MATLAB installed (the project was developed in MATLAB R2020a).
2. Download or clone this repository to your local machine.
3. Open the `PID.mlx` script in MATLAB and run it to visualize the step responses.

## Dependencies

- MATLAB (version R2020a or later)

## Acknowledgements

This project was completed as part of a lab assignment. Special thanks to the instructors and peers for their guidance and support.