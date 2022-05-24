%% Laplace Transform Lab: Solving ODEs using Laplace Transform in MATLAB
% This lab will teach you to solve ODEs using a built in MATLAB Laplace transform 
% function |laplace|.
% 
% There are five (5) exercises in this lab that are to be handed in. Write your 
% solutions in a separate file, including appropriate descriptions in each step.
% 
% Include your name and student number in the submitted file.
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

% a)
l = @(t) exp(2*t)*t^3;
F = laplace(l(t), s)

% b)
F = @(s) ((s - 1)*(s - 2))/(s*(s + 2)*(s - 3));
f = ilaplace(F, t)

% c)
syms f(t) t F s a
% Defining F(s) as the laplace transform of f(t)
F = laplace(f(t), s)
% Defining g(t) as exp(at)f(t)
g = @(t) exp(a*t)*f(t)
% Finding laplace transform of g(t)
G = laplace(g(t), s)
% The line above outputs: G = laplace(f(t), t, s-a)
% This shows that MATLAB knows that the laplace transform of |exp(at)f(t)| is
% simply the laplace transform of f(t), but the variable in the
% transform is s-a, since |laplace(f(t), t, s-a) = F(s-a)|

%% Exercise 2

syms f(t) t F s
% Setting a to an arbitrary value (in this case, a = 2)
a = 2;
% Define F as the laplace transform of f(t)
F = laplace(f(t), s)
% Define g = u_a(t)f(t-a)
g = @(t) heaviside(t-a)*f(t-a)
% Find laplace transform of g(t)
G = laplace(g(t))
% The line above outputs: G = e^(-2s)*laplace(f(t), t, s)
% Noting that laplace(f(t),t,s) = F(s) and a = 2, we can write the above
% output as a formula relating G(s) and F(s):
% G(s) = e^(-as)*F(s)

%% Exercise 3

% Define: the unknown function, its variable, and the Laplace
% tranform of the unknown function
syms y(t) t Y s

% Define the ODE
ODE = diff(y(t),t,3) + 2*diff(y(t),t,2) + diff(y(t),t,1) + 2*y(t) + cos(t) == 0

% Compute the Laplace transform of the ODE
L_ODE = laplace(ODE)

% Sub in initial conditions
L_ODE=subs(L_ODE,y(0),0)
L_ODE=subs(L_ODE,subs(diff(y(t),t,1), t, 0),0)
L_ODE=subs(L_ODE,subs(diff(y(t),t,2), t, 0),0)

% Factor out the Laplace transform of |y(t)|
L_ODE = subs(L_ODE,laplace(y(t), t, s), Y)

% Solve for Y
Y=solve(L_ODE,Y)

% Inverse Laplace transform to obtain the solution
y = ilaplace(Y)

% Plot the solution
ezplot(y,[0 10*pi])

% Check solution
diff(y,t,3) + 2*diff(y,t,2) + diff(y,t,1) + 2*y

% There is no initial condition for which y remains bounded as t goes to
% infinity. The tcos(t)/10 and tsin(t)/5 terms in the solution cause all
% solutions to grow indefinitely while oscillating as t goes to infinity.

%% Exercise 4

% Define: the unknown function, its variable, and the Laplace
% tranform of the unknown function
syms y(t) t Y s

% Define g(t)
g = @(t) 3 + heaviside(t-2)*(t-2) - heaviside(t-5)*(t-4);

% Define the ODE
ODE = diff(y(t),t,2) + 2*diff(y(t),t,1) + 5*y(t) == g

% Compute the Laplace transform of the ODE
L_ODE = laplace(ODE)

% Sub in initial conditions
L_ODE=subs(L_ODE,y(0),2)
L_ODE=subs(L_ODE,subs(diff(y(t),t,1), t, 0),1)

% Factor out the Laplace transform of |y(t)|
L_ODE = subs(L_ODE,laplace(y(t), t, s), Y)

% Solve for Y
Y=solve(L_ODE,Y)

% Inverse Laplace transform to obtain the solution
y = ilaplace(Y)

% Plot the solution
ezplot(y,[0 12 0 2.25])

%% Exercise 5

syms t tau y(tau) s
I=int(exp(-2*(t-tau))*y(tau),tau,0,t)
laplace(I,t,s)

% The integral I can be written as: I(t) = (f*y)(t), where f(t) = e^(-2t),
% and the * operation is convolution. According to the convolution theorem,
% the laplace transform of I, L{I}, is equal to the laplace transforms of f
% and y, i.e. L{I} = F(s)Y(s), where F(s) = L{f} and Y(s) = L{y}. The
% laplace transform of f(t): L{f} = L{e^(-2t)} = 1/(s+2). The laplace
% transform of y(t): L{y} = laplace(y(t), t, s). MATLAB's computed output
% is the product of these two laplace transforms, as expected.
