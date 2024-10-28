function JPEGRes = QuantJPEG(splitDCT, DCTQ, scaling)
    % QuantJPEG performs quantization on DCT-transformed image blocks.
    %
    % Inputs:
    %   splitDCT : 4D array containing DCT-transformed image blocks
    %   DCTQ     : 8x8 quantization matrix
    %   scaling   : Scaling factor to modify the quantization matrix
    %
    % Output:
    %   JPEGRes  : 4D array containing the quantized DCT coefficients

    T = scaling * DCTQ;  % Scale the quantization matrix by the scaling factor
    [l, m, row, col] = size(splitDCT);  % Get the dimensions of the input DCT blocks

    % Loop over each block in the 4D array
    for i = 1:row
        for j = 1:col
            subIm = double(splitDCT(:,:,i,j));  % Convert the current DCT block to double precision
            JPEGRes(:,:,i,j) = round(subIm ./ T);  % Quantize the DCT coefficients by dividing by the scaled quantization matrix and rounding
        end
    end
end
