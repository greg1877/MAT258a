
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
for i=1:length(y)
    if y(i) == 1
        q = q + 1;
    end
end

% Solve problem
%
% minimize  -(sum_(y_i=1) ui)*a - b + sum log (1+exp(a*ui+b)

U = [ones(m,1) u];
cvx_expert true
cvx_begin
    variable x(3)
    maximize(sum((y'*U*x)-(1-y)'*log(1+exp(U*x))))
cvx_end

b=x(1); a_gpa = x(3);  a_gre = x(2);

% Plot results and logistic function

gre = 0:10:800;
gpa = 0:.1:4;

GREin = u(1:127,1);
GPAin = u(1:127,2);
GREout = u(128:400,1);
GPAout = u(128:400,2);

y = (1/a_gpa)*(.5-b-a_gre*gre);

figure;
hold on;
scatter(GREin,GPAin,'+');
scatter(GREout,GPAout,'o');
plot(gre,y,'r','LineWidth',2);
axis([200 810 2 4.05]);
title('Logistic Regression Model of Admissions Data');
xlabel('GRE Scores');
ylabel('Grade Point Averages');
legend('y = 1','y = 0','.5 level','Location','NorthWest');
