%% Lab 4 - AC Circuit Analysis
% Challenging Extension
% SPH 4U0-02
% Nicholas Vadivelu, Cheng Lin, Parnika Godkhindi, Khari Thomas
% Received 22 December 2016

%STILL NOT WORKING

%%Simulation Information 
%{ 
This program simulates the magnetic field around two helmholtz coils, with
the option to also simulate a third coil interfering (controlled by
enabling/disabling proximateSolenoid boolean). The parameters of the
simulation and the properties of the solenoids can be controlled directly
below. This includes the number of windings per coil, current through the
coils, radius, height, position, and orientation. Simulation properties may
also be varied, such as the x, y, and z range, step, number of points on
the coil (controls dB), and various graph properties.

Be sure to rotate, zoom, and manipulate the generated figure.
%}

%Time to run with drange, 35.67s
close all;

%% Constants and Simulation Properties
mu_0 = 4*pi*10^-7; %vacuum permeability in H m^-1

%Coil Properties
windings = 320; %number of windings in the solenoid
current = 0.41; %current in A
R = 0.067; %radius in m
coil_height = 0.01975;

%Simulation Properties
range = 0.5; %x, y, and z coordinate
step = range/20; %Fidelity of vector intervals
numpts = 360; %number of points on the coil
proximateSolenoid = false; %enable or disable the solenoid

%Data Visualization Properties
quiver_step = 11; %density of the quiver plot
scale = 0.03; %scales the vectors in the quiver plot
maxrange = 2.5; %determiens maximum magnitude for surf plot
y_set = 0; %determines which plane to plot on the surf plot

%Positions of the centres of the solenoids
s0 = [0 0 -R/2-coil_height/2];
s1 = [0 0 R/2-coil_height/2];
s2 = [0.07 0 0.078];

%Rotations of the solenoids
rot = [0 0 0]*pi/180; 
rot2 = [0 0 0]*pi/180;
rot3 = [0 60 0]*pi/180;

%% Defining x, y, and z coordinates to be simulated and rotation matrices
coordrange = -range/2:step:range/2-step;
coordinates = zeros(3, (range/step)^3);
coordinates(1, :) = kron(coordrange, ones(1, (range/step)^2));
coordinates(2, :) = repmat(kron(coordrange,ones(1, (range/step))), size(coordrange));
coordinates(3, :) = repmat(coordrange, size(coordrange).^2);

%Components of Magnetic Field
B = zeros(size(coordinates));

%Rotation functions in order to rotate the first solenoid
rot_x =  [1 0 0;                        0 cos(rot(1)) -sin(rot(1)); 0 sin(rot(1)) cos(rot(1))];
rot_y =  [cos(rot(2)) 0 sin(rot(2));    0 1 0;                      -sin(rot(2)) 0 cos(rot(2))];
rot_z =  [cos(rot(3)) -sin(rot(3)) 0;   sin(rot(3)) cos(rot(3)) 0;  0 0 1];

%Rotation functions in order to rotate the third solenoid
rot_x2 =  [1 0 0;                        0 cos(rot2(1)) -sin(rot2(1)); 0 sin(rot2(1)) cos(rot2(1))];
rot_y2 =  [cos(rot2(2)) 0 sin(rot2(2));    0 1 0;                      -sin(rot2(2)) 0 cos(rot2(2))];
rot_z2 =  [cos(rot2(3)) -sin(rot2(3)) 0;   sin(rot2(3)) cos(rot2(3)) 0;  0 0 1];

%Rotation functions in order to rotate the third solenoid
rot_x3 =  [1 0 0;                        0 cos(rot3(1)) -sin(rot3(1)); 0 sin(rot3(1)) cos(rot3(1))];
rot_y3 =  [cos(rot3(2)) 0 sin(rot3(2));    0 1 0;                      -sin(rot3(2)) 0 cos(rot3(2))];
rot_z3 =  [cos(rot3(3)) -sin(rot3(3)) 0;   sin(rot3(3)) cos(rot3(3)) 0;  0 0 1];

%% Defining the solenoid loop coordinates
max = windings*2*pi; %defines the maximum theta for the coil
coeffz = coil_height/max; %limist the height of the solenoid

