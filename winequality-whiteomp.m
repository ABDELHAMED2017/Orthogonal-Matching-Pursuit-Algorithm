filename = 'winequality-white.csv';
delimiterIn = ',';
R=floor(size(A,1)*0.7);
A = dlmread('d.csv',';',[1 0 3428 10]);
%%
omega = [];
R=size(A,1);
y=dlmread('d.csv',';',[1 11 3428 11]);
k=5;
%We have Y and A and want to find X
c=(A)' * y;
[m l] = max(abs(c));
omega = [omega l];
x_omega = mldivide(A(:,omega),y);
for i=2:k
    c = (A)'* (y-A(:,omega)*x_omega);
    [m,l]=max(abs(c));
    omega = [omega l];
    x_omega = mldivide(A(:,omega),y);
end
x_out = zeros(11,1);
x_out(omega) = x_omega;
%%
%Testing
D = dlmread('d.csv',';',[3428 0 4898 10]);
y_pred=D*x_out;
y_actual=dlmread('d.csv',';',[3428 11 4898 11]);
error=0;
for i = 1:1471
    error=error+(y_actual(i)-y_pred(i)).^2;
end
sqrt(error/1471)