clear all; close all;


g=9.81
l=1


pend = @(t,x) [x(2)
    -g/l*sin(x(1))];

for i = 70
[t,X] = ode45(pend,[0 10],[0;i/10])
figure(1),plot(t,X(:,2)),hold on
figure(2),plot(t,X(:,2).*X(:,2)/2,t,-cos(X(:,1))*l*g+g*l),hold on
end


