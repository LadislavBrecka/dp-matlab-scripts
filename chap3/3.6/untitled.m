clear all
format long

n=2;
io_data = load('io_data.mat');
x_i = io_data.u;
y = io_data.y;

m = length(x_i);
H = zeros(m,n);

for i = 1:m
    for j = 1:2        
        try
            H(i,j) = x_i(i-j);
        catch
            H(i,j) = 0;
        end
        
    end

    for j = 3:n
        try
            H(i,j) = -y(i-(j-2));
        catch
            H(i,j) = 0;
        end
    end
end
H
y
P_old = diag(10^10*ones(1,n))
theta_hat_old = zeros(n,1)
I = diag(ones(1,n));
Q_old = 0;

for i=1:m
    fprintf('iteracia c: %d',i)
    ro_new = 1/(1+H(i,:)*P_old*H(i,:)');
    Y_new = (P_old*(H(i,:)'))/(1+H(i,:)*P_old*H(i,:)');
    P_new = (I-Y_new*H(i,:))*P_old;
    e_new = y(i)-H(i,:)*theta_hat_old;
    theta_hat_new = theta_hat_old + Y_new*e_new;
    theta_hat_old = theta_hat_new;
    Q_new = Q_old + ro_new*e_new^2;
    Q_old = Q_new;
    P_old = P_new;

    h = H(i,:)
    output_y = y(i)
    P_new
    theta_hat_new
    Q_new
    e_new

end


