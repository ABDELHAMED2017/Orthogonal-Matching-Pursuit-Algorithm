filename = 'housing.data';
delimiterIn = ' ';
A = importdata(filename,delimiterIn);
R=floor(size(A,1)*0.7);
D=[];

for k = 1:R
    E=zeros(1,13);
   for l = 1:13
    E(1,l)=A(k,l);
   end
   D=[D;E];
end

omega = [];
y=zeros(R,1);
for i=1:R
y(i,1)=A(i,14);
end
k=3;
%We have Y and A and want to find X
c=(D)' * y; %  Can only be used if the Matrix is symmetric
[m l] = max(abs(c));
omega = [omega l];
x_omega = mldivide(D(:,omega),y);
for i=2:k
    c = (D)'* (y-D(:,omega)*x_omega);
    [m,l]=max(abs(c));
    omega = [omega l];
    x_omega = mldivide(D(:,omega),y);
end
x_out = zeros(13,1);
x_out(omega) = x_omega;
%%
%Testing
D=[];
for k = R:size(A,1)
    E=zeros(1,13);
   for l = 1:13
    E(1,l)=A(k,l);
   end
   D=[D;E];
end
y_pred=D*x_out;
y_pr= zeros(size(A,1)-R,1);
for i = 1:size(A,1)-R
y_pr=y_pred(:,:);
end
y_actual=zeros(size(A,1)-R,1);
for i=R:size(A,1)-1
y_actual(i-R+1,1)=A(i,14);
end
error=0;
for i = 1:size(A,1)-R
    error=error+(y_actual(i)-y_pr(i)).^2;
end
sqrt(error/(size(A,1)-R))