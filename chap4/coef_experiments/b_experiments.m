clc, clear all

% | ------------------------------------------- |
% |          w = 4 ; k = 2 ; AW = 1             |  
% | b was listing throught [0.8 0.9 1 1.2 1.5]  |
% |                                             |  
% |      THE BEST ONE WAS b = 0.9               |
% | ------------------------------------------- |



% read real experiment data
T_b0d8 = readtable('../data/b/b0d8.csv');
T_b0d9 = readtable('../data/b/b0d9.csv');
T_b1 = readtable('../data/b/b1.csv');
T_b1d2 = readtable('../data/b/b1d2.csv');
T_b1d5 = readtable('../data/b/b1d5.csv');

t_sim = 0:0.01:40;

% b = 0.8
w_pos_real = table2array(T_b0d8(4, :));
y_pos_real = table2array(T_b0d8(5, :));
w_pos_real = w_pos_real(1, 1230:1230+4000);
y_pos_real = y_pos_real(1, 1230:1230+4000);
plot(t_sim, w_pos_real, 'DisplayName', 'SP'); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'b = 0.8'); hold on;

% b = 0.9
% w_pos_real = table2array(T_b0d9(4, :));
y_pos_real = table2array(T_b0d9(5, :));
% w_pos_real = w_pos_real(1, 1643:1643+4000);
y_pos_real = y_pos_real(1, 1643:1643+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'b = 0.9'); hold on;

% b = 1.0
% w_pos_real = table2array(T_b1(4, :));
y_pos_real = table2array(T_b1(5, :));
% w_pos_real = w_pos_real(1, 1023:1023+4000);
y_pos_real = y_pos_real(1, 1023:1023+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'b = 1'); hold on;

% b = 1.2
% w_pos_real = table2array(T_b1d2(4, :));
y_pos_real = table2array(T_b1d2(5, :));
% w_pos_real = w_pos_real(1, 1564:1564+4000);
y_pos_real = y_pos_real(1, 1564:1564+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'b = 1.2'); hold on;

% b = 1.5
% w_pos_real = table2array(T_b1d5(4, :));
y_pos_real = table2array(T_b1d5(5, :));
% w_pos_real = w_pos_real(1, 1211:1211+4000);
y_pos_real = y_pos_real(1, 1211:1211+4000);
% plot(t_sim, w_pos_real); hold on;
plot(t_sim, y_pos_real, 'DisplayName', 'b = 1.5'); hold on;

legend
xlabel('Time [s]')
ylabel('Position [impl]')
title('Comparision of b influencing reg.')