%First solenoid coordinates before rotation
loopx = R*cos(linspace(0, max, numpts))+s0(1);
loopy = R*sin(linspace(0, max, numpts))+s0(2);
loopz = coeffz*linspace(0, max, numpts).*ones(1, length(loopy))+s0(3);

%Second solenoid coordinates before rotation
loopx2 = R*cos(linspace(0, max, numpts))+s1(1);
loopy2 = R*sin(linspace(0, max, numpts))+s1(2);
loopz2 = coeffz*linspace(0, max, numpts).*ones(1, length(loopy))+s1(3);

%Third solenoid coordinates before rotation
loopx3 = R*cos(linspace(0, max, numpts))+s2(1);
loopy3 = R*sin(linspace(0, max, numpts))+s2(2);
loopz3 = coeffz*linspace(0, max, numpts).*ones(1, length(loopy))+s2(3);

%Derivative of solenoid 1 coordinates before rotation
d_loopx = R*-sin(linspace(0, max, numpts))*max/numpts;
d_loopy = R*cos(linspace(0, max, numpts))*max/numpts;
d_loopz = coeffz*ones(1, length(loopy))*max/numpts;

%Solenoid functions after rotation
loop = rot_x*rot_y*rot_z*[loopx; loopy; loopz];
loop2 = rot_x2*rot_y2*rot_z2*[loopx2; loopy2; loopz2];
loop3 = rot_x3*rot_y3*rot_z3*[loopx3; loopy3; loopz3];

%solenoid function derivative after rotation
d_loop = rot_x*rot_y*rot_z*[d_loopx; d_loopy; d_loopz];
d_loop2 = rot_x2*rot_y2*rot_z2*[d_loopx; d_loopy; d_loopz];
d_loop3 = rot_x3*rot_y3*rot_z3*[d_loopx; d_loopy; d_loopz];

%% Simulation of b-field
n = 1;
%h = waitbar(0,'Simulating Magnetic Field...');%creates a progress par for simulation
%lengthofsim = range/step^3*numpts;
for i = drange(coordrange) %every x point
    for j = drange(coordrange) %every y point
        for k = drange(coordrange) %every z point
            %for m = drange(1:numpts) %evert point for the solenoids
                %Create r vector that is from position to dL on loop
                r = [i - loop(1, :); j - loop(1, :); k - loop(3, :)];
                r2 =[i - loop2(1, :); j - loop2(2, :); k - loop2(3, :)];
                r3 =[i - loop3(1, :); j - loop3(3, :); k - loop3(3, :)];
                
                %Sum of the dB for each point on the loop 1 in accordance with Biot-Savart
                normR = sqrt(r2(1, :).^2 + r2(2, :).^2 + r2(3, :).^2); 
                B(1, n) = B(1, n) + sum( (d_loop(2, :).*r(3, :) - r(2, :).*d_loop(3, :)) ./ normR.^3);
                B(2, n) = B(2, n) - sum( (d_loop(1, :).*r(3, :) - r(1, :).*d_loop(3, :)) ./ normR.^3);
                B(3, n) = B(3, n) + sum( (d_loop(1, :).*r(2, :) - r(1, :).*d_loop(2, :)) ./ normR.^3);
                
                %Sum of the dB for each point on the loop 2 in accordance with Biot-Savart
                normR2 = sqrt(r3(1, :).^2 + r3(2, :).^2 + r3(3, :).^2); 
                B(1, n) = B(1, n) + sum( (d_loop2(2, :).*r2(3, :) - r2(2, :).*d_loop2(3, :)) ./ normR2.^3);
                B(2, n) = B(2, n) - sum( (d_loop2(1, :).*r2(3, :) - r2(1, :).*d_loop2(3, :)) ./ normR2.^3);
                B(3, n) = B(3, n) + sum( (d_loop2(1, :).*r2(2, :) - r2(1, :).*d_loop2(2, :)) ./ normR2.^3);
                
                if proximateSolenoid 
                    %Sum of the dB for each point on the loop 3 in accordance with Biot-Savart
                    normR3 = sqrt(r(1, :).^2 + r(2, :).^2 + r(3, :).^2); 
                    B(1, n) = B(1, n) + sum( (d_loop3(2, :).*r3(3, :) - r3(2, :).*d_loop3(3, :)) ./ normR3.^3);
                    B(2, n) = B(2, n) - sum( (d_loop3(1, :).*r3(3, :) - r3(1, :).*d_loop3(3, :)) ./ normR3.^3);
                    B(3, n) = B(3, n) + sum( (d_loop3(1, :).*r3(2, :) - r3(1, :).*d_loop3(2, :)) ./ normR3.^3);
                end
            %end
            %Multiply each magnetic field by the constants in Biot-Savart to get the result in T
            B(1, n) = B(1, n)*mu_0*current/(4*pi);
            B(2, n) = B(2, n)*mu_0*current/(4*pi);
            B(3, n) = B(3, n)*mu_0*current/(4*pi);
            n = n + 1;
        end
    end
    %waitbar(i/range*step,h);
