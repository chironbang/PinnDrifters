function plot_metric(metric_values_idw, metric_values_fr, metric_values_krig, metric_name, quantity_name)
    % Create a figure
    figure;
    

    
    hold on; % Hold the current plot
    
    % Plot SC-PINN metric values
    plot(metric_values_idw, '-o', 'Color', [0.8500 0.3250 0.0980]); % Orange color for SC-PINN
    
    % Plot FR-PINN metric values
    plot(metric_values_fr, '-o', 'Color', [0 0.4470 0.7410]); % Blue color for FR-PINN
    
    % Plot FT-PINN metric values
    plot(metric_values_krig, '-o', 'Color', [0.4660 0.6740 0.1880]); % Green color for FT-PINN
    



    % Customize plot
    title([metric_name ' for ' quantity_name]);
    xlabel('Time (days)');
    ylabel(metric_name);
    legend('PINN', 'IDW', 'Kriging', 'Location', 'northoutside', 'Orientation', 'horizontal', 'FontSize', 6);
    
    % Save the plot as a PNG file in the 'metric_plots' folder
    saveas(gcf, ['metric_plots\' metric_name '_' quantity_name '.png']);
    
    hold off; % Release the current plot
end
