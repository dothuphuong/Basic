%Test function option pricing%
%INPUTS
S0 = 100;
K = 110;
R = 2;
T = 0.25;
N = 100;
sigma = 30;
TypeOption = 'C';
TypeExercise = 'European';
c = 0;

%Store inputs in a structure
UndlData = struct('S0', S0, 'Strike', K, 'Rate', R, 'Maturity', T, ...
                   'Nstep', N, 'sigma', sigma, 'Type', TypeOption, ...
                   'TypeExercise', TypeExercise, ...
                   'DividendRate', c);

%Example with Binomial method
pricingMethod = 'Binomial';
nS0 = 100;
nT = 5;

%Plot 3D graph
close all
optGraph(pricingMethod, UndlData,nS0,nT)
               
 