end
%delete(h); %delete progress bar

%% Plotting the field
figure('Position', [100, 100, 1200, 450]); %creates a field of size 1200x450
set(0, 'DefaultTextFontname','Times New Roman')

%First subplot will contain the quiver plot
subplot (1, 2, 1);
    %Plot the three solenoids
    plot3(loop(1, :), loop(2, :), loop(3, :), 'LineWidth', 1.5, 'Color', 'r');
    hold on;
    plot3(loop2(1, :), loop2(2, :),  loop2(3, :), 'LineWidth', 1.5,'Color', 'b');
    if proximateSolenoid
        plot3(loop3(1, :), loop3(2, :), loop3(3, :), 'LineWidth', 1.5,'Color', 'g');
    end
    axis equal; %ensures axis is square to enhance clarity
    
    %Add title and labels to axis
    title({'Quiver Plot of Magnetic','Field of Helmholtz Coils'})
    xlabel('X Position (m) =>', 'FontSize', 10)
    ylabel('<= Y Position (m)', 'FontSize', 10)
    zlabel('Z Position (m) =>', 'FontSize', 10)
    
    %Create scaled unitary vectors to quiver plot
    unit_B = ones(size(B));
    for i = 1:length(B(1, :))
        unit_B(:, i) = B(:, i)/norm(B(:, i))*scale;
    end
    
    %Limits the number of vectors plotted
    coords = coordinates(:, 1:quiver_step:end);
    unit_B = unit_B(:, 1:quiver_step:end);
    
    %Plots quiver plot
    q = quiver3(coords(1, :), coords(2, :), coords(3, :), unit_B(1, :), unit_B(2, :), unit_B(3, :), 'AutoScale', 'off', 'Color', [0.75 0.75 0.75]);
    q.LineWidth = 1.5;
    grid on;
    hold off;
    
%Second subplot will contain the surf plot
subplot (1, 2, 2);
    %defines the axis range 
    range2 = range/step;
    z = zeros(range2, range2);
    x = coordinates(3, 1:range2);
    y = x;
    
    %Stores points from B vector corresponding to the x and y coordinates
    %in matrix z
    n = 1; m = 1;
    for i = 1:length(coordinates(1, :))
        if coordinates(2, i) == y_set;
            z(n, m) = norm(B(:, i))*1000; %multiply by 1000 to get mT
            if (z(n, m) > maxrange) %ensures colour mapping is more vibrant
                z(n, m) = maxrange+maxrange*0.01;
            end
            if (n == range2) %creates new column
                m = m+1;
                n = 0;
            end
            n = n+1;
            if (m > range2) %ends loop when required values are stored
                i = length(coordinates(1, :)) + 1;
            end
        end
    end
    
    %Clips x, y, and z in order to have an even axis
    x = x(1:length(x)-1);
    y = y(1:length(y)-1);
    z = z(1:size(z(:, 1))-1, 1:size(z(:, 1))-1);
    
    %Creates the surfplot
    surfplot = surf(x, y, z);
    hold;
    
    %Define axis, labels, and title
    axis([min(x) -min(x) min(y) -min(y) 0 maxrange])
    xlabel('X Position (m) =>', 'FontSize', 10)
    ylabel('<= Z Position (m)', 'FontSize', 10)
    zlabel('Magnetic Field (mT) =>', 'FontSize', 10)
    title({'B Field of Helmholtz and Proximate Coils at y = 0'})
    hold off;