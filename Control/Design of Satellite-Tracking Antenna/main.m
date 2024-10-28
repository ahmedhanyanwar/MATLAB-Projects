% Define system parameters
J = 600000; % Inertia (𝑘𝑔·𝑚²)
B = 20000;  % Damping coefficient (N·m·sec == 𝑘𝑔·𝑚²/sec)

% a) Define the transfer function TF = K/(Js^2 + Bs + K)
K = 1;  % Feedback gain
TF = tf(K, [J, B, K]); % Create transfer function
TFOr = tf(K/J, [1, B/J, K/J]); % Equivalent transfer function

%% 
% b) Obtain the state-space representation for the closed-loop system for K = 1
sys_TF = ss(TF); % Convert transfer function to state-space representation
% The state-space equations are given by:
% dx/dt = A * x(t) + B * θr(t)
% θ(t) = C * x(t) + D * θr(t)

% c) Calculate the maximum value of K for stability of the closed-loop system
K_max = inf;  % Initialize maximum feedback gain
TF_max = tf(K_max, [J, B, K_max]); % Define transfer function for maximum K
stability = isstable(TF_max); % Check if the system is stable

% d) Find the maximum value of K for overshoot Mp <= 10%
tempVar = log(0.1) / pi; % Calculate tempVar for damping ratio
zeta = sqrt(tempVar^2 / (1 + tempVar^2)); % Damping ratio
K_Mp_10 = B^2 / (4 * J * zeta^2); % Maximum feedback gain for Mp <= 10%
TF_Mp_10 = tf(K_Mp_10, [J, B, K_Mp_10]); % Define transfer function
sysprop = stepinfo(TF_Mp_10, 'RiseTimeThreshold', [0 1]); % Get step response properties
sysprop.Overshoot; % Display overshoot

% e) Find values of K that provide a rise time less than 80 seconds
syms K_Tr;  % Define symbolic variable for K
zeta_tr = B / (2 * sqrt(K_Tr * J)); % Calculate damping ratio for rise time
Wn = sqrt(K_Tr / J); % Natural frequency
Wd = Wn * sqrt(1 - zeta_tr^2); % Damped natural frequency
eqn = (pi - acos(zeta_tr)) / Wd == 80; % Equation for rise time
K_tr_80 = double(vpasolve(eqn, K_Tr)); % Solve for K
TF_tr_80 = tf(K_tr_80, [J, B, K_tr_80]); % Define transfer function
sysprop_tr = stepinfo(TF_tr_80, 'RiseTimeThreshold', [0 1]); % Get step response properties
sysprop_tr.RiseTime; % Display rise time

% f) Plot the step response for K = 200, 400, 1000, and 2000
K_toplot = [200, 400, 1000, 2000]; % Feedback gains to plot
for i = 1:length(K_toplot)
    TF_temp = tf(K_toplot(i), [J, B, K_toplot(i)]); % Define transfer function for current K
    sysprop_temp = stepinfo(TF_temp, 'RiseTimeThreshold', [0 1]); % Get step response properties
    Mp = sysprop_temp.Overshoot; % Calculate overshoot
    Tr = sysprop_temp.RiseTime; % Calculate rise time
    figure(); % Create new figure
    stepplot(TF_temp); % Plot step response
    title("Step Response at K = " + num2str(K_toplot(i)) + "."); % Title for plot
    fprintf("\nAt K = %f\nThe max overshoot = %f\nThe rise time = %f\n", K_toplot(i), Mp, Tr); % Print results
end

% g) Plot the poles and zeros locations for each value of K
for i = 1:length(K_toplot)
    TF_temp = tf(K_toplot(i), [J, B, K_toplot(i)]); % Define transfer function
    figure(); % Create new figure
    pzplot(TF_temp); % Plot poles and zeros
    title("Poles & Zeros at K = " + num2str(K_toplot(i)) + "."); % Title for plot
    a = findobj(gca, 'type', 'line'); % Find line objects in the current axes
    set(a(2), 'linewidth', 5, 'markersize', 10); % Customize second line (zeros)
    set(a(3), 'linewidth', 5, 'markersize', 10); % Customize third line (poles)
    grid; % Add grid to plot
end

%% Root Locus Analysis
for i = 1:length(K_toplot)
    TF_temp = tf(K_toplot(i), [J, B, K_toplot(i)]); % Define transfer function
    figure(); % Create new figure
    rlocus(TF_temp); % Plot root locus
    title("Root Locus at K = " + num2str(K_toplot(i)) + "."); % Title for plot
    grid; % Add grid to plot
end

% h) Find the steady-state error for each value of K
for i = 1:length(K_toplot)
    TF_temp = tf(K_toplot(i), [J, B, K_toplot(i)]); % Define transfer function
    [y, t] = step(TF_temp); % Get the response of the system to a step with amplitude SP
    sserror = abs(1 - y(end)); % Calculate steady-state error
end

syms S; % Define symbolic variable S
for i = 1:length(K_toplot)
    G_s = K_toplot(i) / (J * S^2 + B * S); % Define transfer function in s-domain
    Kp = limit(G_s, S, 0);   % Position constant, Kp
    Kv = limit(S * G_s, S, 0); % Velocity constant, Kv
    Ka = limit(S^2 * G_s, S, 0); % Acceleration constant, Ka
    fprintf("The steady-state error at K = %d\n", K_toplot(i)); % Print K value
    steadyStateError_P = 1 / (1 + Kp); % Steady-state error for position
    steadyStateError_V = 1 / Kv; % Steady-state error for velocity
    steadyStateError_A = 1 / Ka; % Steady-state error for acceleration
end