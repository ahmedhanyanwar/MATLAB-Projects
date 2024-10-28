# DCT Transform and JPEG Compression

## Overview

This project implements the Discrete Cosine Transform (DCT) for image compression, specifically using the JPEG compression technique. The DCT is a widely used transform in signal processing and image compression, effectively reducing the amount of data required to represent an image while preserving visual quality.

## Table of Contents

- [Project Description](#project-description)
- [Requirements](#requirements)
- [File Descriptions](#file-descriptions)
- [How to Use](#how-to-use)

## Project Description

The main goal of this project is to demonstrate the process of JPEG image compression using the DCT. The implementation includes the following steps:

1. **Image Loading**: Load a grayscale image for processing.
2. **Block Splitting**: Divide the image into 8x8 blocks.
3. **DCT Transformation**: Apply the DCT to each block.
4. **Quantization**: Quantize the DCT coefficients using a quantization matrix.
5. **Inverse DCT Transformation**: Apply the inverse DCT to the quantized coefficients to reconstruct the image.
6. **Image Reconstruction**: Recombine the blocks into a single image.
7. **Image Saving**: Save the original and compressed images.

## Requirements

- MATLAB (or Octave)
- Image Processing Toolbox (optional, for certain functions)

## File Descriptions

- `main.mlx`: The main live script that executes the JPEG compression workflow.
- `findDCTMatrix.m`: Computes the DCT matrix used for transformation.
- `SplitImage.m`: Divides the grayscale image into 8x8 blocks.
- `DCTBlock.m`: Applies the DCT or inverse DCT to each block.
- `QuantJPEG.m`: Quantizes the DCT coefficients using a scaling factor and quantization matrix.
- `rescaling.m`: Rescales the quantized coefficients back to their original values.
- `recombinesBlocks.m`: Combines the inverse DCT blocks to reconstruct the image.
- `pading.m`: Pads the image if its dimensions are not multiples of 8.

## How to Use

1. Load a grayscale image (e.g., `lena.jpeg`) in the `main.mlx` script.
2. Run the `main.mlx` live script in MATLAB.
3. The original image will be saved as `lenaBefore.jpeg`, and the compressed image will be saved as `lenaAfter.jpeg`.
