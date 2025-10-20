%% Image Reconstruction for Spatially Heterogeneous Receive Arrays
% Code authors: Guanghui Li, Haicheng Du, Ziwei Chen
% Advisors: Yu An, Jie Tian
% Code date: 2025-10
% Description: This code performs image reconstruction for spatially 
% heterogeneous receive arrays using the Kaczmarz algorithm.

clear; close all; clc;

%% Data Loading
% System matrix: S.mat (complex-valued, size [40, 64])
% Electromagnetic response data: b1.mat to b5.mat (5 test phantoms)

fprintf('Loading system matrix and measurement data...\n');

% Load system matrix
load('S.mat', 'S');  % S: complex-valued system matrix [40, 64]

% Load measurement data (select one phantom for reconstruction)
phantom_number = 1;  % Can be changed from 1 to 5
b_filename = sprintf('b%d.mat', phantom_number);
b = [];
load(b_filename);  % b: electromagnetic response data

fprintf('System matrix S loaded: size = %dx%d\n', size(S));
fprintf('Measurement data %s loaded\n', b_filename);

%% Step 1: System Matrix Interpolation
% Interpolate S from [40, 64] to [15, 15] resolution
target_size = [15,15];
for i = 1:40
    tmp = S(i,:);
    tmp = reshape(tmp,[8,8]);
    tmp_interp = interp2(tmp,1);
    S_interp(i,:) = tmp_interp(:);
end

fprintf('System matrix interpolated to: %dx%d\n', size(S_interp));

%% Step 2: Image Reconstruction using Kaczmarz Algorithm
% Parameters for reconstruction
max_iterations = 1000;    % Maximum number of iterations
regularization_param = 5e-4;  % Regularization parameter
shuff = 1;     % Relaxation parameter
enforceReal = 1;  % Enable non-negativity constraint
enforcePositive = 1;         % Enable verbose output

fprintf('Starting Kaczmarz reconstruction...\n');
fprintf('Parameters: iterations=%d, regularization=%.2e\n', ...
        max_iterations, regularization_param);

% Perform reconstruction
% *** Notes: change the b number ***
c_reconstructed = kaczmarzReg(S_interp, b1, max_iterations, ...
                             regularization_param, shuff, ...
                             enforceReal, enforcePositive);

% Reshape to image dimensions
reconstructed_image = reshape(c_reconstructed, target_size);

fprintf('Reconstruction completed.\n');

%% Step 3: Visualization
imagesc(reconstructed_image);
axis equal;axis tight;colorbar;colormap(viridis());axis off;
set(gca, 'FontSize', 20);

%% Display reconstruction metrics
fprintf('\n=== Reconstruction Metrics ===\n');
fprintf(strcat("Phantom number: ", b_filename,"\n"));
fprintf('Residual norm: %.6f\n', norm(S_interp * c_reconstructed - b1));
fprintf('Image size: %dx%d\n', target_size);
fprintf('Maximum pixel value: %.6f\n', max(abs(reconstructed_image(:))));
fprintf('Minimum pixel value: %.6f\n', min(abs(reconstructed_image(:))));

fprintf('\nReconstruction completed successfully.\n');