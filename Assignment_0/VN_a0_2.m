%Assignment 0 - 4.3.2 Maple Questions (ii)
%Nicholas Vadivelu
%SPH 4U0
%6 September 2016

syms x; %this command creates a symbolic integer
e = exp(1); %this is to use the variable e

%40 Integrals from questions 7 and 8 of the calculus section of A0
disp('20 Integration by Substitution Questions: ') %section heading
%fprintf allows for formatted output
%char() converts the symbolic expression to a string
%diff() differentiates the symbolic function
fprintf(' 1. int(x^2*e^(-4x^3)) = %s\n', char(vpa(int(x^2*e^(-4*x^3)), 5))) %answer is truncated using vpa()
fprintf(' 2. int(cos(x)^3*sin(x)) = %s\n', char(int(cos(x)^3*sin(x))))
fprintf(' 3. int(x^2*(7-x^3)^(-1)) = %s\n', char(int(x^2*(7-x^3)^(-1))))
fprintf(' 4. int(x^3*cos(5x^4)) = %s\n', char(int(x^3*cos(5*x^4))))
fprintf(' 5. int(sin(x)(2 + cos(x)^(-1))) = %s\n', char(int(sin(x)*(2 + cos(x)^(-1)))))
fprintf(' 6. int((3x + 4)^100) = %s\n', char(int((3*x + 4)^100)))
fprintf(' 7. int(cos(x)(1 + sin(x)^2)^(-1)) = %s\n', char(int(cos(x)*(1 + sin(x)^2)^(-1))))
fprintf(' 8. int((2-sqrt(x))^5*sqrt(x)^(-1)) = %s\n', char(int((2-sqrt(x))^5*sqrt(x)^(-1))))
fprintf(' 9. int(sec(2x-3)^2) = %s\n', char(int(sec(2*x-3)^2)))
fprintf('10. int(e^(-4x)) = %s\n', char(vpa(int(e^(-4*x)), 5)))
fprintf('11. int((x^2-2)(x^3-6x)^207) = %s\n', char(vpa(int((x^2-2)*(x^3-6*x)^207),3)))
fprintf('12. int((ln(x)^8 + 1)x^(-1)) = %s\n', char(int((log(x)^8 + 1)*x^(-1))))
fprintf('13. int(3x(x^2 + 1)^(-7)) = %s\n', char(int(3*x*(x^2 + 1)^(-7))))
fprintf('14. int(12x^3(3x^4 + 1)) = %s\n', char(int(12*x^3*(3*x^4 + 1))))
fprintf('15. int((-3x + 1)e^(-3x^2 + 8x)) = %s\n', char(vpa(int((-3*x + 1)*e^(-3*x^2 + 8*x)),5)))
fprintf('16. int(20x(x^2 + 1)^(-20)) = %s\n', char(int(20*x*(x^2 + 1)^(-20))))
fprintf('17. int(e^x(e^x + 1)^(-1)) = %s\n', char(vpa(int(e^x*(e^x + 1)^(-1)),4)))
fprintf('18. int(xe^(-3x^2)) = %s\n', char(vpa(int(x*e^(-3*x^2)),4)))
fprintf('19. int((e^x - e^(-x))(e^x + e^(-x))^(-1)) = %s\n', char(vpa(int((e^x - e^(-x))*(e^x + e^(-x))^(-1)),5)))
fprintf('20. int((xln(x))^(-1)) = %s\n\n', char(int((x*log(x))^(-1))))

%integration by parts
disp('20 Integration by Parts Questions: ') %section heading
fprintf(' 1. int(xe^x) = %s\n', char(vpa(int(x*e^x), 5)))
fprintf(' 2. int(xsin(x)) = %s\n', char(int(x*sin(x))))
fprintf(' 3. int(xln(x)) = %s\n', char(int(x*log(x))))
fprintf(' 4. int(xcos(3x)) = %s\n', char(int(x*cos(3*x))))
fprintf(' 5. int(ln(x)x^(-5)) = %s\n', char(int(log(x)*x^(-5))))
fprintf(' 6. int(xe^(3x)) = %s\n', char(vpa(int(x*e^(3*x)), 4)))
fprintf(' 7. int(xsin(5x)) = %s\n', char(int(x*sin(5*x))))
fprintf(' 8. int(ln(x)x^2) = %s\n', char(int(log(x)*x^2)))
fprintf(' 9. int(e^(-5x)x^2) = %s\n', char(vpa(int(e^(-5*x)*x^2), 5)))
fprintf('10. int((2 + 5x)e^(1/3x)) = %s\n', char(vpa(int((2 + 5*x)*e^(1/3*x)), 4)))
fprintf('11. int(4xcos(2-3x)) = %s\n', char(int(4*x*cos(2-3*x))))
fprintf('12. int(x2^x) = %s\n', char(int(x*2^x)))
fprintf('13. int(log[10](x)sqrt(x)^(-1)) = %s\n', char(vpa(int(log(x)/log(5)*sqrt(x)^(-1)), 4)))
fprintf('14. int(log[3](x)x^(-1/2)) = %s\n', char(vpa(int(log(x)/log(3)*x^(-1/2)), 4)))
fprintf('15. int(3/2xsin(2/3x)) = %s\n', char(int(3/2*x*sin(2/3*x))))
fprintf('16. int(ln(5x)x^3) = %s\n', char(int(log(5*x)*x^3)))
fprintf('17. int(ln(x)^2) = %s\n', char(int(log(x)^2)))
fprintf('18. int(xsqrt(x+3)) = %s\n', char(int(x*sqrt(x+3))))
fprintf('19. int(xcos(x)sin(x)) = %s\n', char(int(x*cos(x)*sin(x))))
fprintf('20. int((ln(x)/x)^2) = %s\n\n', char(int((log(x)/x)^2)))

disp('Note: log() is equivalent to ln() unless a base is given')