clear;clc;close all;
N = 10; % number of waypoints
m= 50; % mass of the skateboarder, kg
g= 9.81; % gravitational acceleration, m/s^2
t= (0:N-1)'; % s
x = [2 4 6 8 10 12 14 16 18 20]'; % m
y = [48 45 38 31 24 23 21 17 13 5]'; % m

% 2- fit a curve to x & y
p_s=polyfit(x,y,9); % s-t polynomial coefs
f_s=polyval(p_s,x);
scatter(x,y);hold on; plot(x,f_s)
xlabel('x position');ylabel('y position'); 
title('Position of the Skateboarder')
legend('waypoints','fitted curve')

% 3- local slope and radius of curvature
f_slope=polyder(p_s);
slope=polyval(f_slope,x); % local slope of the points on the track
f_secder=polyder(f_slope);
secder=polyval(f_secder,x);
R= (1+(slope).^2).^(3/2)./abs(secder); %https://math24.net/curvature-radius.html

% 4- speed at any point on the track, m/s

p_x=polyfit(t,x,1); % x position coefs
f_x=polyval(p_x,t); % x positions 
pv_x=polyder(p_x);  % x velocity coefs
v_x= polyval(pv_x,t); % x velocity

p_y=polyfit(t,y,5); % y position coefs
f_y=polyval(p_y,t); % y positions
pv_y=polyder(p_y);  % y velocity coefs
v_y= polyval(pv_y,t); % y velocity

v= sqrt(v_x.^2+v_y.^2); % resultant speed


% 4- tangential and normal acceleration, m/s^2
a_tan= gradient(v); % resultant tan acceleration

a_norm= v.^2./R;  % normal acceleration

% normal force 
F_n= m*(a_norm+ g); % N


