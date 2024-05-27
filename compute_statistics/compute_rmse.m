function rmse_values = compute_rmse(y_pred, y_true)

n_frames = size(y_true, 3);
rmse_values = zeros(size(y_true, 3), 1);

for frame = 1:n_frames
    rmse_values(frame) = sqrt(mean((y_true(:,:,frame) - y_pred(:,:,frame)).^2, 'all'));

end

end