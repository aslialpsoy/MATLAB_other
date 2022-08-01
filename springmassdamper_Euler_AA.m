%--------------------------------------------------------------------------
%---- Mass Spring Damper System Response Estimated with Euler's Method ----
%------------------------ prepared by Aslı Alpsoy -------------------------
clear ;
clc;
%% input parameters
m=input('Enter the mass in kg:');
k=input('Enter the spring constant in N/m:');
F=input('Enter the force amplitude in N:');
zeta=[1.6 1 0.6 -1] ;       % Damping Ratio in Ns/m
t=linspace(0,10,1001)';
Fimp = F.*(t>=1 & t<=1.2);  %Impulse: F(t)=F at t =[1, 1.2], elsewhere F(t)=0
Fstep = F.* (t>=1);         %Step: F(t)=0 when t<1 and F(t)=F when t>1
Fsin = F.*(sin(t));         %Sinusoidal: F(t)=F.sin(t);
Force=[Fimp Fstep Fsin];
%% time step
t0=0 ;           %initial time
tf=10;           % final time
dt=.01;          % integration time step
N=(tf-t0)/dt;    % # of iterations
%% pre-allocation & initial conditions(at t=0 the system is at equilibrium)
X=zeros(N+1,4,3);
U=zeros(N+1,4,3); %dX/dt=U
t=zeros(N+1,4,3);
X(1)=0;
U(1)=0;
t(1)=0;
%% Euler integration
for z=1:3              %iterate through forces
for y=1:4              %iterate through damping ratios  
for i=1:N      
         f=(-k/m).*X+(-zeta(1,y)/m).*U+(1/m)*Force(:,z); %EoM: X''=1/m(-k*X-c*X'+F(t))
         U(i+1,y,z)= U(i,y,z)+dt*f(i,y,z);
         X(i+1,y,z)= X(i,y,z)+dt*U(i,y,z);
         t(i+1,y,z)= t(i,y,z)+dt;
end     
end
end
%% obtaining plots
 t=reshape(t,[1001,12]);
 X=reshape(X,[1001,12]);% 3D-->2D, each 4 columns-->same response
 figure('WindowState','maximized');
 % Impulse response
 subplot(3,2,1);     
 p1=plot(t,X(:,1),'b'); hold on; p2=plot(t,X(:,2),'m'); p3=plot(t,X(:,3),'g'); 
 ylabel('Response(m)');title('Impulse Response vs Time')
 hold off;
 subplot(3,2,2); p4=plot(t,X(:,4),'r');title('Impulse Response vs Time')
 %Step response
 subplot(3,2,3);     
 plot(t,X(:,5),'b'); hold on; plot(t,X(:,6),'m'); plot(t,X(:,7),'g'); 
 ylabel('Response(m)');title('Step Response vs Time')
 hold off;
 subplot(3,2,4);plot(t,X(:,8),'r');title('Step Response vs Time')
%Sinusoidal response
 subplot(3,2,5);    
 plot(t,X(:,9),'b'); hold on; plot(t,X(:,10),'m'); plot(t,X(:,11),'g'); 
 ylabel('Response(m)'); xlabel('Time(s)');title('Sinusoidal Response vs Time')
 hold off;
 subplot(3,2,6); plot(t,X(:,12),'r');xlabel('Time(s)');title('Sinusoidal Response vs Time')
 
lgd=legend([p1(1),p2(1),p3(1),p4(1)],'Damping ratio>1','Damping ratio=1','Damping ratio=(0,1]','Damping ratio<0');
set(lgd,'Position',[0.055 0.95 0 0]);
