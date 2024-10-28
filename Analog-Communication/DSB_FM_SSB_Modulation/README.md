# Communication Modulation Techniques

This repository contains three MATLAB scripts that demonstrate various modulation techniques in communication systems: Double Sideband (DSB) modulation, Single Sideband (SSB) modulation, and Frequency Modulation (FM). Each script processes an audio signal and visualizes the results in both time and frequency domains.

## Table of Contents

1. [DSB.m - Double Sideband Modulation](#1-dsb)
2. [SSB.m - Single Sideband Modulation](#2-ssb)
3. [FM.m - Frequency Modulation](#3-fm)

## 1. DSB.m - Double Sideband Modulation

- Demonstrates Double Sideband Transmitted Carrier (DSB-TC) and Double Sideband Suppressed Carrier (DSB-SC) modulation techniques.
- Reads an audio file and plots the input signal in both time and frequency domains.
- Applies an ideal low pass filter (LPF) to the signal to obtain the filtered version.
- Modulates the filtered signal using a cosine carrier and visualizes the modulated signal.
- Filters the modulated signal to extract the desired sideband.
- Plots the received signal in time and frequency domains, including noise simulation and filtering.

## 2. SSB.m - Single Sideband Modulation

- Demonstrates Single Sideband (SSB) modulation technique.
- Similar to DSB, but focuses on Single Sideband modulation by filtering out undesired frequencies.
- Reads an audio file and plots the input signal in both time and frequency domains.
- Applies an ideal low pass filter (LPF) to the signal to obtain the filtered version.
- Modulates the filtered signal and extracts the lower sideband using an ideal band-pass filter.
- Plots the received signal in time and frequency domains, including noise simulation and filtering.

## 3. FM.m - Frequency Modulation

- Demonstrates Frequency Modulation (FM) techniques where the instantaneous frequency of the carrier varies according to the amplitude of the message signal.
- Reads an audio file and plots the input signal in both time and frequency domains.
- Applies an ideal low pass filter (LPF) to obtain the filtered version.
- Performs frequency modulation using a cosine carrier and visualizes the modulated signal.
- Demodulates the FM signal using envelope detection and differentiation.
- Plots the received message in time and frequency domains, including the playback of the demodulated signal.

## How to Run

1. Ensure you have MATLAB installed on your computer.
2. Download or clone this repository.
3. Open each `.m` file in MATLAB and run the script to observe the results.
4. Make sure to have an audio file named `eric.wav` in the same directory for the scripts to work properly.

## Acknowledgments

- This project was developed for educational purposes to illustrate modulation techniques in communication systems.
- References from communication engineering textbooks and MATLAB documentation were utilized to create these examples.
