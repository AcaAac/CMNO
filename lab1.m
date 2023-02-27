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
C_temp = [0 0 1 0 0];
O = obsv(A,C_temp);
disp('Observabillity matrix:');
disp(O);
fprintf('O rank: %d\n', rank(O));

disp(' ');
disp('2) Case: x1 and x3 are the output.');
C_temp = [1 0 1 0 0];
O = obsv(A,C_temp);
disp('Observabillity matrix:');
disp(O);
fprintf('O rank: %d\n', rank(O));

disp('');
disp('-------------4-------------');
disp(size(D));
D = zeros(1);
% D = [0, 0, 0, 0, 0]
[NUM, DEN] = ss2tf(A,B,C_temp,D);
sys = tf(NUM, DEN);
disp('Transfer function is:');
sys
disp('Bode plot is : ');
bode(sys)

disp('');
disp('-------------5------------');
Q2 = C_temp.' * C_temp
R = 1
[K1,S,CLP] = lqr(A, B, Q2, R)

disp('Vector of gains:');
disp(K1);

temp = A - B * K1;
eig_t = eig(temp);
disp('Eigenvalues:');
disp(eig_t)

disp(['Real part:' num2str(real(eig_t)')]);
disp(['Im part:' num2str(imag(eig_t)')]);

