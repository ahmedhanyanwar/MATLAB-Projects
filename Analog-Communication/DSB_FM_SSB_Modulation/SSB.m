
% ___ Single Sideband (SSB) Modulation ___

% Read audio file
[y, fs] = audioread('eric.wav');  % Read the audio file
TS = 1/fs;  % Sample time

% Plot signal in time domain
figure;
subplot(211);
plot(real(y), 'g');  % Plot real part of the audio signal
title('Input signal in time domain', "Color", 'r');
len = length(y);  % Length of the signal
xdft = fftshift(fft(y));  % FFT of the signal

freq = linspace(-fs/2, fs/2, len);  % Frequency axis

% Plot signal in frequency domain
subplot(212);
plot(freq, abs(xdft));  % Magnitude of the FFT
title('Input signal in frequency domain', "Color", 'r');
xlim([-1.5 1.5] * 10^4);  % Set x-axis limits

%% Ideal low-pass filter
samplePerFreq = len/fs;  % Number of samples per frequency
idealLPF = [zeros(round(samplePerFreq * 20000), 1);
            ones(round(samplePerFreq * 8000) + 1, 1);
            zeros(round(samplePerFreq * 20000), 1)];
sigAfterLPF = xdft .* idealLPF;  % Apply LPF to the signal

%% 1.3 - The filtered signal in time and frequency domain
dataoffilter = ifft(ifftshift(sigAfterLPF));  % Inverse FFT to get time domain signal

% Uncomment to play sound
% sound(real(dataoffilter), fs);  % Play filtered sound
% pause(samplePerFreq);  % Wait for the sound to finish

% Plot filtered signal in time domain
figure;
subplot(211);
plot(real(dataoffilter), 'g');  % Plot real part of the filtered signal
title('The filtered signal in time domain', "Color", 'r');

% Plot filtered signal in frequency domain
subplot(212);
plot(freq, abs(sigAfterLPF));  % Magnitude of the filtered signal's FFT
title('The filtered signal in frequency domain', "Color", 'r');
xlim([-4.5 4.5] * 10^3);

%% 1.5 - Obtain the SSB by filtering out the USB
FC = 100 * 1000;   % Carrier frequency
fs2 = 5 * FC;      % New sampling frequency of the message signal   

dataoffilter_up = resample(dataoffilter, fs2, fs);  % Upsample the filtered signal
t = linspace(0, length(dataoffilter_up) * 1/fs2, length(dataoffilter_up));  % Time vector for carrier

carrier = cos(2 * pi * FC * t);  % Generate carrier signal
carrier = carrier';  % Transpose carrier to match the input signal

DSB_SC = dataoffilter_up .* carrier;  % Modulated signal s(t) in time domain
DSB_SCinFreq = fftshift(fft(DSB_SC));  % Modulated signal in frequency domain

freqSSB = linspace(-fs2/2, fs2/2, length(DSB_SCinFreq)); 
figure;
subplot(211);
plot(freqSSB, abs(DSB_SCinFreq));  % Plot DSB-SC before band pass filter
title('DSB-SC before band pass filter in frequency domain', "Color", 'r');
xlim([-11 11] * 10^4);

%% Ideal filter to get LSB
samplePerFreq = length(DSB_SC) / fs2; 

filterBW = (fs2 * 4000) / fs;  % Bandwidth of filter
L1 = round(samplePerFreq * 150000) + round(samplePerFreq * filterBW) + 1;  % Lower bound
U1 = round(samplePerFreq * (350000 + 1)) - round(samplePerFreq * filterBW) - 1;  % Upper bound

DSB_SCinFreqIdeal = DSB_SCinFreq;  % Copy frequency domain signal
DSB_SCinFreqIdeal(1:round(samplePerFreq * (150000 - 1))) = 0;  % Set unwanted frequencies to zero
DSB_SCinFreqIdeal(L1:U1) = 0;  % Set USB frequencies to zero
DSB_SCinFreqIdeal(round(samplePerFreq * (350000 + 1)):end) = 0;  % Set remaining frequencies to zero

