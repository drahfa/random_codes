% Test Movement
% AFA - 10 Feb 2019
% mrahfa@gmail.com
% Reference: https://www.youtube.com/watch?v=7Z01cRw_i5E
% Notes: Don't forget to include the line simRemoteApi.start(19999) to the
% V-REP Scene

clear all
close all
clc

vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
vrep.simxFinish(-1); % just in case, close all opened connections
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
    disp('Connected to remote API server');
    % create some joints positions
    joint_pos1 = [90*pi/180,90*pi/180,170*pi/180,90*pi/180,90*pi/180,90*pi/180,0];
    joint_pos2 = [-90*pi/180,90*pi/180,180*pi/180,90*pi/180,90*pi/180,90*pi/180,0];
    joint_pos3 = [0,0,0,0,0,0,0];
    % joints handle
    h = [0,0,0,0,0,0,0];
    [r,h(1)]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint1',vrep.simx_opmode_blocking);
    [r,h(2)]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint2',vrep.simx_opmode_blocking);
    [r,h(3)]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint3',vrep.simx_opmode_blocking);
    [r,h(4)]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint4',vrep.simx_opmode_blocking);
    [r,h(5)]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint5',vrep.simx_opmode_blocking);
    [r,h(6)]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint6',vrep.simx_opmode_blocking);
    [r,h(7)]=vrep.simxGetObjectHandle(clientID,'LBR4p_joint7',vrep.simx_opmode_blocking);
    
    while true
        for i=1:7
            vrep.simxSetJointTargetPosition(clientID,h(i),joint_pos1(i),vrep.simx_opmode_streaming)
        end
        pause(2);
        for i=1:7
            vrep.simxSetJointTargetPosition(clientID,h(i),joint_pos2(i),vrep.simx_opmode_streaming)
        end
        pause(2);
        for i=1:7
            vrep.simxSetJointTargetPosition(clientID,h(i),joint_pos3(i),vrep.simx_opmode_streaming)
        end
        pause(2);
    end
    
else
    disp('Failed connecting to remote API server');
end
vrep.delete(); % call the destructor!

disp('Program ended');
