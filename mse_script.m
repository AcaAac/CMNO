close all
clear all
%Change Load Path for different data
load minimize_beta_disregarding_alpha2.mat
   
show_plot = 2; %set to 1 to plot alpha and beta
   
param = pendulum.signals.values;
time = pendulum.time;
   
alpha = param(:,1);
beta = param(:,2);
   
%Clean first 6 secs
time_c = time(6001:numel(time));
alpha_c = alpha(6001:numel(alpha));
beta_c = beta(6001:numel(beta));
     
%Get MSE
MSE = compute_mse(alpha_c, beta_c)
   
    
mse_a = alpha_c.^2; 
mse_a = mean(mse_a);
mse_b = beta_c.^2; 
mse_b = mean(mse_b);
    
     
%Show plots
if show_plot == 1
    figure(1);
    title(['Alpha from Experimental Data - Total MSE: ' num2str(MSE)]); hold on
    pp = plot(time, alpha);
    pp = xlabel('Time [s]');
    pp = ylabel('\alpha [rad]');
    
    hold off
    
    figure(2);
    title(['Beta from Experimental Data - MSE: ' num2str(MSE)]); hold on
    pp = plot(time, beta);
    pp = xlabel('Time [s]');
    pp = ylabel('\beta [rad]');
    
    hold off
    
elseif show_plot == 2
    figure(1);
    legend('off'); legend('show');
    title(['Alpha and Beta from Experimental Data - Total MSE: ' num2str(MSE)]); hold on
    pp = plot(time, alpha, 'DisplayName', ['mse\_a: ' num2str(mse_a)]);
    pp = xlabel('Time [s]');
    pp = ylabel('\alpha and \beta [rad]');
    legend('off'); legend('show');
    
    
    pp = plot(time, beta, 'DisplayName', ['mse\_b: ' num2str(mse_b)]);
    legend('off'); legend('show');
    
    hold off
        
end 