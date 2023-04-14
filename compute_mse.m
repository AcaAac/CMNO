function [MSE] = compute_mse(var1, var2)

    error1 = var1.^2;
    error2 = var2.^2;
    MSE = mean(error1) + mean(error2);
end