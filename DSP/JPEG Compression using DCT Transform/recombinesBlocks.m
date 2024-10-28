function JPEGImage = recombinesBlocks(resIDCT)
    % recombinesBlocks reconstructs the full image from its DCT-inverse blocks.
    %
    % Input:
    %   resIDCT : 4D array containing the inverse DCT-transformed image blocks
    %
    % Output:
    %   JPEGImage : 2D array representing the reconstructed grayscale image

    blockSize = 8;  % Define the size of each block (8x8 for JPEG)

    [l, m, row, col] = size(resIDCT);  % Get the dimensions of the input blocks
    JPEGImage = zeros(row * blockSize, col * blockSize);  % Initialize the output image with zeros

    % Loop over each block in the 4D array
    for i = 1:row
        for j = 1:col
            % Place the current block into its correct position in the output image
            JPEGImage( (((i - 1) * blockSize) + 1) : (i * blockSize), ...
                        (((j - 1) * blockSize) + 1) : (j * blockSize) ) = resIDCT(:,:,i,j); 
        end
    end

    JPEGImage = uint8(JPEGImage);  % Convert the reconstructed image to uint8 format
end
