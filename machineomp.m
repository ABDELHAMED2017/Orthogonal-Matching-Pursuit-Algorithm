filename = 'machine.data';
delimiterIn = ',';
A = csvread(filename,0,2,[0 2 143 7]);
R=floor(size(A,1)*0.7);

omega = [];
R=size(A,1);
y=csvread(filename,0,8,[0 8 R-1 8]); %change 8 to 9 if needed
k=3;
%We have Y and A and want to find X
c=(A)' * y; %  Can only be used if the Matrix is symmetric
[m l] = max(abs(c));
omega = [omega l];
x_omega = mldivide(A(:,omega),y);
for i=2:k
    c = (A)'* (y-A(:,omega)*x_omega);
    [m,l]=max(abs(c));
    omega = [omega l];
    x_omega = mldivide(A(:,omega),y);
end
x_out = zeros(6,1);
x_out(omega) = x_omega;

%Testing
D = csvread(filename,144,2,[144 2 207 7]);
y_pred=D*x_out;
y_actual=csvread(filename,144,8,[144 8 207 8]);
error=0;
for i = 1:64
    error=error+(y_actual(i)-y_pred(i)).^2;
end
sqrt(error/64)