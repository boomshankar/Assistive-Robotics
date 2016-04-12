%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawbot.m - plots the robot & its wiskers on the figure (Axes)
% originally written by: Shawn Lankton and modified by BCM
%
% Inputs:
%   posr - [yposr, xposr, theta]
%   rad - radius of the robot's body
%   course - obstacle matrix (0 = obstacle ~0 = clear)
%
% Outputs:
%    none
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function drawbotn(posr, rad, NumRobot)

hold on;
angs = 0:pi/10:2*pi;

for i=1:NumRobot   
    x(i,:) = posr(i) + rad*cos(angs);
    y(i,:) = posr(NumRobot+i) + rad*sin(angs);
end

for i=1:NumRobot
    plot(x(i,:),y(i,:));
    hold on

    drawang([posr(i), posr(i+NumRobot), posr(2*NumRobot+i) + pi/8],20+rad);
    drawang([posr(i), posr(i+NumRobot), posr(2*NumRobot+i) - pi/8],20+rad);    

end
hold off %should be careful

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = drawang(posn, mag)
%  This draws rays coming from the center of the robot.  I use these to
%  help visulize rangefinders.  This is called from drawbot.
%
%  Inputs:
%    posn - [yposn, mag]
%    mag - length of the line (pixels)
%
%  Outputs:
%    none
%
% do some polar to cartesian math

x = [posn(1), posn(1)+ mag*cos(posn(3))];
y = [posn(2), posn(2)+ mag*sin(posn(3))];
plot(x,y,'g');

axis([-20 260 -20 260]);
set(gca,'ydir','reverse');
output = [x(2),y(2)];

return