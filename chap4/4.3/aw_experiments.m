clc, clear all

% | --------------------------------------------|
% |          w = 4 ; b = 0.9 ; k = 2            |  
% |    aw was listing throught [1 2 5 10 100]   |
% |                                             |  
% |         THE BEST ONE WAS k = 2              |
% | ------------------------------------------- |



%% READ REAL EXPERIMENT DATA OBTAINED THROUGHT USART
T_aw1 = readtable('../data/aw/aw1.csv');
T_aw2 = readtable('../data/aw/aw2.csv');
T_aw5 = readtable('../data/aw/aw5.csv');
T_aw10 = readtable('../data/aw/aw10.csv');
T_aw100 = readtable('../data/aw/aw100.csv');

%% CREATE TIME VECTOR
t_sim = 0:0.01:40-28;

%% PLOT RESULTS

% aw = 1
w_pos_real = table2array(T_aw1(4, :));
y_pos_real = table2array(T_aw1(5, :));
w_pos_real = w_pos_real(1, 1536+1000:1536+4000-1800);
y_pos_real = y_pos_real(1, 1536+1000:1536+4000-1800);
plot(t_sim, w_pos_real, 'DisplayName', 'SP'); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'K_A_W = 1'); hold on;

% aw = 2
% w_pos_real = table2array(T_aw2(4, :));
y_pos_real = table2array(T_aw2(5, :));
% w_pos_real = w_pos_real(1, 1640:1640+4000);
y_pos_real = y_pos_real(1, 1640+1000:1640+4000-1800);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'K_A_W = 2'); hold on;

% aw = 5
% w_pos_real = table2array(T_aw5(4, :));
y_pos_real = table2array(T_aw5(5, :));
% w_pos_real = w_pos_real(1, 1355:1355+4000);
y_pos_real = y_pos_real(1, 1355+1000:1355+4000-1800);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'K_A_W = 5'); hold on;

% aw = 10
% w_pos_real = table2array(T_aw10(4, :));
y_pos_real = table2array(T_aw10(5, :));
% w_pos_real = w_pos_real(1, 1565:1565+4000);
y_pos_real = y_pos_real(1, 1565+1000:1565+4000-1800);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'K_A_W = 10'); hold on;

% aw = 100
% w_pos_real = table2array(T_aw100(4, :));
y_pos_real = table2array(T_aw100(5, :));
% w_pos_real = w_pos_real(1, 1681:1681+4000);
y_pos_real = y_pos_real(1, 1681+1000:1681+4000-1800);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'K_A_W = 100'); hold on;

legend
grid on
xlabel('Čas [s]')
ylabel('Poloha [impl]')
title('Porovnanie rôznych hodnôt zosilnenia AW zapojenia')