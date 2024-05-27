function ssim_values = compute_multissim(y_pred, y_true)


n_frames = size(y_true, 3);



% Convert arrays to uint8 in the range [0, 255]
y_true_uint8 = uint8((y_true - min(y_true(:))) / (max(y_true(:)) - min(y_true(:))) * 255);
y_pred_uint8 = uint8((y_pred - min(y_pred(:))) / (max(y_pred(:)) - min(y_pred(:))) * 255);


% Compute frame-by-frame structural similarity for u and v arrays
ssim_values = zeros(size(y_true, 3), 1);

for frame = 1:n_frames
    ssim_values(frame) = multissim(y_true_uint8(:,:,frame), y_pred_uint8(:,:,frame));

end

end