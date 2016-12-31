%Assignment 0 - 4.3.2 Maple Questions (i)
%Nicholas Vadivelu
%SPH 4U0
%6 September 2016

syms x; %this command creates a symbolic integer

%40 Derivates from questions 1 and 2 of the calculus section of A0
disp('20 Basic Differentiation Questions: ') %section heading
%fprintf allows for formatted output
%char() converts the symbolic expression to a string
%diff() differentiates the symbolic function
fprintf(' 1. d/dx(-2x^(-4) + 5x^(-3) + 7x) = %s\n', char(diff(-2*x^(-4) + 5*x^(-3) + 7*x)))
fprintf(' 2. d/dx(-2x^4 + 3x^3 - x^2) = %s\n', char(diff(-2*x^4 + 3*x^3 - x^2)))
fprintf(' 3. d/dx(-2x^4 + x^2 - 3x) = %s\n', char(diff(-2*x^4 + x^2 - 3*x)))
fprintf(' 4. d/dx(1 + 6x) = %s\n', char(diff(1 + 6*x)))
fprintf(' 5. d/dx(3x - 5) = %s\n', char(diff(3*x - 5)))
fprintf(' 6. d/dx(5 - 8x) = %s\n', char(diff(5 - 8*x)))
fprintf(' 7. d/dx(9/x^3 + 1/x) = %s\n', char(diff(9/x^3 + 1/x)))
fprintf(' 8. d/dx(-1/x^3 + x^(-4)) = %s\n', char(diff(-1/x^3 + x^(-4))))
fprintf(' 9. d/dx((2x - 5)/(3x)) = %s\n', char(diff((2*x - 5)/(3*x))))
fprintf('10. d/dx(sqrt(x^2 - x^3)) = %s\n', char(diff(sqrt(x^2 - x^3))))
fprintf('11. d/dx(5x^2 + 7 - x^3) = %s\n', char(diff(5*x^2 + 7 - x^3)))
fprintf('12. d/dx(sqrt(x)) = %s\n', char(diff(sqrt(x))))
fprintf('13. d/dx((5x)^(1/4)) = %s\n', char(diff((5*x)^(1/4))))
fprintf('14. d/dx((5x-2)^2) = %s\n', char(diff((5*x-2)^2)))
fprintf('15. d/dx(sqrt(5x^2 + 1) - 2x) = %s\n', char(diff(sqrt(5*x^2 + 1) - 2*x)))
fprintf('16. d/dx(sqrt(x + 1)(x^2-1)) = %s\n', char(diff(sqrt(x + 1)*(x^2-1))))
fprintf('17. d/dx(x^(1/8) - 2x^4 + 7x^(3/4)) = %s\n', char(diff(x^(1/8) - 2*x^4 + 7*x^(3/4))))
fprintf('18. d/dx(((x - 2x^2)^3 + x^3)^2) = %s\n', char(diff(((x - 2*x^2)^3 + x^3)^2)))
fprintf('19. d/dx(sqrt(5-3x)/x^2) = %s\n', char(diff(sqrt(5-3*x)/x^2)))
fprintf('20. d/dx(x^2/ln(3) + sqrt(x^4)/ln(2)) = %s\n\n', char(vpa(diff(x^2/log(3) + sqrt(x^4)/log(2)), 4))) %vpa(num, 5) truncates numbers to 5 characters

%trig section
disp('20 Trigonometric Differentiation Questions: ') %section heading
fprintf(' 1. d/dx(3sin(x) - 4cos(x)) = %s\n', char(diff(3*sin(x) - 4*cos(x))))
fprintf(' 2. d/dx(tan(x)x^3) = %s\n', char(diff(tan(x)*x^3)))
fprintf(' 3. d/dx(cos(x)/(1+sin(x))) = %s\n', char(diff(cos(x)/(1+sin(x)))))
fprintf(' 4. d/dx(csc(x)cot(x)) = %s\n', char(diff(csc(x)*cot(x))))
fprintf(' 5. d/dx(sin(x)^2/cos(x)^2) = %s\n', char(diff(sin(x)^2/cos(x)^2)))
fprintf(' 6. d/dx(sin(2x) + cos(x)^2) = %s\n', char(diff(sin(2*x) + cos(x)^2)))
fprintf(' 7. d/dx(sec(x)^3) = %s\n', char(diff(sec(x)^3)))
fprintf(' 8. d/dx(cos(2x) + sin(x)^2) = %s\n', char(diff(cos(2*x) + sin(x)^2)))
fprintf(' 9. d/dx(tan(sin(x))) = %s\n', char(diff(tan(sin(x)))))
fprintf('10. d/dx(sin(3x)/(4+5cos(2x))) = %s\n', char(diff(sin(3*x)/(4+5*cos(2*x)))))
fprintf('11. d/dx(xsec(pi*x)) = %s\n', char(diff(x*sec(pi*x))))
fprintf('12. d/dx(cos(tan(3x))^3) = %s\n', char(diff(cos(tan(3*x))^3)))
fprintf('13. d/dx(csc(x)/(3-csc(x))) = %s\n', char(diff(csc(x)/(3-csc(x)))))
fprintf('14. d/dx(x^2 + sin(pi/2*x)) = %s\n', char(diff(x^2 + sin(pi/2*x))))
fprintf('15. d/dx(tan(x)/(1+tan(x))) = %s\n', char(diff(tan(x)/(1+tan(x)))))
fprintf('16. d/dx(cos(x)^3) = %s\n', char(diff(cos(x)^3)))
fprintf('17. d/dx(4tan(2x)^5) = %s\n', char(diff(4*tan(2*x)^5)))
fprintf('18. d/dx(20sin(x)^4) = %s\n', char(diff(20*sin(x)^4)))
fprintf('19. d/dx(10sin(x) + 100) = %s\n', char(diff(10*sin(x) + 100)))
fprintf('20. d/dx(x^5/(4sin(x))) = %s\n\n', char(diff(x^5/(4*sin(x)))))

disp('Note: log() is equivalent to ln() unless a base is given')