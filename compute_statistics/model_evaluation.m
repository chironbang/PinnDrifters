clear, clc, close all
%% Loading Data
% Loading pinn predictions
data_file = "roi_uv_true_pred.mat"; % PINN predictions
load(data_file);



% OI code
pred_u_pinn = pred_u; 
pred_v_pinn = pred_v; 

% Loading idw
data_file = "idw_output.mat";
load(data_file);

pred_u_idw = idw_u;
pred_v_idw = idw_v;



% Loading kriging
data_file = "kriging_output.mat";
load(data_file);

pred_u_krig = krig_u;
pred_v_krig = krig_v;


%% Computing Root Mean Squared Error



% Compute RMSE for PINN
rmse_u_pinn = compute_rmse(pred_u_pinn, exact_u);
rmse_v_pinn = compute_rmse(pred_v_pinn, exact_v);


% Compute RMSE for IDW
rmse_u_idw = compute_rmse(pred_u_idw, exact_u);
rmse_v_idw = compute_rmse(pred_v_idw, exact_v);


% Compute RMSE for Kriging
rmse_u_krig = compute_rmse(pred_u_krig, exact_u);
rmse_v_krig = compute_rmse(pred_v_krig, exact_v);

%% Computing SSIM

% Compute SSIM for the baseline % There is no baseline when using OI
% ssim_u_baseline = compute_ssim(u_idwee_run, exact_u);
% ssim_v_baseline = compute_ssim(v_idwee_run, exact_v);

% Compute SSIM for PINN
ssim_u_pinn = compute_multissim(pred_u_pinn, exact_u);
ssim_v_pinn = compute_multissim(pred_v_pinn, exact_v);


% Compute SSIM for IDW
ssim_u_idw = compute_multissim(pred_u_idw, exact_u);
ssim_v_idw = compute_multissim(pred_v_idw, exact_v);


% Compute SSIM for Kriging
ssim_u_krig = compute_multissim(pred_u_krig, exact_u);
ssim_v_krig = compute_multissim(pred_v_krig, exact_v);

%% Computing Correlation Coefficients




% Compute CC for PINN
cc_u_pinn = compute_cc(pred_u_pinn, exact_u);
cc_v_pinn = compute_cc(pred_v_pinn, exact_v);


% Compute CC for IDW
cc_u_idw = compute_cc(pred_u_idw, exact_u);
cc_v_idw = compute_cc(pred_v_idw, exact_v);


% Compute CC for Kriging
cc_u_krig = compute_cc(pred_u_krig, exact_u);
cc_v_krig = compute_cc(pred_v_krig, exact_v);
% Create metric_plots folder if it doesn't exist
if ~exist('metric_plots', 'dir')
    mkdir('metric_plots');
end

%% Plotting

% Create the 'metric_plots' folder if it doesn't exist
% if ~exist('metric_plots', 'dir')
%     mkdir('metric_plots');
% end

% Plot RMSE for u  % There is no baseline when using OI
plot_metric(rmse_u_pinn, rmse_u_idw, rmse_u_krig, 'RMSE', 'u');

% Plot RMSE for v
plot_metric(rmse_v_pinn, rmse_v_idw, rmse_v_krig, 'RMSE', 'v');

% Plot SSIM for u
plot_metric(ssim_u_pinn, ssim_u_idw, ssim_u_krig, 'MS-SSIM', 'u');

% Plot SSIM for v
plot_metric(ssim_v_pinn, ssim_v_idw, ssim_v_krig, 'MS-SSIM', 'v');

% Plot Correlation Coefficient for u
plot_metric(cc_u_pinn, cc_u_idw, cc_u_krig, 'Correlation Coefficient', 'u');

% Plot Correlation Coefficient for v
plot_metric(cc_v_pinn, cc_v_idw, cc_v_krig, 'Correlation Coefficient', 'v');


%% Taylor diagrams
% Plot Taylor diagram for each day
% for t = 1:1
%     % Create a new figure for each day
%     figure;
% 
%     % Plot Taylor diagram for the current day
%     % Use scatter plot to represent each model's point
%     scatter(0, 1, 'Marker', 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b'); % Reference dataset
%     hold on;
%     scatter(cc_u_pinn(t), sqrt((1 - cc_u_pinn(t)^2)/2), 'Marker', 's', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r'); % PINN
%     scatter(cc_u_idw(t), sqrt((1 - cc_u_idw(t)^2)/2), 'Marker', 'd', 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g'); % IDW
%     scatter(cc_u_krig(t), sqrt((1 - cc_u_krig(t)^2)/2), 'Marker', '>', 'MarkerEdgeColor', 'm', 'MarkerFaceColor', 'm'); % U-Krigging
% 
%     % Set title and labels
%     title(sprintf('Taylor Diagram for Day %d', t));
%     xlabel('Correlation Coefficient');
%     ylabel('Standard Deviation Ratio');
%     legend('Reference', 'PINN', 'IDW', 'U-Krigging');
%     axis equal; % Set axes aspect ratio to equal
%     grid on; % Add grid lines
% end