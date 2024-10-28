function C8 = findDCTMatrix()
    % findDCTMatrix computes the 8x8 Discrete Cosine Transform (DCT) matrix.
    %
    % Output:
    %   C8 : 8x8 DCT matrix used for DCT transformation

    r = [0:7];  % Define row indices for the DCT matrix (0 to 7)
    K = [1:7]';  % Define column indices for cosine calculation (1 to 7)
    
    u0 = sqrt(1/8);  % Coefficient for the first row (DC component)
    
    % Construct the first row of the DCT matrix (DC component)
    C0 = [u0 u0 u0 u0 u0 u0 u0 u0];  % All values equal to u0

    % Compute the remaining rows of the DCT matrix for AC components
    C7 = sqrt(2/8) .* cos((pi/8) * (K * (r + 0.5)));  % Calculate the AC components

    % Combine the DC and AC components to form the complete DCT matrix
    C8 = [C0; C7];  % Concatenate the first row with the remaining rows
end
