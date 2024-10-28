# Digital Communications Lab Project

## Overview
This project investigates various aspects of digital communication systems, focusing on Inter-Symbol Interference (ISI) caused by band-limited and multipath channels. It consists of three main parts:

1. Inter-Symbol Interference due to band-limited channels
2. Inter-Symbol Interference due to multipath channels
3. Comparisons of coding techniques

## Table of Contents
- [Part 1: Inter-Symbol Interference due to Band-Limited Channels](#part-1-inter-symbol-interference-due-to-band-limited-channels)
- [Part 2: Inter-Symbol Interference due to Multipath Channels](#part-2-inter-symbol-interference-due-to-multipath-channels)
- [Part 3: Comparisons of Coding Techniques](#part-3-comparisons-of-coding-techniques)
- [How to Run](#how-to-run)
- [Requirements](#requirements)

## Part 1: Inter-Symbol Interference due to Band-Limited Channels
This part investigates how square pulses, which are commonly used to represent bits, are affected by band-limited channels.

### Key Tasks:
- Generate square pulses and analyze their characteristics.
- Demonstrate how two consecutive square pulses interact when passed through a band-limited channel.
- Explore alternative pulse shapes (triangular and sinusoidal) and analyze their performance in the same channel.

### MATLAB Functions:
- `GenerateSquarePulses`: Generates square pulses for given parameters.
- `GenerateTrianglePulses`: Generates triangular pulses.
- `GenerateSinusoidalPulses`: Generates sinusoidal pulses.
- `Analysis`: Analyzes and plots the signals in both time and frequency domains.

## Part 2: Inter-Symbol Interference due to Multipath Channels
This part examines ISI in multipath channels common in wireless communication systems.

### Key Tasks:
- Simulate the effect of multipath propagation on transmitted symbols.
- Estimate the transmitted signals from the received signals using equalization techniques.
- Analyze the Bit Error Rate (BER) performance as a function of \( E_b/N_0 \).

### MATLAB Functions:
- `GenerateBits`: Generates random bit sequences.
- `complexGauusian`: Generates Gaussian random variables.
- `MultipathChannel`: Simulates multipath channel effects.
- `Estimation`: Estimates transmitted symbols from the received signal.
- `ComputeBER`: Computes the bit error rate between transmitted and estimated symbols.

## Part 3: Comparisons of Coding Techniques
This part investigates the effectiveness of various coding techniques in combating channel degradation.

### Key Tasks:
- Implement a repetition coding technique to analyze BER performance in a Binary Symmetric Channel (BSC).
- Explore the effect of bit-flipping probability on the BER.

### MATLAB Functions:
- `GenerateSamples`: Converts bits to samples.
- `BSC`: Simulates a bit-flipping channel.
- `DecodeBitsFromSamples`: Decodes received samples back into bits.

## How to Run
1. Make sure you have MATLAB installed on your computer.
2. Download the project files and place them in a directory.
3. Open MATLAB and navigate to the project directory.
4. Run the scripts in the following order:
   - Part 1
   - Part 2
   - Part 3

## Requirements
- MATLAB R2021 or later
- Signal Processing Toolbox (for signal analysis functions)
- Basic understanding of digital communication concepts

## Conclusion
This project provides insights into the challenges of ISI in digital communication systems and explores coding techniques to mitigate these issues. The MATLAB simulations illustrate the performance of different signal shapes and coding strategies in various channel conditions.
