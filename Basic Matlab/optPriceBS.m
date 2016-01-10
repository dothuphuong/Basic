%Written by: Thu Phuong DO
%Last modified: 2016-01-10
%Black-Scholes Closed-formula to determine the European option price
function opt = optPriceBS(UndlData)
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

%Calculate d1 & d2
d1 = (log(S0/K) + (R - c + 0.5*sigma^2)*T)/(sigma*sqrt(T));
d2 = d1 - sigma*sqrt(T);

%Nd1 = exercise probability of option
Nd1 = normcdf(sig*d1,0,1);
%Nd2 = adjusted exercise probability of option
Nd2 = normcdf(sig*d2,0,1);

switch TypeEx
    case 'European'
        V = sig*S0*exp(-c*T)*Nd1 - sig*K*exp(-R*T)*Nd2;
    otherwise
        V = NaN;
end

opt = struct('Price', V, 'Nd1', Nd1, 'Nd2', Nd2);
end