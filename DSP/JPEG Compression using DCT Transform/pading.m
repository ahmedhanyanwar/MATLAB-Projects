function padGray = pading(grayIm)
    % pading adds padding to a grayscale image to ensure its dimensions are 
    % multiples of 8, which is necessary for block processing in JPEG compression.
    %
    % Input:
    %   grayIm : 2D array representing the grayscale image
    %
    % Output:
    %   padGray : 2D array representing the padded grayscale image

    [row, colum] = size(grayIm);  % Get the dimensions of the input grayscale image
    padrow = 0;  % Initialize padding for rows
    padclo = 0;  % Initialize padding for columns

    % Check if the number of rows is not a multiple of 8
    if (mod(row, 8))
        num = floor(row / 8) + 1;  % Calculate the number of 8-row blocks needed
        padrow = num * 8 - row;  % Calculate the required padding for rows
    end

    % Check if the number of columns is not a multiple of 8
    if (mod(colum, 8))
        num = floor(colum / 8) + 1;  % Calculate the number of 8-column blocks needed
        padclo = num * 8 - colum;  % Calculate the required padding for columns
    end

    % Apply padding only if both row and column dimensions need padding
    if (mod(colum, 8) && mod(row, 8))
        padGray = padarray(grayIm, [padrow, padclo], 0, 'post');  % Pad the image with zeros (black) at the end
    else
        padGray = grayIm;  % No padding required; return the original image
    end
end
