function blockDCT = DCTBlock(splits, C8, parameter)
    % DCTBlock computes the Discrete Cosine Transform (DCT) or its inverse on image blocks.
    % 
    % Inputs:
    %   splits   : 4D array containing the image blocks (each block is 2D)
    %   C8       : DCT matrix (unused in this implementation but can be included)
    %   parameter: If 0, perform DCT; if 1, perform inverse DCT (IDCT)
    % 
    % Output:
    %   blockDCT : 4D array containing the DCT or IDCT transformed blocks

    [l, m, row, col] = size(splits);  % Get the dimensions of the input blocks

    % Uncomment this section if you wish to use the transpose of C8 for IDCT
    % if parameter ~= 0
    %     C8 = C8';  % Transpose C8 if performing IDCT
    % end

    % Loop over each block in the 4D array
    for i = 1:row
        for j = 1:col
            subIm = double(splits(:,:,i,j));  % Convert the current block to double precision

            % Perform DCT or IDCT based on the value of 'parameter'
            if parameter == 0
                blockDCT(:,:,i,j) = dct2(subIm);  % Apply 2D DCT to the block
            else
                blockDCT(:,:,i,j) = idct2(subIm);  % Apply 2D IDCT to the block
            end
        end
    end
end
