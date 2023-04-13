clc, clear all

T = readtable('data-ident-full.csv');

u_speed = table2array(T(:, 2));
y_speed = table2array(T(:, 3));
w_pos = table2array(T(:, 4));
y_pos = table2array(T(:, 5));

u_speed = u_speed(489: 2489,1);
y_speed = y_speed(489: 2489,1);

figure(1)
plot(u_speed); hold on
plot(y_speed); hold on

%% IDENTIFIKACIA
n=2;
m = length(u_speed);

for i = 1:m
    for j = 1:1        
        try
            H(i,j) = -y_speed(i-j);
        catch
            H(i,j) = 0;
        end
        
    end

    for j = 2:n
        try
            H(i,j) = u_speed(i-(j-2));
        catch
            H(i,j) = 0;
        end
    end
end

P = diag(10^10*ones(1,n));
d = zeros(1, 2);
Q = 0; ro = 0; e = 0;
thetas = zeros(2, 1);

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

fprintf('Najdene koecifienct su: %s\n', num2str(thetas));

