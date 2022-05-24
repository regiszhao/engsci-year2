%% Second-Order Lab: Second-Order Linear DEs in MATLAB
% In this lab, you will learn how to use |iode| to plot solutions of second-order 
% ODEs. You will also learn to classify the behaviour of different types of solutions.
% 
% Moreover, you will write your own Second-Order ODE system solver, and compare 
% its results to those of |iode|.
% 
% Opening the m-file lab5.m in the MATLAB editor, step through each part using 
% cell mode to see the results.
% 
% There are seven (7) exercises in this lab that are to be handed in on the 
% due date of the lab.
%% Student Information
%%
% 
%  Student Name: Regis Zhao
%
%%
% 
%  Student Number: 1007070660
%
%% Exercise 1
% 
% (b) All of the solutions decay while oscillating except for the solution |y =
% 0|.

% (c) The exact solution: y = exp(-t/2)(c1*cos(2t)+c2*sin(2t))
% This justifies my answer in part b because this shows that all solutions
% take the form of a decaying sinusoidal function. The exponential term is
% the part that decays while the linear combination of the sinusoidal
% functions is the part that oscillates.
%% Exercise 2

% b) 100% of solutions grow except for the solution |y = 0|.

% c) The exact solution: y = c1*exp((-sqrt(3)+2)t/2) + c2*exp(-(2+sqrt(3))/2)
% This justifies my answer in part b because the first term of the solution
% grows to +/-infinity as t approaches infinity, while the second term
% approaches zero as t approaches infinity. This means that as t becomes
% very large, the second term becomes insignificant and the solution will
% follow the first term and grow to +/-infinity, depending on the sign of
% c1.
%% Exercise 3

% b) 100% of the solutions decay except for the solution |y = 0|.

% c) The exact solution: y = c1*exp((-sqrt(3)+sqrt(2))t/2) + c2*exp(-(sqrt(3)+sqrt(2))t/2)
% This justifies my answer in part b because both terms of the solution
% approach zero as t approaches infinity; their sum (the solution) also
% approaches zero.

%% Exercise 4

% (a) Characteristic equation: r^4 + 2r^3 + 6r^2 + 2r + 5 = 0
polynomial = [1 2 6 2 5];
r = roots(polynomial);
% Solution: y(t) = c1*exp(-t)*sin2t + c2*exp(-t)*cos2t + c3*cost + c4*sint

% (b) None of the solutions will grow, decay, grow while oscillating, or decay
% while oscillating. Instead, 100% of solutions will simply oscillate about
% y = 0 without their amplitudes decaying to zero (except for the solution y = 0). This is because the
% first two terms are decaying sinusoidal functions, while the last two
% terms are simply sinusoidal functions without decay. This means that as t
% approaches infinity, the first two terms will approach zero and become
% insignificant, so as t becomes large, the solution settles as a
% non-decaying sinusoidal function.

%% Exercise 5
% 
% (a) grows
% 
% (b) grows
%
% (c) decays
%
% (d) decays while oscillating
%
% (e) oscillates without decaying/growing
%
% (f) grows while oscillating

%% Exercise 6

% function [t,y] = DE2_zhaoregi(f,t0,tN,y0,y1,h)
%     % returns array of t values and corresponding solution y
%     % f is a function where y'' = f(t,y,y')
%     t = t0:h:tN;
%     y = NaN(1, length(t));
%     y(1) = y0;
%     y(2) = y(1) + y1*h;
%     for i = 3:length(t)
%         yp = (y(i-1) - y(i-2)) / h;
%         ypp = f(t(i-1), y(i-1), yp);
%         y(i) = (ypp * h^2) + 2*y(i-1) - y(i-2);
%     end
% end

%% Exercise 7

f = @(t,y,yp) - (exp(-t./5).*yp) - ((1-exp(-t./5)).*y) + sin(2.*t);
t0 = 0; tN = 20; h = 0.01;
y0 = 1; y1 = 0;
[t,y_solver] = DE2_zhaoregi(f,t0,tN,y0,y1,h);
plot(t, y_solver);

% When using the same step size for my ODE solver and iode, the plots look
% almost identical - it's difficult to tell there's two different plots on the
% graph. Therefore, I changed the step size of the iode solution to 0.05 so
% that you can tell there's two plots. There is only a very slight
% difference.
