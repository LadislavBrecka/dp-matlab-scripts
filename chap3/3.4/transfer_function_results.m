
c_input = ones(1, 500);
c_output = load("cpp_library_response.mat").c_output;

G = tf(0.0594, [1, -0.9802], 0.1, 'Variable', 'z^-1')
matlab_output = step(G);
c_output = c_output(1:length(matlab_output), 1);

t = 0:1:length(matlab_output)-1;

plot(t, matlab_output, 'DisplayName', 'Matlab Step Response')
hold on
plot(t, c_output, 'DisplayName', 'C++ library Response')
legend
xlabel('Sample [k]')
ylabel('-')
grid on
ylim([-0.2, 3.3])

mse = 0;
e = zeros(1, length(matlab_output));
for i=1:length(matlab_output)
    m = matlab_output(i); n = c_output(i);
    e(i) = m - n;

    mse = mse + (e(i))^2;
end

mse = mse / length(matlab_output)

figure
plot(t, e, 'DisplayName', 'Difference: Matlab - C++')
legend
xlabel('Sample [k]')
ylabel('-')
ylim([-0.005, 0.005])
grid on
title(strcat('MSE = ', num2str(mse)))

