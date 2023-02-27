load fp_lin_matrices_fit3.mat

disp(' ');
disp('--------1--------');
eigenvalues_A = eig(A);

disp('Matrix A eigenvalues:');
disp(eigenvalues_A');

disp(['Real part:' num2str(real(eigenvalues_A)')]);
disp(['Im part:' num2str(imag(eigenvalues_A)')]);

disp(' ');
disp('--------2--------');
Contr = ctrb(A, B);
disp('Controllability matrix:');
disp(Contr);
fprintf('C rank: %d\n', rank(Contr));

disp(' ');
disp('--------3--------');
disp('1) Case: x3 is the output.');
C = [0 0 1 0 0];
O = obsv(A,C);
disp('Observabillity matrix:');
disp(O);
fprintf('O rank: %d\n', rank(O));

disp(' ');
disp('2) Case: x1 and x3 are the output.');
C = [1 0 1 0 0];
O = obsv(A,C);
disp('Observabillity matrix:');
disp(O);
fprintf('O rank: %d\n', rank(O));

disp('');
disp('--------------4------------');
disp(size(D));
D = zeros(1);
% D = [0, 0, 0, 0, 0]
[NUM, DEN] = ss2tf(A,B,C,D);
sys = tf(NUM, DEN);
disp('Transfer function is:');
sys
disp('Bode plot is : ');
bode(sys)

disp('');
disp('--------------5------------');
Q2 = C.' * C
R = 1
[K1,S,CLP] = lqr(A, B, Q2, R)

temp = A - B * K1;
eig_t = eig(temp);
disp('Eigenvalues:');
disp(eig_t)

disp(['Real part:' num2str(real(eig_t)')]);
disp(['Im part:' num2str(imag(eig_t)')]);

% Furuta pendulum - State feedback test
%______________________________________________________________________
Qr = diag([10,0,1,0,0]); %Weight Matrix for x
Rr = 1; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain
%----------------------------------------------------------------------
% Simulate controller
x = [0.1 0 0 0 0]';
D = [0 0 0 0 0]';
T = 2; % Time duration of the simulation
% u = -K * x0;
sim('statefdbk', T);
gg = plot(t, x);
set(gg, 'LineWidth', 1.5)
gg = xlabel('Time (s9');
set(gg, 'Fontsize', 14);
gg = ylabel('\beta (rad)');
set(gg, 'Fontsize', 14);
%----------------------------------------------------------------------
% End of file

