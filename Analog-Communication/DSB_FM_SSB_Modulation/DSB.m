%%%  We plot the signal in time domain in green & in frequency domain in blue

% This script demonstrates Double Sideband (DSB) modulation techniques:
% Double Sideband Transmitted Carrier (DSB-TC) and Double Sideband 
% Suppressed Carrier (DSB-SC).

% 1.1 Read audio file
[y, fs] = audioread('eric.wav'); % Read the audio signal and sampling frequency
TS = 1/fs; % Calculate the sampling period

% Plot signal in time domain
figure; % Create a new figure window
subplot(211); % Create a subplot for time domain
plot(real(y), 'g'); % Plot the real part of the signal in green
title('Input signal in time domain', "Color", 'r'); % Set title in red
len = length(y); % Get the length of the signal
xdft = fftshift(fft(y)); % Compute the FFT and shift zero frequency component to center

% Create frequency vector for plotting
freq = linspace(-fs/2, fs/2, len); 

% Plot signal in frequency domain
subplot(212); % Create a subplot for frequency domain
plot(freq, abs(xdft)); % Plot the magnitude of the FFT
title('Input signal in frequency domain', "Color", 'r'); % Set title in red
xlim([-1.5 1.5] .* 10^4); % Set x-axis limits

% Ideal filter design
samplePerFreq = len/fs; % Calculate the number of samples per frequency unit
idealLPF = [zeros(round(samplePerFreq * 20000), 1); % Low-pass filter below 20 kHz
             ones(round(samplePerFreq * 8000) + 1, 1); % Passband for 8 kHz
             zeros(round(samplePerFreq * 20000), 1)];
sigAfterLPF = xdft .* idealLPF;  % Apply the low-pass filter to the signal

% Inverse FFT to obtain the filtered signal in time domain
dataoffilter = ifft(ifftshift(sigAfterLPF)); 

%% 1.3 Filtered signal in time and frequency domain & 1.4 Play sound
%sound(real(dataoffilter), fs); % Uncomment to play the filtered sound
%pause(samplePerFreq); % Uncomment to pause for duration of the sound
figure; % Create a new figure for filtered signals
subplot(211); 
plot(real(dataoffilter), 'g'); % Plot the filtered signal in time domain
title('The filtered signal in time domain', "Color", 'r'); 

subplot(212);
plot(freq, abs(sigAfterLPF)); % Plot the filtered signal in frequency domain
title('The filtered signal in frequency domain', "Color", 'r'); 
xlim([-4.5 4.5] .* 10^3); % Set x-axis limits

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1.5 Obtain the SSB by filtering out the USB (we need to get LSB only) of the DSB-SC modulated signal using an ideal filter

FC = 100 * 1000;   % Carrier frequency set to 100 kHz
fs2 = 5 * FC;      % New sampling frequency for the message signal   

dataoffilter_up = resample(dataoffilter, fs2, fs);  % Upsample the filtered data
t = linspace(0, length(dataoffilter_up) * 1/fs2, length(dataoffilter_up)); % Time vector for the carrier

% Create the cosine carrier signal
carrier = cos(2 * pi * FC * t); 
carrier = carrier'; % Transpose carrier to fit the input signal

A = 2 * max(dataoffilter_up); % Modulation index

freqUp = linspace(fs2/2, -fs2/2, length(dataoffilter_up)); % Frequency vector for upsampled signal

% DSB-SC modulation
DSB_SC = dataoffilter_up .* carrier; % Modulated signal s(t) in time
DSB_SCinFreq = fftshift(fft(DSB_SC)); % FFT of the modulated signal

% Plotting the modulated signal in frequency domain
figure; 
subplot(212);
plot(freqUp, abs(DSB_SCinFreq)); % Plot the magnitude of the DSB-SC
title('Modulated signal of DSB-SC in frequency domain.', "Color", 'r'); 
xlim([-11 11] .* 10^4); % Set x-axis limits

% DSB-TC modulation
DSB_TC = (A + dataoffilter_up) .* carrier; % DSB-TC modulation
DSB_TCinFreq = fftshift(fft(DSB_TC)); % FFT of the DSB-TC signal

