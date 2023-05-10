clc, clear all

%% SET TIME VARIABLES
Ts = 0.01
T_FROM = 0
T_TO = 40

%% READ REAL EXPERIMENT DATA OBTAINED THROUGHT USART
T = readtable('../data/ideal.csv');

%% EXTRACT DATA AND PRE-PROCESS THEM
u_speed_real = table2array(T(2, :));
y_speed_real = table2array(T(3, :));
w_pos_real = table2array(T(4, :));
y_pos_real = table2array(T(5, :));

k_from = round(T_FROM / Ts) + 1;
k_to = round((40  - T_TO) / Ts);

u_speed_real = u_speed_real( 1, 1515 : 1515 + 4000 - k_to);
y_speed_real = y_speed_real( 1, 1515 : 1515 + 4000 - k_to);
w_pos_real =   w_pos_real(   1, 1515 : 1515 + 4000 - k_to);
y_pos_real =   y_pos_real(   1, 1515 : 1515 + 4000 - k_to);
    
% plot(y_pos_real); hold on;
% plot(w_pos_real); hold on;

%% SPECIFY EXPERIMENTAL DATA FOR SIMULATION
u_min = -100;
u_max = 100;

G_Z = tf([0, 0.08348760837171855], [1, -0.97343313690447564], Ts, 'Variable', 'z^-1');
G_S = d2c(G_Z, 'matched');
a_Coefs = cell2mat(G_S.Denominator(1));
b_Coefs = cell2mat(G_S.Numerator(1));
a_0 = a_Coefs(2);
b_0 = b_Coefs(2);
Gs_final = tf(b_Coefs / a_0, a_Coefs/a_0);

A = cell2mat(G_Z.denominator);
B = cell2mat(G_Z.numerator);
Integrator = tf([Ts, Ts], [2.0, -2.0], Ts, 'Variable', 'z^-1');

w = 4.2;
b = 0.95;
k = 1.8;
K_aw = 2.7;

P = 0.99212598425196863;
I = 3.78223425915421;
V = 0.83758762153302224;

% create referent tf
G_ref_s = tf((w^2 * k), [1, 2*b*w + k, w^2 + 2*b*w*k, w^2 * k]);
G_ref_z = c2d(G_ref_s, Ts, 'matched');

% create input signal for simulation - same as experiment signal
t_step_sim = 0.0 : 0.01 : T_TO;
w_pos_sim = timeseries(w_pos_real, t_step_sim);

%% RUN SIMULATION

%run reference model
[y_pos_ref, t_ref] = lsim(G_ref_z, w_pos_real);

%run simulation
out = sim('uro_sim.slx');
y_pos_matlab = out.y_matlab.data(1 : end);

%% PLOT RESULTS

figure(1)
plot(t_step_sim(1, k_from:end), w_pos_real(1, k_from:end), 'DisplayName', 'SP'); hold on
plot(t_step_sim(1, k_from:end), y_pos_real(1, k_from:end), 'DisplayName', 'y - reálne zariadenie'); hold on
plot(t_step_sim(1, k_from:end), y_pos_ref(k_from:end, 1)', 'DisplayName', 'y_{ref} - referenčný model'); hold on
plot(t_step_sim(1, k_from:end), y_pos_matlab(k_from:end, 1), 'DisplayName', 'y_{sim} - SIMULINK simulácia'); 
legend 
grid on;
ylabel('Poloha [ impl ]')
xlabel('Čas [s]')
% title('Porovnanie experimentu pre P+IV polohové riadenie')
title('Porovnanie experimentu bez zapracovania AW zapojenia')
ylim([  min(y_pos_real(1, k_from:end)) - 15   ,   max(y_pos_real(1, k_from:end)) + 15   ])

figure(2)
plot(t_step_sim(1, k_from:end), u_speed_real(1, k_from:end), 'DisplayName', 'u - akčná veličina')
legend
grid on
ylim([-105, 105])
ylabel('Stireda [ % ]')
xlabel('Čas [s]')
title('Priebeh akčného zásahu na reálnom zariadení')

%% MSE COMPUTATION AND PLOTTING
mse = 0;
e = zeros(1, length(y_pos_matlab)-k_from+1);
for i=k_from:(length(y_pos_matlab))
    m = y_pos_matlab(i); n = y_pos_real(i);
    e(i-k_from+1) = m - n;

    mse = mse + (e(i-k_from+1))^2;
end
mse = mse / (length(e))

figure(3)
plot(t_step_sim(1, k_from:end), e, 'DisplayName', 'Odchýlka: SIMULINK - C++')
legend
xlabel('Sample [k]')
ylabel('-')
ylim([-40, 40])
title(strcat('MSE = ', num2str(mse)))
grid on