% Plot the filtered signal in frequency domain
subplot(212);
plot(freqSSB, abs(DSB_SCinFreqIdeal));  % Plot LSB after band pass filter
title('SSB-SC After band pass filter in frequency domain', "Color", 'r');
xlim([-11 11] * 10^4);

DSB_SCinTimeIdeal = ifft(ifftshift(DSB_SCinFreqIdeal));  % Get time domain signal
SSB_SC = DSB_SCinTimeIdeal .* carrier;  % Demodulation
SSB_SC = resample(SSB_SC, fs, fs2);  % Downsample the signal after demodulation

SSB_SC_ff = fftshift(fft(SSB_SC));  % Frequency domain of demodulated signal

%% Ideal LPF to get LSB after demodulation
SSB_SC_ff = SSB_SC_ff(1:end-1);  % Ignore last element after resampling
SSB_SC_ff = SSB_SC_ff .* idealLPF;  % Apply LPF
SSB_SC_time = ifft(ifftshift(SSB_SC_ff));  % Get time domain signal
afterDownfreq = ifftshift(fft(SSB_SC_time));  % Frequency domain after downsampling

% Uncomment to play sound
% sound(real(SSB_SC_time), fs);  % Play received LSB ideal

%% Plot received LSB ideal in time domain
figure;
subplot(211);
plot(real(SSB_SC_time), 'g');  % Plot received LSB ideal in time domain
title('Received LSB ideal in time domain', "Color", 'r');

% Plot received LSB ideal in frequency domain
subplot(212);
plot(freq, abs(afterDownfreq));  % Plot received LSB ideal in frequency domain
title('Received LSB ideal in frequency domain', "Color", 'r');
xlim([-4.5 4.5] * 10^3);

%% 2.7 - Butterworth filter BPF to get LSB
fnormalized = fs2 / 2;  % Normalized frequency

% BPF Butterworth to get LSB 
[numerator, denomenator] = butter(4, [FC FC + filterBW] ./ fnormalized, 'bandpass');
DSB_SCFilter = filter(numerator, denomenator, DSB_SC);  % Apply Butterworth filter

% Plot before and after Butterworth BPF
figure;
subplot(211);
plot(freqSSB, abs(DSB_SCinFreq));  % Signal before BPF
title('Before band pass Butterworth in frequency domain', "Color", 'r');
xlim([-11 11] * 10^4);

subplot(212);
plot(freqSSB, abs(fftshift(fft(DSB_SCFilter))));  % Signal after BPF
title('After band pass Butterworth in frequency domain', "Color", 'r');
xlim([-11 11] * 10^4);

LSBButterfilter = DSB_SCFilter .* carrier;  % Demodulate the received signal
LSD_down = resample(LSBButterfilter, fs, fs2);  % Downsample

% Ignore last element after resampling
LSD_down = LSD_down(1:end-1);  

% Butterworth filter LPF to get LSB after demodulation
[numerator, denomenator] = butter(4, 4000 / (fs / 2));
LSD_downLPFTime = filter(numerator, denomenator, LSD_down);  % Apply LPF
LSD_downLPFFreq = fftshift(fft(LSD_downLPFTime));  % Frequency domain after LPF

% Uncomment to play sound
% sound(real(LSD_downLPFTime), fs);  % Play received LSB butter filter

% Plot received LSB butter filter in time and frequency domain
figure;
subplot(211);
plot(real(LSD_downLPFTime), 'g');  % Received LSB butter filter in time domain
title('Received LSB butter filter in time domain', "Color", 'r');

subplot(212);
plot(freq, abs(LSD_downLPFFreq));  % Received LSB butter filter in frequency domain
title('Received LSB butter filter in frequency domain', "Color", 'r');
xlim([-4.5 4.5] * 10^3);

