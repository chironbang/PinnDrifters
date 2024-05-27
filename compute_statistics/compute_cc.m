function cc_values = compute_cc(y_pred, y_true)

n_frames = size(y_true, 3);
cc_values = zeros(size(y_true, 3), 1);

for frame = 1:n_frames
    cc_values(frame) = corr2(y_true(:,:,frame), y_pred(:,:,frame));

end

end