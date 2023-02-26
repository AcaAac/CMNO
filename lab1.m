load fp_lin_matrices_fit3.mat

disp(' ')
disp('--------1--------')
eigenvalues_A = eig(A);

disp('Matrix A eigenvalues:')
disp(eigenvalues_A')

disp(['Real part:' num2str(real(eigenvalues_A)')])
disp(['Im part:' num2str(imag(eigenvalues_A)')])

disp(' ')
disp('--------2--------')
Contr = ctrb(A, B);
disp('Controllability matrix:');
disp(Contr);
fprintf('C rank: %d\n', rank(Contr));

disp(' ')
disp('--------3--------')
disp('1) Case: x3 is the output.')
C = [0 0 1 0 0];
O = obsv(A,C);
disp('Observabillity matrix:')
disp(O);
fprintf('O rank: %d\n', rank(O));

disp(' ')
disp('2) Case: x1 and x3 are the output.')
C = [1 0 1 0 0];
O = obsv(A,C);
disp('Observabillity matrix:')
disp(O);
fprintf('O rank: %d\n', rank(O));
