clear all
close all

disp('');
disp('------------Observer------------');

load('fp_lin_matrices_fit3.mat'); %%Load Matrices A, B, C, D

Qr = diag([10,0,1,0,0]); %Weight Matrix for x
Rr = 1; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain

G = eye(size(A)); %Gain of the process noise
Qe = eye(size(A))*10; %Variance of the process errors
Re = eye(2); %Variance of measurement errors

L = lqe(A, G, C, Qe, Re); %Calculate estimator gains (Kalman Filter)

A_obs = A - B*K - L*C;
B_obs = L;
C_obs = -K;
D_obs = [0 0];
disp('Observer poles are : ')
disp(eig(A - L * C))
%------------
x0 = [0.1 0 0 0 0]';
T = 2; % Time duration of the simulation
sim('observer', T);
gg = plot(t, y);
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (seg)');
set(gg, 'Fontsize', 14);
gg = ylabel('\beta (rad)');
set(gg, 'Fontsize', 14);

