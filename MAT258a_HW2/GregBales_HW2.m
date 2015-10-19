% Greg Bales
% HW#2 Programming Assignment
% Logistic Regression

close all;
clear all;

data = csvread('binary.csv',1,0);
y = data(:,1);
u = data(:,2:3);
m = 400;
q  = 0;

%check on value of q
for i=1:length(y)
    if y(i) == 1
        q = q +1;
    end
end

%let the point in the domain be defined by the vector a and the scalar b
A = [0;0];
B = 0;
max = 4000;
x = zeros(max,3);
% x(1,:) = [0;0;0];
% x(2,:) = [A;B];
%mu = .00000006

for j=1:max
    %define the gradient
    for i=1:m
        a = x(j,1:2);
        b = x(j,3);
        %temp1(i) = exp(a*u(i,:)' + b );
        temp1(i) = exp(-(a*u(i,:)' + b) );
%         num1(i) = u(i,1)*temp1(i);
%         num2(i) = u(i,2)*temp1(i);
%         num3(i) = temp1(i);
% 
%         da1(i) = num1(i) / (1 + temp1(i) );
%         da2(i) = num1(i) / (1 + temp1(i) );
%         db(i) = num3(i) / (1 + temp1(i) );
        
        
        da1(i) = u(i,1) / (1 + temp1(i) );
        da2(i) = u(i,2) / (1 + temp1(i) );
        db(i) = 1 / (1 + temp1(i) );
    end

    df_da1(j)= -sum(u(1:q,1)) +  sum( da1 );
    df_da2(j) = -sum(u(1:q,2)) +  sum( da2 );
    df_db(j) = -q +  sum( db );
    
    if j<1000
        mu = .00000006;
    else mu = .00000001;
    end
    x(j+1,:) = x(j,:) - mu.*[df_da1(j),df_da2(j),df_db(j)];
    %error(j) = norm(x(j,:) - x(j-1,:));
end
a = x(max,1:2)
b = x(max,3)
    
    