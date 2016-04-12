%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drive.m - determines new position of the robot
% this code is modified on 2016-3-7 by BCM
%
% Inputs:
%   posnr - [yposr, xposr, theta]
%   wdia - robot's distance (length)
%   vL - Left wheel velocity
%   vR - Right wheel velocity
%   t - timestep between driving and collecting sensor data
%   Cangle - robot's heading angle
%
% Outputs:
%    newposn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [newposn] = drive(posnr, wdia, vL, vR, t, Cangle)

vdiff = vR-vL;

newposn(3) = posnr(3) - vdiff*t/wdia; % It seems wrong.

if(vdiff == 0)
    %calculate new [x y] if wheels moving together.
    newposn(1) = vL*t*cos(posnr(3))+posnr(1);
    newposn(2) = vR*t*sin(posnr(3))+posnr(2);
else
    if vR > vL
        alpha = atan(t*(vR - vL)/wdia);
    elseif vR < vL
        alpha = atan(t*(vL - vR)/wdia);
    end
    newposn(1) = posnr(1) + t*(vL + vR)/2*cos(Cangle - alpha);
    newposn(2) = posnr(2) + t*(vL + vR)/2*sin(Cangle - alpha);
end