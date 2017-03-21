filename = 'winequality-red.csv';
delimiterIn = ',';
A = dlmread(filename,';',[1 0 1119 10]);
R=floor(size(A,1)*0.7);

omega = [];
R=size(A,1);
y=dlmread(filename,';',[1 11 1119 11]);
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

%Testing
D = dlmread(filename,';',[1120 0 1599 10]);
y_pred=D*x_out;
y_actual=dlmread(filename,';',[1120 11 1599 11]);
error=0;
for i = 1:480
    error=error+(y_actual(i)-y_pred(i)).^2;
end
sqrt(error/480)