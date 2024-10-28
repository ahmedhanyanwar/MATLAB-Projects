function rescaleIm = rescaling(QuntBlock, scaling, DCTQ)
    % rescaling rescales the quantized DCT coefficients back to their original values.
    %
    % Inputs:
    %   QuntBlock : 4D array containing the quantized DCT coefficients
    %   scaling    : Scaling factor used during quantization
    %   DCTQ      : 8x8 quantization matrix
    %
    % Output:
    %   rescaleIm : 4D array containing the rescaled DCT coefficients

    T = scaling * DCTQ;  % Scale the quantization matrix by the scaling factor

    [l, m, row, col] = size(QuntBlock);  % Get the dimensions of the input quantized blocks

    % Loop over each block in the 4D array
    for i = 1:row
        for j = 1:col
            subIm = double(QuntBlock(:,:,i,j));  % Convert the current quantized block to double precision
            rescaleIm(:,:,i,j) = subIm .* T;  % Rescale the quantized coefficients back to their original values
        end
    end
end
