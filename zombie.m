% Zombie Outbreak 
% zombie.m

function zombie
clc
a1 = 0.01;  % birth rate of susceptible population 
a2 = 0.01;  % rate at which zombies are infecting susceptible population
a3 = 0.005;  % rate at which susceptible population is dying from natural causes 
a4_range = 0.005:0.001:0.016;  % rate at which zombies are defeated 
a5 = 0;  % rate at which corpses are reanimated and become zombies 
initialval(1) = 500;
initialval(2) = 50;
initialval(3) = 0;
Tfinal = 20;
dt = 0.01;  % chosen time step 
t = 0:dt:Tfinal;  % time interval with variables 
index = Tfinal / dt;
figure 
hold on 
grid on 
for n = 1:length(a4_range)  % iterating over each value of a4
    a4 = a4_range(n);
    [S,Z,R]=simpleSZR(a1,a2,a3,a4,a5,initialval,Tfinal,dt);
    subplot(3,4,n)
    plot(t,S)
    hold on
    plot(t,Z)
    hold on
    plot(t,R)
    a4_str = num2str(a4);
    S_final = round(S(index+1));
    Z_final = round(Z(index+1));
    S_str = num2str(S_final);
    Z_str = num2str(Z_final);
    title(strcat("a4 = ",a4_str,", Final: S = ",S_str,", Z = ",Z_str))
    xlabel("Time")
    ylabel("Populations")
    legend("Susceptibles","Zombies","Removed")
end 
% The zombies win when a4 is 0.005-0.010. 
% The humans win when a4 is 0.011-0.016.

% PART 2 
a1 = 0.01;  % birth rate 
a2 = 0.012;  % zombies are more aggressive 
a3 = 0.01;  % death rate 
a4_range = 0.005:0.001:0.016;  % rate at which zombies are defeated 
a5 = 0.006;  % reanimation rate 
initialval(1) = 500;
initialval(2) = 0;
initialval(3) = 0;
Tfinal = 40;
dt = 0.01;  % chosen time step 
t = 0:dt:Tfinal;  % time interval with variables 
index = Tfinal / dt;
figure 
hold on 
grid on 
for n = 1:length(a4_range)  % iterating over each value of a4
    a4 = a4_range(n);
    [S,Z,R]=simpleSZR(a1,a2,a3,a4,a5,initialval,Tfinal,dt);
    subplot(3,4,n)
    plot(t,S)
    hold on
    plot(t,Z)
    hold on
    plot(t,R)
    a4_str = num2str(a4);
    S_final = round(S(index+1));
    Z_final = round(Z(index+1));
    S_str = num2str(S_final);
    Z_str = num2str(Z_final);
    title(strcat("a4 = ",a4_str,", Final: S = ",S_str,", Z = ",Z_str))
    xlabel("Time")
    ylabel("Populations")
    legend("Susceptibles","Zombies","Removed")
end 
% In this scenario, a needs to be at least 0.013 for humans to survive.
end 

function [S,Z,R]=simpleSZR(a1,a2,a3,a4,a5,initialval,Tfinal,dt)
S(1) = initialval(1);  % Susceptible 
Z(1) = initialval(2);  % Zombie 
R(1) = initialval(3);  % Removed 
% using a time step of dt = 0.01 and interval of 0-20
index = Tfinal / dt;
for t = 1:index
    dS = (a1*S(t)-a2*S(t)*Z(t)-a3*S(t))*dt;
    dZ = (a2*S(t)*Z(t)-a4*S(t)*Z(t)+a5*R(t))*dt;
    dR = (a3*S(t)+a4*S(t)*Z(t)-a5*R(t))*dt;
    S(t+1) = S(t) + dS; 
    Z(t+1) = Z(t) + dZ; 
    R(t+1) = R(t) + dR; 
end 
end 
