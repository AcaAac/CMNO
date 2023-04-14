clear all
close all

disp('');
disp('------------Observer------------');

load('fp_lin_matrices_fit3.mat'); %%Load Matrices A, B, C, D

Qr = diag([10,0,1,0,0]); %Weight Matrix for x
Rr = 1; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain

C = diag([1,1,1,1,1]);
D = [0 0 0 0 0]';

G = eye(size(A)); %Gain of the process noise
Qe = eye(size(A))*10; %Variance of the process errors
Re = eye(5); %Variance of measurement errors

L = lqe(A, G, C, Qe, Re); %Calculate estimator gains (Kalman Filter)

A_obs = A - B*K - L*C;
B_obs = L;
C_obs = -K;
D_obs = [0 0 0 0 0];

%------------
x0 = [0.1 0 0 0 0]';
T = 3; % Time duration of the simulation
sim('observer', T);

%Graphics
%Alpha
figure(1);

gg = plot(t, y(:, 1:1), 'DisplayName','Alpha');
legend('off'); legend('show');
set(gg, 'LineWidth', 1.5);

hold on;

gg = plot(t, y_hat(:, 1:1), 'DisplayName','Alpha\_hat'); 
legend('off'); legend('show');
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (seg)');
set(gg, 'Fontsize', 14);
gg = ylabel('\alpha (rad)');
set(gg, 'Fontsize', 14);

%Beta
figure(2);

gg1 = plot(t, y(:, 2:2), 'DisplayName', 'Beta');
legend('off'); legend('show');
set(gg1, 'LineWidth', 1.5)
hold on;

gg1 = plot(t, y_hat(:, 2:2), 'DisplayName','Beta\_hat'); 
legend('off'); legend('show');
set(gg1, 'LineWidth', 1.5)

gg1 = xlabel('Time (seg)');
set(gg1, 'Fontsize', 14);
gg1 = ylabel('\beta (rad)');
set(gg1, 'Fontsize', 14);

%Alpha_dot
figure(3);

gg = plot(t, y(:, 2:2), 'DisplayName','Alpha velocity');
legend('off'); legend('show');
set(gg, 'LineWidth', 1.5);

hold on;

gg = plot(t, y_hat(:, 2:2), 'DisplayName','Alpha velocity\_hat'); 
legend('off'); legend('show');
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (seg)');
set(gg, 'Fontsize', 14);
gg = ylabel('\alpha velocity (rad/s)');
set(gg, 'Fontsize', 14);

%Beta_dot
figure(4);

gg1 = plot(t, y(:, 4:4), 'DisplayName', 'Beta velocity');
legend('off'); legend('show');
set(gg1, 'LineWidth', 1.5)
hold on;

gg1 = plot(t, y_hat(:, 4:4), 'DisplayName','Beta velocity\_hat'); 
legend('off'); legend('show');
set(gg1, 'LineWidth', 1.5)

gg1 = xlabel('Time (seg)');
set(gg1, 'Fontsize', 14);
gg1 = ylabel('\beta velocity (rad/s)');
set(gg1, 'Fontsize', 14);

%Current
figure(5);

gg1 = plot(t, y(:, 5:5), 'DisplayName', 'I');
legend('off'); legend('show');
set(gg1, 'LineWidth', 1.5)
hold on;

gg1 = plot(t, y_hat(:, 5:5), 'DisplayName','I\_hat'); 
legend('off'); legend('show');
set(gg1, 'LineWidth', 1.5)

gg1 = xlabel('Time (seg)');
set(gg1, 'Fontsize', 14);
gg1 = ylabel('I (A)');
set(gg1, 'Fontsize', 14);
