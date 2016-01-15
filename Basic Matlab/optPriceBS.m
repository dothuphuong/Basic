%Written by: Thu Phuong DO
%Last modified: 2016-01-10
%Black-Scholes Closed-formula to determine the European option price

function opt = optPriceBS(UndlData)
%STEP 1 - Extract underlying parameters from the structure
%INPUTS
%UndlData: Structure containing basic pricing parameters
S0 = UndlData.S0;
K = UndlData.Strike;
R = UndlData.Rate/100;
T = UndlData.Maturity;
sigma = UndlData.sigma/100;
TypeEx = UndlData.TypeExercise;
c = UndlData.DividendRate/100;

switch UndlData.Type
    case {'C', 'Call'}
        sig = 1;    
    case {'P', 'Put'}
        sig = -1;
end

%STEP 2 - Pricing formula
%Calculate d1 & d2
d1 = (log(S0/K) + (R - c + 0.5*sigma^2)*T)/(sigma*sqrt(T));
d2 = d1 - sigma*sqrt(T);

%Nd1 = exercise probability of option
Nd1 = normcdf(sig*d1);
%Nd2 = adjusted exercise probability of option
Nd2 = normcdf(sig*d2);

switch TypeEx
    case 'European'
        V = sig*S0*exp(-c*T)*Nd1 - sig*K*exp(-R*T)*Nd2;
    otherwise
        V = NaN;
end

%STEP 3 - Calculate the greeks of option
delta = exp(-c*T)*Nd1;
gamma = exp(-c*T)*N_density(d1)/(S0*sigma*sqrt(T));
%Theta per nb of trading days
theta = (sig*c*S0*exp(-c*T)*Nd1 - S0*N_density(d1)*sigma/(2*sqrt(T)) ...
        - sig*R*K*exp(-R*T)*Nd2)/252;

%OUTPUTS
opt = struct('Price', V,'Delta', delta,'Gamma', gamma, 'Theta', theta);
end

function r = N_density(x)
    r = exp(-0.5*x^2)/sqrt(2*pi);
end