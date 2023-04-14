%ideal signal parameters
% 
% u_speed_real = u_speed_real(1, 1515:1515+4000);
% y_speed_real = y_speed_real(1, 1515:1515+4000);
% w_pos_real = w_pos_real(1, 1515:1515+4000);
% y_pos_real = y_pos_real(1, 1515:1515+4000);
%
% Ts = 0.01;
% b = 0.95;
% w = 4.2;
% k = 1.8;
% P = 0.99212598425196863;
% I = 3.78223425915421;
% V = 0.83758762153302224;
% AW = 2.7;
% u_min = -100;
% u_max = 100;
% G_S = tf([0, 0.08348760837171855], [1, -0.97343313690447564], Ts, 'Variable', 'z^-1');
% Int = tf([Ts, Ts], [2.0, -2.0], Ts, 'Variable', 'z^-1');


%% READ EXPERIMENT SIGNALS
clc, clear all

% read real experiment data
T = readtable('../data/ideal.csv');

% preprocess real experiment data
u_speed_real = table2array(T(2, :));
y_speed_real = table2array(T(3, :));
w_pos_real = table2array(T(4, :));
y_pos_real = table2array(T(5, :));

u_speed_real = u_speed_real(1, 1515:1515+4000);
y_speed_real = y_speed_real(1, 1515:1515+4000);
w_pos_real = w_pos_real(1, 1515:1515+4000);
y_pos_real = y_pos_real(1, 1515:1515+4000);
    
% plot(y_pos_real); hold on;
% plot(w_pos_real); hold on;
%% SPECIFY EXPERIMENTAL DATA FOR SIMULATION
Ts = 0.01;
u_min = -100;
u_max = 100;

G_S = tf([0, 0.08348760837171855], [1, -0.97343313690447564], Ts, 'Variable', 'z^-1');
A = cell2mat(G_S.denominator);
B = cell2mat(G_S.numerator);
Int = tf([Ts, Ts], [2.0, -2.0], Ts, 'Variable', 'z^-1');

w = 4.2;
b = 0.95;
k = 1.8;
AW = 2.7;

P = 0.99212598425196863;
I = 3.78223425915421;
V = 0.83758762153302224;

% create referent tf
G_ref_s = tf((w^2 * k), [1, 2*b*w + k, w^2 + 2*b*w*k, w^2 * k]);
G_ref_z = c2d(G_ref_s, Ts, 'matched');

% create input signal for simulation - same as experiment signal
t_step_sim = 0:0.01:40;
w_pos_sim = timeseries(w_pos_real, t_step_sim);

%% RUN SIMULATION

%run reference model
[y_pos_ref, t_ref] = lsim(G_ref_z, w_pos_real);

%run simulation
out = sim('piv_simulation.slx');
y_pos_matlab = out.y_matlab.data(1: 4001);

% PLOTTING

figure(1)
plot(t_step_sim, w_pos_real, 'DisplayName', 'SP'); 
plot(t_step_sim, y_pos_real, 'DisplayName', 'Experiment model'); hold on
plot(t_step_sim, y_pos_matlab, 'DisplayName', 'Simulation model'); 
plot(t_step_sim, y_pos_ref', 'DisplayName', 'Reference model'); 
legend
grid on;
ylabel('Position [ ticks ] ( 1 tick - 30 degrees )')
xlabel('Time [s]')
title('Comparision of experiment and simulation for DC Motor position controlling')


figure(2)
plot(t_step_sim, u_speed_real, 'DisplayName', 'Control variable U')
legend
grid on
ylabel('PWM stride [ % ]')
xlabel('Time [s]')
title('Experiment control variable U')

% MSE Computation

mse = 0;
e = zeros(1, length(y_pos_matlab));
for i=1:length(y_pos_matlab)
    m = y_pos_matlab(i); n = y_pos_real(i);
    e(i) = m - n;
%     if abs(e(i)) <= 2
%         e(i) = 0;
%     end

    mse = mse + (e(i))^2;
end
mse = mse / length(y_pos_matlab)

figure(3)
plot(t_step_sim, e, 'DisplayName', 'Difference: Matlab - C++')
legend
xlabel('Sample [k]')
ylabel('-')
ylim([-0.005, 0.005])
title(strcat('MSE = ', num2str(mse)))
grid on