% Plotting the DSB-TC modulated signal in frequency domain
subplot(211);
plot(freqUp, abs(DSB_TCinFreq)); % Plot the magnitude of the DSB-TC
title('Modulated signal of DSB-TC in frequency domain.', "Color", 'r'); 
xlim([-11 11] .* 10^4); % Set x-axis limits
% ylim([0 5000]) %%% Uncomment to limit y-axis to see the message spectrum

%% 1.6 & 1.7 - Envelope detection 
envlope_SC = abs(hilbert(real(DSB_SC))); % Hilbert transform for envelope detection of DSB-SC
envlope_SCdown = resample(envlope_SC, fs, fs2); % Downsample the envelope
envlope_TC = abs(hilbert(real(DSB_TC))) - A; % Hilbert transform for envelope of DSB-TC
envlope_TCdown = resample(envlope_TC, fs, fs2); % Downsample the envelope of DSB-TC
envlope_TCdown = envlope_TCdown(1:end-1); % Remove last element due to resampling
envlope_TCdown = envlope_TCdown - mean(envlope_TCdown); % Remove DC component from envelope

% We know that the envelope can't be used with DSB-SC so the output is a distortion
figure; 
subplot(211);
plot(real(envlope_SCdown), 'g'); % Plot envelope of DSB-SC in time domain
title('Envelope of DSB-SC in time', "Color", 'r'); 
%sound(real(envlope_SCdown), fs); % Uncomment to play the envelope sound
%pause(samplePerFreq); % Uncomment to pause for duration of the sound
% audiowrite("ScMod.wav", envlope_SCdown, fs); % Uncomment to save the sound

subplot(212);
plot(real(envlope_TCdown), 'g'); % Plot envelope of DSB-TC in time domain
title('Envelope of DSB-TC in time after DC block', "Color", 'r'); 
ylim([-.2 .2]); % Set y-axis limits for better visualization

% Plotting frequency domain of envelope of DSB-TC
% plot(freq, abs(fftshift(fft(envlope_TCdown))), 'g'); % Uncomment to plot the envelope in frequency domain
% title('Envelope of DSB-TC in time', "Color", 'r'); 
% figure; 

%sound(real(envlope_TCdown), fs); % Uncomment to play the envelope sound
%pause(samplePerFreq); % Uncomment to pause for duration of the sound
% From sounds, we prove that the envelope detection cannot be used in DSB-SC, but can be used in DSB-TC in case of m < 1
% audiowrite("TcMod.wav", envlope_TCdown, fs); % Uncomment to save the sound 

%% 1.8 - Coherent detection

% Additive white Gaussian noise
noisedSig_30 = awgn(DSB_SC, 30, 'measured'); % Add noise with 30 dB SNR
noisedSig_10 = awgn(DSB_SC, 10, 'measured'); % Add noise with 10 dB SNR
noisedSig_0 = awgn(DSB_SC, 0, 'measured'); % Add noise with 0 dB SNR

% noisedSig = resample(noisedSig, fs, fs2); % Uncomment to resample the noisy signal
%% 1.9 Frequency error & 1.10 Phase error
fError = .1 * 1000; % Frequency error of 0.1 kHz
carrierfreqEr = cos(2 * pi * (FC + fError) * t)'; %% Beat effect from frequency error
phaseError = 20; % Phase error of 20 degrees
carrierPhaseEr = cos(2 * pi * FC * t + pi * phaseError / 180)'; % Carrier with phase error


cohNoError = 2 * noisedSig_30 .* carrierfreqEr; %% Choose SNR and carrier for coherent detection
cohNoError = resample(cohNoError, fs, fs2); % Downsample the coherent detected signal
% This is because after resampling, length of signal increases by 1, so we ignore last element
cohNoError = cohNoError(1:end-1);
cohFFT = fftshift(fft(cohNoError)); % FFT of the coherent detected signal
cohFFT = idealLPF .* cohFFT; % Apply ideal low-pass filter
cohtime = ifft(ifftshift(cohFFT)); % Inverse FFT to get the
