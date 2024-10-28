# Simple Communication System Project

## Overview

This project implements a simple communication system that sends and receives a sound file over a communication channel. The main components include a transmitter, a channel with different impulse responses, the addition of noise, and a receiver with filtering capabilities.

## Project Components

### 1. Transmitter

The transmitter prepares the audio signal for transmission. It involves:
- Loading a sound file.
- Trimming the audio to a specified duration.
- Playing the sound.
- Plotting the original signal in both time and frequency domains.

### 2. Channel

The channel simulates different impulse responses to analyze how the signal is affected during transmission. The following impulse responses can be selected:
- **Delta function**: Represents an ideal impulse response.
- **Exponential decay**: Simulates real-world effects on the signal.

The selected impulse response is convolved with the input signal to create the transmitted signal.

### 3. Noise Addition

Random noise is added to the transmitted signal to simulate real-world communication scenarios. The user can specify the noise level using a parameter called sigma.

### 4. Receiver

The receiver processes the noisy signal:
- It plays the signal with added noise.
- It performs frequency domain analysis to assess the effects of noise.
- It attempts to filter out the noise using an inverse Fourier transform on the filtered signal.
- The filtered signal is played back, and both the time and frequency domain characteristics are plotted.

## Requirements

- MATLAB: This project is written in MATLAB, and you need MATLAB installed to run the code.
- Audio File: Place the `Audio2.wav` file in the same directory as the MATLAB scripts to ensure the code can read the audio input.

## Usage

1. Run the MATLAB script to initiate the transmitter.
2. Follow the prompts to enter the number of seconds for editing the sound.
3. Select the desired impulse response from the menu.
4. Specify the noise level (sigma) for noise addition.
5. Observe the plots generated for time and frequency domains throughout the process.