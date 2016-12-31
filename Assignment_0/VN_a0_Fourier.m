%Assignment 0 - 4.3.4.2 Fourier Series
%Nicholas Vadivelu
%SPH 4U0
%6 September 2016

clear all;
close all;
clc;

t = linspace(0,5, 40000); %set the domain for the series

for i = 1:8
    x = 4/pi * sin(pi*t); %create the first point
    for n = 3:2:5*2^i %this goes up by 2s and makes 5, 10, 20, etc to 640 terms
        x = x + (4/n/pi * sin(pi*t*n));
    end
    plot(t,x, 'Color', 'k') %plots this fourier transform
    
    axis([0 5 -1.7 1.5]) %sets axis size
    title('Animated Graph of the Fourier Transform of a Square Waveform') %adds title
    legend(strcat('Fourier Transform w/', ' ', num2str(5*2^(i-1)), ' terms') ,'Location','southwest')
    %legend indicating number of terms
    drawnow %draws plot on
    pause(2) %pauses for viewer to see graph
end