%% ADD Noise
noisedSig_30 = awgn(DSB_SCinTimeIdeal, 30, 'measured');  % SNR = 30
noisedSig_10 = awgn(DSB_SCinTimeIdeal, 10, 'measured');  % SNR = 10
noisedSig_0 = awgn(DSB_SCinTimeIdeal, 0, 'measured');    % SNR = 0

% Compare the effects of noise
figure;
subplot(311);
plot(real(noisedSig_30), 'g');  % Noisy signal with SNR 30 in time domain
title('Noisy signal with SNR = 30', "Color", 'r');

subplot(312);
plot(real(noisedSig_10), 'g');  % Noisy signal with SNR 10 in time domain
title('Noisy signal with SNR = 10', "Color", 'r');

subplot(313);
plot(real(noisedSig_0), 'g');  % Noisy signal with SNR 0 in time domain
title('Noisy signal with SNR = 0', "Color", 'r');

%% Effect of noise on the frequency domain
figure;
subplot(311);
plot(freqSSB, abs(fftshift(fft(noisedSig_30))));  % Noisy signal with SNR 30 in frequency domain
title('Noisy signal with SNR = 30', "Color", 'r');
xlim([-11 11] * 10^4);

subplot(312);
plot(freqSSB, abs(fftshift(fft(noisedSig_10))));  % Noisy signal with SNR 10 in frequency domain
title('Noisy signal with SNR = 10', "Color", 'r');
xlim([-11 11] * 10^4);

subplot(313);
plot(freqSSB, abs(fftshift(fft(noisedSig_0))));  % Noisy signal with SNR 0 in frequency domain
title('Noisy signal with SNR = 0', "Color", 'r');
xlim([-11 11] * 10^4);

%% 2.7 - Butterworth filter BPF to get LSB
fnormalized = fs2 / 2;  % Normalized frequency

% BPF Butterworth to get LSB 
[numerator, denomenator] = butter(4, [FC FC + filterBW] ./ fnormalized, 'bandpass');
DSB_SCFilter_noised = filter(numerator, denomenator, noisedSig_30);  % Apply Butterworth filter

% Plot before and after Butterworth BPF
figure;
subplot(211);
plot(freqSSB, abs(fftshift(fft(noisedSig_30))));  % Signal before BPF
title('Before band pass Butterworth in frequency domain', "Color", 'r');
xlim([-11 11] * 10^4);

subplot(212);
plot(freqSSB, abs(fftshift(fft(DSB_SCFilter_noised))));  % Signal after BPF
title('After band pass Butterworth in frequency domain', "Color", 'r');
xlim([-11 11] * 10^4);

LSBButterfilter_noised = DSB_SCFilter_noised .* carrier;  % Demodulate the received signal
LSD_down_noised = resample(LSBButterfilter_noised, fs, fs2);  % Downsample

% Ignore last element after resampling
LSD_down_noised = LSD_down_noised(1:end-1);  

% Butterworth filter LPF to get LSB after demodulation
[numerator, denomenator] = butter(4, 4000 / (fs / 2));
LSD_downLPFTime_noised = filter(numerator, denomenator, LSD_down_noised);  % Apply LPF
LSD_downLPFFreq_noised = fftshift(fft(LSD_downLPFTime_noised));  % Frequency domain after LPF

% Uncomment to play sound
% sound(real(LSD_downLPFTime_noised), fs);  % Play received LSB butter filter with noise

% Plot received LSB butter filter with noise in time and frequency domain
figure;
subplot(211);
plot(real(LSD_downLPFTime_noised), 'g');  % Received LSB butter filter with noise in time domain
title('Received LSB butter filter with noise in time domain', "Color", 'r');

subplot(212);
plot(freq, abs(LSD_downLPFFreq_noised));  % Received LSB butter filter with noise in frequency domain
title('Received LSB butter filter with noise in frequency domain', "Color", 'r');
xlim([-4.5 4.5] * 10^3);
