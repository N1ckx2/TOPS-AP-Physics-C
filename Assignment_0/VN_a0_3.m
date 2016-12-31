%Assignment 0 - 4.3.2 Maple Questions (iii)
%Nicholas Vadivelu
%SPH 4U0
%6 September 2016

format long; %so display is the appropriate precision

y = [18.5; 76.2; 150.5; 365; 780; 1265; 3250; 7099]; %column vector with given y values
x = [1.01 2.2 2.9 4.03 5.32 6.22 8.56 9.01]; %vector with given x values
deg = 3; %this code is general for a polynomial fit of any degree

%Vandermonde Matrix
vand = zeros(length(x), deg+1); %initializes matrix
for i = 1:length(x) %one row for each element in x
    vand(i, 1:deg+1) = x(i).^(0:deg);
    %a vandermonde matrix contains each x value increasing geometrically from x^(0 to degree)
end
%The equation for the polynomial fit is y = vandermonde*coeff
%To solve this equation, both sides can be multiplied by the transpose of the vandermonde matrix:
%vandT*y = vandT*vand*coeff
%coeff = (vandT*vand)^(-1)*vandT*y

coeff = inv(transpose(vand)*vand) * transpose(vand) * y;

disp('Thus, the equation of the line of best fit is:');
fprintf('%dx^3 + %dx^2 + %dx + %d\n\n', coeff);

%4.3.2 Maple Questions (iv) - Generate a plot
scatter(x, y, 'o', 'k'); %creates a scatter plot of x and y data with circle black data points

%Setting up Graph
title('X vs. Y');
xlabel('X Values');
ylabel('Y Values');
set(gca,'XMinorTick','on','YMinorTick','on');

%Plotting regression
regX = linspace(x(1), x(end), 100); %creates 100 evenly spaced x values from first to last value of x data
regY = coeff(4)*regX.^3 + coeff(3)*regX.^2 + coeff(2)*regX + coeff(1); %generates 100 y values from equation of fit and regX values
hold all; %ensures new plot is on the same graph
plot(regX, regY, '--', 'Color', [0.5 0.5 0.5]); %creates a line plot of the regression data with dashed grey line