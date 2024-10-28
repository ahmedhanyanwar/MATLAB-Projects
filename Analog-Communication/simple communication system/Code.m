% 1) Transmitter
% Load the sound file
[y, fs] = audioread('Audio2.wav');  % Read audio file and its sampling frequency
sec = input('Enter number of seconds to edit: ');  % Get user input for duration
y = y(1:sec * fs, 1);  % Trim audio to the specified duration
fprintf('The sound is playing\n');

% Play the sound
sound(y, fs);  % Play the trimmed sound
pause(sec);  % Pause for the duration of the sound

% Generate time vector
t = linspace(0, sec, sec * fs);  % Create time vector for plotting
t = t';  % Transpose time vector for proper shape

% Plot original signal in time domain
figure('Name', 'Original Signal', 'NumberTitle', 'on');
subplot(3, 1, 1);  % Create a subplot for the original signal
plot(t, y);  % Plot the time-domain signal
title('Sound in Time Domain');  % Title for the plot
ylabel('Amplitude');  % Y-axis label
xlabel('Length (in seconds)');  % X-axis label

% Frequency domain analysis
ys = fftshift(fft(y));  % Compute the FFT and shift zero frequency to center
fvec = linspace(-fs/2, fs/2, length(ys));  % Frequency vector for plotting
ysmag = abs(ys);  % Magnitude of the FFT
ysphase = angle(ys) * (180 / pi);  % Phase of the FFT in degrees

% Plot magnitude in frequency domain
subplot(3, 1, 2);  % Create subplot for magnitude
plot(fvec, ysmag);  % Plot the magnitude spectrum
title('Sound Magnitude in Frequency Domain');  % Title for the plot
ylabel('Magnitude');  % Y-axis label

% Plot phase in frequency domain
subplot(3, 1, 3);  % Create subplot for phase
plot(fvec, ysphase);  % Plot the phase spectrum
title('Sound Phase in Frequency Domain');  % Title for the plot
ylabel('Phase');  % Y-axis label

t = linspace(0, sec, sec * fs + 1);  % Update time vector for convolution
t = t';  % Transpose for proper shape

%....................................................
% 2) Channel
% Choose the impulse response
fprintf('Starting second stage: Channel\n');
Type = menu('Choose the impulse response you want to perform', ...
              'Delta function', 'exp(-2pi*5000t)', ...
              'exp(-2pi*1000t)', 'The graphed impulse response');
switch(Type)
    case 1
        % 1) Delta function
        h_1 = zeros(sec * fs + 1, 1);  % Initialize impulse response
        h_1(1) = 1;  % Delta function
        yt = conv(y, h_1);  % Convolve input signal with impulse response
        t = linspace(0, sec, length(yt))';  % Update time vector for output
    case 2
        % 2) exp(-2pi*5000t)
        h_2 = exp(-10000 * pi * t);  % Exponential decay impulse response
        yt = conv(y, h_2);  % Convolve input signal with impulse response
        t = linspace(0, sec, length(yt))';  % Update time vector for output
    case 3
        % 3) exp(-2pi*1000t)
        h_3 = exp(-2000 * pi * t);  % Exponential decay impulse response
        yt = conv(y, h_3);  % Convolve input signal with impulse response
        t = linspace(0, sec, length(yt))';  % Update time vector for output
    case 4
        % 4) Custom impulse response
        h_4 = zeros(sec * fs + 1, 1);  % Initialize custom impulse response
        h_4(1) = 1;  % Set first sample
        h_4(fs + 1) = 0.5;  % Set second sample
        yt = conv(y, h_4);  % Convolve input signal with impulse response
        t = linspace(0, sec + 1, length(yt));  % Update time vector for output (due to convolution length)
end

%......................................
% 3) Noise 
% Create the random noise signal
fprintf('The sound is finished\n');
fprintf('Starting third stage: Noise\n');
sigma = input('Please enter the value of sigma: ');  % Get user input for noise level
z = sigma * randn(length(yt), 1);  % Generate random noise
yt = yt + z;  % Add noise to the convoluted signal
fprintf('The sound is playing after adding the noise\n');

% Play the signal after adding noise
sound(yt, fs);  % Play the noisy signal
pause(sec);  % Pause for the duration of the sound

% Plot signal with noise in time domain
figure('Name', 'Signal with Noise', 'NumberTitle', 'on');
subplot(3, 1, 1);  % Create subplot for noisy signal
plot(t, yt);  % Plot the time-domain signal with noise
title('Sound in Time Domain');  % Title for the plot
ylabel('Amplitude');  % Y-axis label
xlabel('Length (in seconds)');  % X-axis label

% Frequency domain analysis of noisy signal
ys = fftshift(fft(yt));  % Compute the FFT of the noisy signal
ysmag = abs(ys);  % Magnitude of the FFT
fvec = linspace(-fs/2, fs/2, length(ysmag));  % Frequency vector
ysphase = angle(ys) * (180 / pi);  % Phase of the FFT in degrees

% Plot magnitude of noisy signal
subplot(3, 1, 2);  % Create subplot for magnitude
plot(fvec, ysmag);  % Plot the magnitude spectrum of the noisy signal
title('Sound Magnitude in Frequency Domain');  % Title for the plot
ylabel('Magnitude');  % Y-axis label

% Plot phase of noisy signal
subplot(3, 1, 3);  % Create subplot for phase
plot(fvec, ysphase);  % Plot the phase spectrum of the noisy signal
title('Sound Phase in Frequency Domain');  % Title for the plot
ylabel('Phase');  % Y-axis label

fprintf('Starting stage 4: Receiving\n');

% Remove noise from signal using filtering
u = length(ys) / fs;  % Calculate duration based on length of FFT
x1 = u * ((fs / 2) - 3.4 * 1000);  % Calculate cutoff frequency for filtering
ys([1:x1 length(ys)-x1+1:length(ys)]) = 0;  % Zero out frequencies outside cutoff

signal = ys;  % Filtered signal in frequency domain

% Inverse FFT to obtain time-domain signal after noise removal
finalsignal = real(ifft(ifftshift(signal)));  % Inverse FFT and retain real part
fprintf('The sound is playing after trying to remove the noise\n');

% Play the signal after attempting to remove noise
sound(finalsignal, fs);  % Play the filtered signal
pause(sec);  % Pause for the duration of the sound

% Plot after removing noise
figure('Name', 'After Removing Noise', 'NumberTitle', 'on');
subplot(3, 1, 1);  % Create subplot for final signal
plot(t, finalsignal);  % Plot the final time-domain signal
title('Sound in Time Domain');  % Title for the plot
ylabel('Amplitude');  % Y-axis label
xlabel('Length (in seconds)');  % X-axis label

% Frequency domain analysis of final signal
ysmag = abs(signal);  % Magnitude of the final FFT
ysphase = angle(signal) * (180 / pi);  % Phase of the final FFT in degrees

% Plot magnitude of final signal
subplot(3, 1, 2);  % Create subplot for magnitude
plot(fvec, ysmag);  % Plot the magnitude spectrum of the final signal
title('Sound Magnitude in Frequency Domain');  % Title for the plot
ylabel('Magnitude');  % Y-axis label

% Plot phase of final signal
subplot(3, 1, 3);  % Create subplot for phase
plot(fvec, ysphase);  % Plot the phase spectrum of the final signal
title('Sound Phase in Frequency Domain');  % Title for the plot
ylabel('Phase');  % Y-axis label