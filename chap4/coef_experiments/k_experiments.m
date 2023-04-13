clc, clear all

% | --------------------------------------------|
% |          w = 4 ; b = 1 ; AW = 1             |  
% | k was listing throught [0.5 1 1.5 2 2.5 5]  |
% |                                             |  
% |         THE BEST ONE WAS k = 2              |
% | ------------------------------------------- |



% read real experiment data
T_k0d5 = readtable('../data/k/k0d5.csv');
T_k1 = readtable('../data/k/k1.csv');
T_k1d5 = readtable('../data/k/k1d5.csv');
T_k2 = readtable('../data/k/k2.csv');
T_k2d5 = readtable('../data/k/k2d5.csv');
T_k5 = readtable('../data/k/k5.csv');

t_sim = 0:0.01:40;

% k = 0.5
w_pos_real = table2array(T_k0d5(4, :));
y_pos_real = table2array(T_k0d5(5, :));
w_pos_real = w_pos_real(1, 1187:1187+4000);
y_pos_real = y_pos_real(1, 1187:1187+4000);
plot(t_sim, w_pos_real, 'DisplayName', 'SP'); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'k = 0.5'); hold on;

% k = 1
% w_pos_real = table2array(T_k1(4, :));
y_pos_real = table2array(T_k1(5, :));
% w_pos_real = w_pos_real(1, 1240:1240+4000);
y_pos_real = y_pos_real(1, 1240:1240+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'k = 1'); hold on;

% k = 1.5
% w_pos_real = table2array(T_k1d5(4, :));
y_pos_real = table2array(T_k1d5(5, :));
% w_pos_real = w_pos_real(1, 1295:1295+4000);
y_pos_real = y_pos_real(1, 1295:1295+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'k = 1.5'); hold on;

% k = 2
% w_pos_real = table2array(T_k2(4, :));
y_pos_real = table2array(T_k2(5, :));
% w_pos_real = w_pos_real(1, 1083:1083+4000);
y_pos_real = y_pos_real(1, 1083:1083+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'k = 2'); hold on;

% k = 2.5
% w_pos_real = table2array(T_k2d5(4, :));
y_pos_real = table2array(T_k2d5(5, :));
% w_pos_real = w_pos_real(1, 952:952+4000);
y_pos_real = y_pos_real(1, 952:952+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'k = 2.5'); hold on;

% k = 5
% w_pos_real = table2array(T_k5(4, :));
y_pos_real = table2array(T_k5(5, :));
% w_pos_real = w_pos_real(1, 1173:1173+4000);
y_pos_real = y_pos_real(1, 1173:1173+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'k = 5'); hold on;

legend
xlabel('Time [s]')
ylabel('Position [impl]')
title('Comparision of k influencing reg.')