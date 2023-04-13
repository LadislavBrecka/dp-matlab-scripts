clear all

% load system data
T = 0.1;
P = 0.588235;
I = 11.3341;
V = 6.00043;
AW = 1 / T;
u_min = -0.7;
u_max = 0.7;
G_S = tf(0.0594, [1, -0.9802], 0.1, 'Variable', 'z^-1');
Int = tf([T, T], [2.0, -2.0], 0.1, 'Variable', 'z^-1');

out = sim('piv_dc_motor.slx');

% load both sets of experimental data
FINAL_T = 99; % how many samples include (max is 499)
% load('matlab_data.mat')
load('cpp_data.mat')
y_matlab = out.y_matlab.data(1:FINAL_T, 1);
u_matlab = out.u_matlab.data(1:FINAL_T, 1);
e_matlab = out.e_matlab.data(1:FINAL_T, 1);

y_cpp = y_cpp(1:FINAL_T, 1);
u_cpp = u_cpp(1:FINAL_T, 1);
e_cpp = e_cpp(1:FINAL_T, 1);

% inherit time vector for plotting
t = 0:1:length(y_matlab)-1;

% plot results
figure(1)
subplot(3,1,1)
plot(t, y_matlab, 'DisplayName', 'Matlab Response')
hold on
plot(t, y_cpp, 'DisplayName', 'C++ library Response')
legend
ylim([0, 1.1])
xlabel('Sample [k]')
ylabel('-')
title('Signal Y')
grid on

subplot(3,1,2)
plot(t, u_matlab, 'DisplayName', 'Matlab Response')
hold on
plot(t, u_cpp, 'DisplayName', 'C++ library Response')
legend
ylim([-0.5, 1.4])
xlabel('Sample [k]')
ylabel('-')
title('Signal U')
grid on


subplot(3,1,3)
plot(t, e_matlab, 'DisplayName', 'Matlab Response')
hold on
plot(t, e_cpp, 'DisplayName', 'C++ library Response')
legend
ylim([-0.1, 1.1])
xlabel('Sample [k]')
ylabel('-')
title('Signal E_1')
grid on


% MSE Computation
mse = 0;
e = zeros(1, length(y_matlab));
for i=1:length(y_matlab)
    m = y_matlab(i); n = y_cpp(i);
    e(i) = m - n;

    mse = mse + (e(i))^2;
end
mse = mse / length(y_matlab)

figure(2)
plot(t, e, 'DisplayName', 'Difference: Matlab - C++')
legend
xlabel('Sample [k]')
ylabel('-')
ylim([-0.005, 0.005])
title(strcat('MSE = ', num2str(mse)))
grid on