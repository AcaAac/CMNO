clearvars;
close all;
load('fp_lin_matrices_fit3.mat');

%C saca os estados correspondentes a alfa e beta
T = 5;
ganhos = logspace(-1, 3, 8); %array c/os ganhos

%Valor a alterar
com_observador = 0;
lqr_ou_lqe = 0; %bool-> 0:= lqr, 1:= lqe
Q_R_G = 1;      %int-> 0:= Q, 1:= R, 2:= G
idx = 3;        %idx da matriz Q 

%SETUP classico
%lqr
Qr = diag([10,0,1,0,0]); %Weight Matrix for x
Rr = 1; %Weight for the input variable

K = lqr(A, B, Qr, Rr); %Calculate feedback gain

%lqe
G = eye(size(A)); %Gain of the process noise
Qe = eye(size(A))*10; %Variance of the process errors
Re = eye(2); %Variance of measurement errors

L = lqe(A, G, C, Qe, Re); %Calculate estimator gains (Kalman Filter)

%Observador
A_obs = A - B*K - L*C;
B_obs = L;
C_obs = -K;
D_obs = [0 0];

%Conds Iniciais
x0 = [0.1 0 0 0 0]';

figure(1);
title(['Alfa (ex 6 ou 8: ' num2str(com_observador) ', lqr ou lqe: ' num2str(lqr_ou_lqe) ', Q R G:' num2str(Q_R_G) ')']);
hold on;

figure(2);
title(['Beta (ex 6 ou 8: ' num2str(com_observador) ', lqr ou lqe: ' num2str(lqr_ou_lqe) ', Q R G:' num2str(Q_R_G) ')']);
hold on;

Qr_aux = Qr;
Qe_aux = Qe;
G_aux = G;
for i = 1:numel(ganhos)
    
    Qr = Qr_aux;
    Qe = Qe_aux;
    G = G_aux;
    
    if lqr_ou_lqe == 0          %Varia os ganhos do lqr
        if  Q_R_G == 0          %Varia o Qr
            Qr(idx, idx) = ganhos(i);
        elseif Q_R_G == 1       %Varia o Rr
            Rr = ganhos(i);
        end
        
        K = lqr(A, B, Qr, Rr); %Calculate feedback gain
        
        if com_observador == 0  
            C = eye(5);
            D = [0 0 0 0 0]';
            
            sim('statefdbk',T);
            
            figure(1);
            if Q_R_G == 0
            gg = plot(t, x(:, 1:1), 'DisplayName',['Qr(' num2str(idx) ',' num2str(idx) ') = ' num2str(ganhos(i))]);
            elseif Q_R_G == 1
            gg = plot(t, x(:, 1:1), 'DisplayName',['R = ' num2str(ganhos(i))]);
            end
            
            set(gg, 'LineWidth', 1.5);
            gg = xlabel('Time (seg)');
            set(gg, 'Fontsize', 14);
            gg = ylabel('\alpha (rad)');
            set(gg, 'Fontsize', 14);
            legend('off'); legend('show');
            
            figure(2);
            
            if Q_R_G == 0
                gg = plot(t, x(:, 3:3), 'DisplayName',['Qr(' num2str(idx) ',' num2str(idx) ') = ' num2str(ganhos(i))]);
            elseif Q_R_G == 1
                gg = plot(t, x(:, 3:3), 'DisplayName',['R = ' num2str(ganhos(i))]);
            end
            
            legend('off'); legend('show');
            set(gg, 'LineWidth', 1.5);
            gg = xlabel('Time (seg)');
            set(gg, 'Fontsize', 14);
            gg = ylabel('\beta (rad)');
            set(gg, 'Fontsize', 14);
        else
            sim('observer', T);
            
            figure(1);
            if Q_R_G == 0
                gg = plot(t, y(:, 1:1), 'DisplayName',['Qr(' num2str(idx) ',' num2str(idx) ') = ' num2str(ganhos(i))]);
            elseif Q_R_G == 1
                gg = plot(t, y(:, 1:1), 'DisplayName',['R = ' num2str(ganhos(i))]);
            end
            
            set(gg, 'LineWidth', 1.5)
            gg = xlabel('Time (seg)');
            set(gg, 'Fontsize', 14);
            gg = ylabel('\alpha (rad)');
            set(gg, 'Fontsize', 14);
            legend('off'); legend('show');
            
            figure(2);
            if Q_R_G == 0
                gg = plot(t, y(:, 2:2), 'DisplayName',['Qr(' num2str(idx) ',' num2str(idx) ') = ' num2str(ganhos(i))]);
            elseif Q_R_G == 1
                gg = plot(t, y(:, 2:2), 'DisplayName',['R = ' num2str(ganhos(i))]);
            end
            
            legend('off'); legend('show');
            set(gg, 'LineWidth', 1.5)
            gg = xlabel('Time (seg)');
            set(gg, 'Fontsize', 14);
            gg = ylabel('\beta (rad)');
            set(gg, 'Fontsize', 14);
        end

    else           %Varia os ganhos do lqe
        
        %Por implementar:
        %Dar reset de Qe, Re, G
        %Alterar iterativamente o valor de ou Qe ou Re ou G
        %Calcular again o L
        %Dar plot das shits
        
        sim('observer', T);
    end
    
end
