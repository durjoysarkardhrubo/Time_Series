
data = readtable('F:\time series\input.txt');
demand = data.Var2; 


two_month_moving_avg = movmean(demand, [1 0]);



forecast_moving_avg = mean([two_month_moving_avg(end-1) two_month_moving_avg(end)]);


alpha = 0.6; 
smoothed_demand = zeros(size(demand));
smoothed_demand(1) = demand(1); 


for i = 2:length(demand)
    smoothed_demand(i) = alpha * demand(i) + (1 - alpha) * smoothed_demand(i-1);
end


forecast_exponential_smoothing = alpha * demand(end) + (1 - alpha) * smoothed_demand(end);


disp(['Two-month moving average forecast for month eight: ', num2str(forecast_moving_avg)]);
disp(['Exponential smoothing forecast for month eight: ', num2str(forecast_exponential_smoothing)]);


output_file_path = 'F:\time series\forecast_output.txt';
fileID = fopen(output_file_path, 'w');
fprintf(fileID, 'Two-month moving average forecast for month eight: %f\n', forecast_moving_avg);
fprintf(fileID, 'Exponential smoothing forecast for month eight: %f\n', forecast_exponential_smoothing);
fclose(fileID);
