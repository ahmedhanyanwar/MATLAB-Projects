function result = SplitImage(grayImage)
    % SplitImage divides a grayscale image into 8x8 blocks.
    %
    % Input:
    %   grayImage : 2D array representing the grayscale image
    %
    % Output:
    %   result    : 4D array containing the image blocks (each block is 2D)

    blockSize = 8;  % Define the size of each block (8x8 for JPEG)
    [Row, Col] = size(grayImage);  % Get the dimensions of the input grayscale image

    % Loop over the number of blocks in the row and column dimensions
    for i = 1:Row/blockSize
        for j = 1:Col/blockSize
            % Extract the current block from the grayscale image and store it in the result array
            result(:,:,i,j) = grayImage( (((i-1)*blockSize)+1):(i*blockSize), ...
                                          (((j-1)*blockSize)+1):(j*blockSize) );
        end
    end
end
