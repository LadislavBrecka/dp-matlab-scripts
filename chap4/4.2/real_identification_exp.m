clc, clear all

%% LOAD EXPERIMENT I/O DATA
T = readtable('data-ident-full.csv');

%% EXTRACT DATA AND PRE-PROCESS THEM
u_speed = table2array(T(:, 2));
y_speed = table2array(T(:, 3));
w_pos = table2array(T(:, 4));
y_pos = table2array(T(:, 5));

u_speed = u_speed(485: 2485,1);
y_speed = y_speed(485: 2485,1);
y_speed = (2*pi) * (y_speed / 12);

%% CREATE TIME VECTOR
t_step_sim = 0:0.01:20;

%% PLOT I/O DATA

figure(1)
plot(t_step_sim, u_speed, 'DisplayName', 'u - strieda PWM'); hold on
grid on
legend
ylabel('Strieda [ % ]')
xlabel('Čas [s]')
title('Vstup systému počas experimentu identifikácie')

figure(2)
plot(t_step_sim, y_speed, 'DisplayName', 'y - rýchlosť hriadeľa motora'); hold on
grid on
legend
ylabel('Rýchlosť [ rad.s^-^1 ]')
xlabel('Čas [s]')
title('Výstup systému počas experimentu identifikácie')

%% IDENTIFIKACIA

n_a = 1;
n_b = 1;
n= n_a + n_b;
m = length(u_speed);

for i = 1:m
    for j = 1:n_a       
        try
            H(i,j) = -y_speed(i-j);
        catch
            H(i,j) = 0;
        end
        
    end

    for j = n_a+1:n
        try
            H(i,j) = u_speed(i-(j-2));
        catch
            H(i,j) = 0;
        end
    end
end

P = diag(10^10*ones(1,n));
d = zeros(1, n);
Q = 0; ro = 0; e = 0;
thetas = zeros(n, 1);

for i=1:m-1
    fprintf('iteracia c: %d\n',i)
    h = H(i, :)';
    y = y_speed(i);

    e = y - transpose(h) * thetas;
    d = P * h;
    ro = 1 / (1 + transpose(h) * d);

    thetas = thetas + ro * e * d;
    P = P - ro * d * transpose(h) * P;
    Q = Q + ro * (e*e);

end

%% DISPLAY RESULTS
fprintf('Najdene koecifienct su: %s\n', num2str(thetas));

