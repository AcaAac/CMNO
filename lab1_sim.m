disp('');
disp('-------------6------------');

% Furuta pendulum - State feedback test
%______________________________________________________________________
load('fp_lin_matrices_fit3.mat'); %%Load Matrices A, B, C, D


Qr = diag([10,0,1,0,0]); %Weight Matrix for x
Rr = 1; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain
%----------------------------------------------------------------------
% Simulate controller
x0 = [0.1 0 0 0 0]';
D = [0 0 0 0 0]';
C = eye(5);
T = 2; % Time duration of the simulation
sim('statefdbk', T);
% 5 state graphic creator
figure(1);
gg = plot(t, x(:,1));
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (s)');
set(gg, 'Fontsize', 14);
gg = ylabel('\alpha (rad)');
set(gg, 'Fontsize', 14);
% second state
figure(2);
gg = plot(t, x(:,2));
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (s)');
set(gg, 'Fontsize', 14);
gg = ylabel('\alpha velocity (rad s^-1)');
set(gg, 'Fontsize', 14);
% third state
figure(3);
gg = plot(t, x(:,3));
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (s)');
set(gg, 'Fontsize', 14);
gg = ylabel('\beta (rad)');
set(gg, 'Fontsize', 14);
% fourth state
figure(4);
gg = plot(t, x(:,4));
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (s)');
set(gg, 'Fontsize', 14);
gg = ylabel('\beta velocity(rad s^-1)');
set(gg, 'Fontsize', 14);
% observer state
figure(5);
gg = plot(t, x(:,5));
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (s)');
set(gg, 'Fontsize', 14);
gg = ylabel('i (A)');
set(gg, 'Fontsize', 14);
% output voltage
figure(6)
gg = plot(t, u);
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (s)');
set(gg, 'Fontsize', 14);
gg = ylabel('u (V)');
set(gg, 'Fontsize', 14);
%----------------------------------------------------------------------
% End of file 