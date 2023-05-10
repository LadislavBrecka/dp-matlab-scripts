clc, clear all, format long

%% LOAD EXPERIMENT I/O DATA
io_data = load('io_data.mat');
u_data = io_data.u;
y_data = io_data.y;

%% FILL MATRIX H
n_a = 2;
n_b = 2;
n= n_a + n_b;
m = length(u_data);
H = zeros(m, n);

for i = 1:m
    for j = 1:n_a       
        try
            H(i,j) = -y_data(i-j);
        catch
            H(i,j) = 0;
        end
        
    end

    for j = n_a+1:n
        try
            H(i,j) = u_data(i-(j-2));
        catch
            H(i,j) = 0;
        end
    end
end

%% SET INITIAL IDENTIFICATION PARAMETERS
P = diag(10^10*ones(1,n));
d = zeros(1, 2);
Q = 0; ro = 0; e = 0;
thetas = zeros(n, 1);

%% COMPUTE RLSM IDENTIFICATION METHOD
for i=1:m-1
    fprintf('iteracia c: %d\n',i)
    h = H(i, :)';
    y = y_data(i);

    e = y - transpose(h) * thetas;
    d = P * h;
    ro = 1 / (1 + transpose(h) * d);

    thetas = thetas + ro * e * d;
    P = P - ro * d * transpose(h) * P;
    Q = Q + ro * (e*e);
end

%% DISPLAY RESULTS
thetas