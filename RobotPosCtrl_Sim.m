%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RobotPosCtrl_Sim.m - A mobile robot position control simulator
% this code is modified on 2016-3-7 by BCM
%
% this code shows the single robot's movement based on initial position and
% desired position. 
% Step: click the left button mouse to designate the initial position and
% the right button mouse for the initial heading angle.
% Then click the left button mouse to designate the desired position and 
% the right button mouse for desired heading angle (not implemented version). 
% The robot will move then with P controller. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc

axis([-20 260 -20 260]);
xlabel('X-axis')
ylabel('Y-axis')
title('Robot Position Control Simulator')
grid on
hold on

set(gca,'ydir','reverse');
[rx , ry] = getpts;

C_Robot_Pos = [(rx(2)+rx(1))/2 (ry(2)+ry(1))/2]; % robot's x pos and y pos
C_Robot_Angr = 1*atan2((ry(2)-ry(1)),(rx(2)-rx(1))); % robot's current angle in radian
C_Robot_Angd = rad2deg(C_Robot_Angr); % robot's current angle in degree
plot([rx(1) rx(2)],[ry(1) ry(2)],'-k','LineWidth',1)

drawbotn([C_Robot_Pos C_Robot_Angr], 5, 1);
hold on
%desired posture
[rx , ry] = getpts;

D_Robot_Pos = [(rx(2)+rx(1))/2 (ry(2)+ry(1))/2]; % robot's x pos and y pos
D_Robot_Angr = 1*atan2((ry(2)-ry(1)),(rx(2)-rx(1))); % robot's current angle in radian
D_Robot_Angd = rad2deg(D_Robot_Angr); % robot's current angle in degree
drawbotn([D_Robot_Pos D_Robot_Angr], 5, 1);

dt = .5;                                %timestep between driving and collecting sensor data
Tsim = 100;                              %simulation time
d = 20;                                 %robot's distance

% P controller gains
k_rho = 0.05;                           %should be larger than 0, i.e, k_rho > 0
k_alpha = 0.8;                          %k_alpha - k_rho > 0
k_beta = -0.008;                        %should be smaller than 0, i.e, k_beta < 0

vel_data = zeros(length(0:dt:Tsim),2);  %initial vector to analyze velocity
j=1;                                    %for vel_data vector count
for i = 0:dt:Tsim

    delta_x = D_Robot_Pos(1) - C_Robot_Pos(1);
    delta_y = D_Robot_Pos(2) - C_Robot_Pos(2);
    rho = sqrt(delta_x^2+delta_y^2);    %distance between the center of the robot's wheel axle and the goal position.
    alpha = -C_Robot_Angr+atan2(delta_y,delta_x); %angle between the robot's current direction and the vector connecting the center of the axle of the sheels with the final position.
    
    %limit alpha range from -180 degree to +180
    if rad2deg(alpha) > 180
        temp_alpha = rad2deg(alpha) - 360;
        alpha = deg2rad(temp_alpha);
    elseif rad2deg(alpha) < -180
        temp_alpha = rad2deg(alpha) + 360;
        alpha = deg2rad(temp_alpha);
    end
    
    beta = -C_Robot_Angr-alpha;
    
    % P controller
    v = k_rho*rho;
    w = k_alpha*alpha + k_beta*beta;
    vL = v + d/2*w;
    vR = v - d/2*w;
    
    vel_data(j,:) = [vL vR];    
    j=j+1;
    
    posr = [C_Robot_Pos C_Robot_Angr];
    posr = drive(posr, d, vL, vR, dt, posr(3)); %determine new position
    drawbotn(posr, 5, 1);
    C_Robot_Pos = [posr(1) posr(2)];
    C_Robot_Angr = posr(3);
    pause(0.01);
end
%%
%for velocity plot
figure
plot(vel_data);
title('Velocities of Two Wheels');
