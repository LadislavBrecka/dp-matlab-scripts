clc, clear all

%% LOAD CPP EXPERIMENT DATA
cpp_y = load("cpp_data.mat").c_output;

%% CREATE CORRESPONDING VARIABLES FOR MATLAB SOLUTION COMPARISON
G = tf(0.0594, [1, -0.9802], 0.1, 'Variable', 'z^-1')

%% RUN MATLAB SIMULATION
matlab_y = step(G);
 
%% PROCESS DATA TO CORRECT FORMAT
cpp_y = cpp_y(1:length(matlab_y), 1);

%% PLOT RESULTS
t = 0:1:length(matlab_y)-1;

plot(t, matlab_y, 'DisplayName', 'MATLAB')
hold on
plot(t, cpp_y, 'DisplayName', 'C++ knižnica')
legend
xlabel('Vzorka [k]')
ylabel('-')
grid on
ylim([-0.2, 3.3])
title('Odpoveď systému na jednotkový skok')

%% MSE COMPUTATION AND PLOTTING
mse = 0;
e = zeros(1, length(matlab_y));
for i=1:length(matlab_y)
    m = matlab_y(i); n = cpp_y(i);
    e(i) = m - n;

    mse = mse + (e(i))^2;
end
mse = mse / length(matlab_y)

figure
plot(t, e, 'DisplayName', 'Odchýlka: MATLAB - C++')
legend
xlabel('Vzorka [k]')
ylabel('-')
ylim([-0.00005, 0.00005])
grid on
title(strcat('MSE = ', num2str(mse)))

