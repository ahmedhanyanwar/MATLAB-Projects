% Clear command window and workspace
% clc
% clear all

% The following code plots the input signal in time domain (green),
% frequency domain (blue), and phase (black).

% ____ Frequency Modulation (FM) ____

% Read the audio file 'eric.wav' and extract the sampling frequency
[y, fs] = audioread('eric.wav');  % y: audio signal, fs: sampling frequency
TS = 1/fs;  % Calculate the sampling period

% Plot the input signal in the time domain
figure;  % Create a new figure
subplot(311);  % Create the first subplot in a 3-row configuration
plot(real(y), 'g');  % Plot the real part of the audio signal in green
title('Input signal in time domain', "Color", 'r');  % Set the title in red

len = length(y);  % Get the length of the signal
xdft = fftshift(fft(y));  % Compute the FFT and shift the zero frequency component to the center
phaseOfInput = angle(xdft) * (180/pi);  % Calculate phase in degrees

% Create frequency vector for plotting
freq = linspace(-fs/2, fs/2, len);

% Plot the input signal in the frequency domain
subplot(312);  % Create the second subplot
plot(freq, abs(xdft));  % Plot the magnitude of the FFT
title('Input signal in frequency domain', "Color", 'r');  % Set the title in red
xlim([-1.5 1.5] .* 10^4);  % Set the x-axis limits

% Plot the phase of the input signal
subplot(313);  % Create the third subplot
plot(freq, phaseOfInput, 'k');  % Plot the phase in black
title('Input of signal phase', "Color", 'r');  % Set the title in red

%% Ideal low-pass filter design
samplePerFreq = len/fs;  % Calculate the number of samples per frequency
idealLPF = [zeros(round(samplePerFreq * 20000), 1);  % Low-pass filter: 0 for frequencies above 8 kHz
             ones(round(samplePerFreq * 8000) + 1, 1);  % Passband for frequencies up to 8 kHz
             zeros(round(samplePerFreq * 20000), 1)];  % Stopband for higher frequencies

% Apply the ideal low-pass filter to the frequency domain signal
sigAfterLPF = xdft .* idealLPF;  % Signal after applying the filter
phaseOffilter = angle(sigAfterLPF) * (180/pi);  % Phase of the filtered signal in degrees

% Inverse FFT to get the time-domain representation of the filtered signal
dataoffilter = ifft(ifftshift(sigAfterLPF));  

%% 1.3 - Plotting the filtered signal in time and frequency domains
figure;
subplot(311);
plot(real(dataoffilter), 'g');  % Plot the real part of the filtered signal
title('The filtered signal in time domain', "Color", 'r');  % Set title

subplot(312);
plot(freq, abs(sigAfterLPF));  % Plot magnitude of the filtered signal in frequency domain
title('The filtered signal in frequency domain', "Color", 'r');  % Set title
xlim([-4.5 4.5] .* 10^3);  % Set x-axis limits

subplot(313);
plot(freq, phaseOffilter, 'k');  % Plot the phase of the filtered signal
title('The phase of the filtered signal', "Color", 'r');  % Set title

%% Frequency modulation parameters
FC = 100 * 1000;  % Carrier frequency (100 kHz)
fs2 = 5 * FC;     % New sampling frequency for the message signal   
dataoffilter_up = resample(dataoffilter, fs2, fs);  % Upsampling the filtered signal

% Resize time vector for cosine carrier signal
t = linspace(0, length(dataoffilter_up) * 1/fs2, length(dataoffilter_up));  
carrier = cos(2 * pi * FC * t);  % Generate carrier signal
carrier_shift = sin(2 * pi * FC * t);  % Generate carrier phase shift signal
carrier = transpose(carrier);  % Transpose carrier to column vector
carrier_shift = carrier_shift';  % Transpose carrier shift to row vector

% Get integration of the message signal
integ = cumsum(dataoffilter_up);  % Cumulative sum to integrate

% Define the non-linear frequency modulation (NBFM) signal
% This will introduce some noise in the output.
NBFM = carrier - (integ .* carrier_shift);  % NBFM equation without K.F

% Frequency domain representation of the NBFM signal
NBFM_infreq = fftshift(fft(NBFM));  % FFT of NBFM signal

% Get magnitude and phase of the modulated signal
phaseNBFM_infreq = angle(NBFM_infreq) * (180/pi);  % Phase in degrees
FreqUP = linspace(-fs2/2, fs2/2, length(NBFM_infreq));  % Frequency vector for NBFM

% Plotting NBFM in time and frequency domains
figure;

subplot(311);
plot(real(NBFM), 'g');  % Plot the real part of NBFM
title('NBFM Time Domain', "Color", 'r');  % Set title

subplot(312);
plot(FreqUP, abs(NBFM_infreq));  % Plot magnitude of NBFM in frequency domain
title('Magnitude of NBFM F_Domain', "Color", 'r');  % Set title
xlim([-1.5 1.5] .* 10^5);  % Set x-axis limits
ylim([0 10000]);  % Set y-axis limits

subplot(313);
plot(FreqUP, phaseNBFM_infreq, 'k');  % Plot phase of NBFM
title('The phase of the filtered signal', "Color", 'r');  % Set title

%% Demodulation using differentiation and envelope detection (ED) for NBFM
% Differentiate the modulated signal for demodulation
NBFMDemod = abs(hilbert(real(NBFM)));  % Apply envelope detection using Hilbert transform
NBFMDemod = diff(NBFMDemod);  % Differentiate the signal to retrieve the original message
NBFMDemodDown = resample(NBFMDemod, fs, fs2);  % Downsample the demodulated signal
NBFMDemodInFreq = fftshift(fft(NBFMDemodDown));  % FFT of demodulated signal
NBFMDemodPhase = angle(NBFMDemodInFreq) * (180/pi);  % Phase of the demodulated signal in degrees

% Play the recovered sound
sound(real(NBFMDemodDown), fs);  % Output the sound at original sampling frequency

% Plotting the received message in time and frequency domains
figure;
subplot(311);
plot(real(NBFMDemodDown), 'g');  % Plot the real part of the received message
title('Received message in TIME Domain', "Color", 'r');  % Set title
ylim([-0.2 0.2]);  % Set y-axis limits

subplot(312);
plot(freq, abs(NBFMDemodInFreq));  % Plot the magnitude of the received message in frequency domain
title('Received message in Frequency Domain', "Color", 'r');  % Set title
xlim([-4.5 4.5] .* 10^3);  % Set x-axis limits

subplot(313);
plot(freq, NBFMDemodPhase, 'k');  % Plot the phase of the received message
title('Received message Phase.', "Color", 'r');  % Set title
