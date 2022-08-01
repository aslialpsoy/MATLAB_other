%% Aslı Alpsoy %
%4 different plots in a single graph
clear;clc;close;
N=20; %axis limit
X=[-N N]; %x axis limit
Y=[-N N]; %y axis limit
axis([-N N -N N]);
plot(X,ones(size(X)) * 0,'k--'); hold on;grid on % divide the graph into 4 regions
plot(ones(size(Y)) * 0,Y,'k--');
%% 4. region, rectangle
xr=5; yr=-10; % starting values
w=7; h=4;  % width and height
rectangle('Position',[xr yr w h],'EdgeColor','m','LineWidth',2) % plot the rectangle
% mark the corners and write corresponding coord.
plot(xr,yr,'o','MarkerFaceColor','k');text(xr,yr,'(5,-10)','FontSize',11)
plot(xr+w,yr,'o','MarkerFaceColor','k');text(xr+w,yr,'(12,-10)','FontSize',11)
plot(xr+w,yr+h,'o','MarkerFaceColor','k');text(xr+w,yr+h,'(12,-6)','FontSize',11)
plot(xr,yr+h,'o','MarkerFaceColor','k');text(xr,yr+h,'(5,-6)','FontSize',11)
hold on
%% 2. region, circle
xc=-5; yc=4; r=2.5; % center and radius
% drawing the circle centered at (xc,yc) with radius r
th = 0:360; % angles, degree
xunit = r * cosd(th) + xc;
yunit = r * sind(th) + yc;
plot(xunit, yunit,'b','linewidth',2);
text(xc-2*r,yc+2*r,'x^2+y^2=(2.5)^2','FontSize',11) %circle equation
hold on
%% 3.region, triangle
xt=-8; yt=-8; % starting pts of the triangle
tri = [xt xt/2 xt*2 xt; yt yt/4 yt/2 yt]; % corners of the triangle. repeat the 1st corner to enclose the triangle
plot(tri(1,:), tri(2,:),'c', 'linewidth', 2) % plot the triangle
% mark the corners of the triangle and write corresponding coord.
plot(xt,yt,'o','MarkerFaceColor','k');text(xt,yt,'(-8,-8)','FontSize',11)
plot(xt/2,yt/4,'o','MarkerFaceColor','k');text(xt/2,yt/4,'(-4,-2)','FontSize',11)
plot(xt*2,yt/2,'o','MarkerFaceColor','k');text(xt*2,yt/2,'(-16,-4)','FontSize',11)
hold on
%% 1. region, otto cycle graph
%inputs
gamma= 1.4;
T3=277; %K
P1 = 0.25; %KPa
T1= 45; %K
%engine geometry 
bore = 0.12;
stroke =1.2;
con_rod = 0.15;
cr = 9;
% 	swept volume and clearance volume
V_swept = (pi/4) * bore^2 * stroke*10^3; % bore = D and stroke = L
V_clearance = V_swept/(cr-1);
V1=V_swept+V_clearance;
V2=V_clearance;
%2. point parameters
P2=P1*cr^gamma;
T2 = P2*V2*T1/(P1*V1);% ideal gaz kanunu
%3. point parameters
V3=V2;
P3=P2*T3/T2;
%4. point parameters
V4=V1;
P4= P3*(V3/V4)^gamma;
% plot
plot([V1 V2 V3 V4 V1], [P1 P2 P3 P4 P1],'color','r','linewidth',2) 


