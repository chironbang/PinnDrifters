clear, clc, close all
data_file = "roi_uv_true_pred.mat"; % This contains 
% the both the ground truth and the PINN prediction. It needs to be loaded
% too if you want to compute statistics for IDW 
load(data_file);
% data_file = "idw_output.mat"; % This contains the
% prediction from the Inverse Distance Weighting method

% load(data_file);

% pred_u = idw_u(:, :, 1:30);
% pred_v = idw_v(:, :, 1:30);

exact_u = exact_u(:, :, 1:30);
exact_v = exact_v(:, :, 1:30);

n_frames = size(exact_u, 3);



%% Computing Root Mean Squared Error


rmse_u_values = compute_rmse(pred_u, exact_u);
rmse_v_values = compute_rmse(pred_v, exact_v);


%% Computing MS-SSIM

% Compute MS-SSIM for SC-PINN
ssim_u_values = compute_multissim(pred_u, exact_u);
ssim_v_values = compute_multissim(pred_v, exact_v);


%% Computing Correlation Coefficients

% Compute CC for SC-PINN
corr_coeff_u_values = compute_cc(pred_u, exact_u);
corr_coeff_v_values = compute_cc(pred_v, exact_v);

%% Compute mean, and std for every metric
% Training Period

% SSIM for u and v
mean_ssim_u = mean(ssim_u_values);
std_ssim_u = std(ssim_u_values);

mean_ssim_v = mean(ssim_v_values);
std_ssim_v = std(ssim_v_values);

% RMSE for u and v
mean_rmse_u = mean(rmse_u_values);
std_rmse_u = std(rmse_u_values);

mean_rmse_v = mean(rmse_v_values);
std_rmse_v = std(rmse_v_values);

% Correlation Coefficient for u and v
mean_corr_coeff_u = mean(corr_coeff_u_values);
std_corr_coeff_u = std(corr_coeff_u_values);

mean_corr_coeff_v = mean(corr_coeff_v_values);
std_corr_coeff_v = std(corr_coeff_v_values);



% SSIM
fprintf('Training Period:\n');
fprintf('MS-SSIM (u): Mean=%.4f, Std=%.4f\n', mean_ssim_u, std_ssim_u);
fprintf('MS-SSIM (v): Mean=%.4f, Std=%.4f\n', mean_ssim_v, std_ssim_v);




% CC
fprintf('Training Period:\n');
fprintf('CC (u): Mean=%.4f, Std=%.4f\n', mean_corr_coeff_u, std_corr_coeff_u);
fprintf('CC (v): Mean=%.4f, Std=%.4f\n', mean_corr_coeff_v, std_corr_coeff_v);



% RMSE
fprintf('Training Period:\n');
fprintf('RMSE (u): Mean=%.4f, Std=%.4f\n', mean_rmse_u, std_rmse_u);
fprintf('RMSE (v): Mean=%.4f, Std=%.4f\n', mean_rmse_v, std_rmse_v);


