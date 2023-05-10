clc, clear all

% | ---------------------------------------- |
% |         k = 1 ; b = 1 ; AW = 1           |  
% |    \omega was listing throught [2 3 4 5 6]    |
% |                                          |  
% |       THE BEST ONE WAS \omega = 5             |
% | ---------------------------------------- |


%% READ REAL EXPERIMENT DATA OBTAINED THROUGHT USART
T_w2 = readtable('../data/omega/omega2.csv');
T_w3 = readtable('../data/omega/omega3.csv');
T_w4 = readtable('../data/omega/omega4.csv');
T_w5 = readtable('../data/omega/omega5.csv');
T_w6 = readtable('../data/omega/omega6.csv');

%% CREATE TIME VECTOR
t_sim = 0:0.01:25;

%% PLOT RESULTS

% omega = 2
w_pos_real = table2array(T_w2(4, :));
y_pos_real = table2array(T_w2(5, :));
w_pos_real = w_pos_real(1, 2659:1159+4000);
y_pos_real = y_pos_real(1, 2659:1159+4000);
plot(t_sim, w_pos_real, 'DisplayName', 'SP'); hold on;
plot(t_sim, y_pos_real, 'DisplayName', '\omega = 2'); hold on;

% omega = 3
% w_pos_real = table2array(T_w3(4, :));
y_pos_real = table2array(T_w3(5, :));
% w_pos_real = w_pos_real(1, 1023:1023+4000);
y_pos_real = y_pos_real(1, 2523:1023+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', '\omega = 3'); hold on;

% omega = 4
% w_pos_real = table2array(T_w4(4, :));
y_pos_real = table2array(T_w4(5, :));
% w_pos_real = w_pos_real(1, 150:150+4000);
y_pos_real = y_pos_real(1, 1650:150+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', '\omega = 4'); hold on;

% omega = 5
% w_pos_real = table2array(T_w5(4, :));
y_pos_real = table2array(T_w5(5, :));
% w_pos_real = w_pos_real(1, 1266:1266+4000);
y_pos_real = y_pos_real(1, 2766:1266+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', '\omega = 5'); hold on;

% omega = 6
% w_pos_real = table2array(T_w6(4, :));
y_pos_real = table2array(T_w6(5, :));
% w_pos_real = w_pos_real(1, 1534:1534+4000);
y_pos_real = y_pos_real(1, 3034:1534+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', '\omega = 6'); hold on;

legend
grid on
xlabel('Čas [s]')
ylabel('Poloha [impl]')
title('Porovnanie rôznych hodnôt vlastnej frekvencie', 'Interpreter', 'tex')
