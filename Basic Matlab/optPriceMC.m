%Written by: Thu Phuong DO
%Last modified: 2015-12-27
%Pricing options using Monte Carlo simulation

function opt = optPriceMC(UndlData, nSimul)
%INPUTS
%UndlData: Structure containing basic pricing parameters
%nSimul: number of simulations

S0 = UndlData.S0;
K = UndlData.Strike;
R = UndlData.Rate/100;
T = UndlData.Maturity;
sigma = UndlData.sigma/100;
TypeEx = UndlData.TypeExercise;
c = UndlData.DividendRate/100;

%Time step precision fixed at 0.001
dt = 0.001;
nT = T/dt;

switch UndlData.Type
    case {'C', 'Call'}
        sig = 1;    
    case {'P', 'Put'}
        sig = -1;
end

%Simulate underlying trajectory
%Vector of underlying price used in payoff formula
S_vector = zeros(nSimul,1);

for i = 1:nSimul
    %Trajectory of underlying for each simulation
    S_t = zeros(nT+1,1);
    S_t(1) = S0;
    for j=2:(nT+1)
        %Generate normally distributed random variables Wt ~ N(0,t)
        rnd = randn(1)*sqrt(dt);
        S_t(j) = S_t(j-1)*exp((R-c-0.5*sigma^2)*dt+sigma*rnd);        
    end
    switch TypeEx
        case 'European'
            S_vector(i) = S_t(nT+1);
        case 'Lookback'
            S_vector(i) = max(S_t);
        case 'Asian'
            S_vector(i) = mean(S_t);
        otherwise
            S_vector(i) = NaN;
    end    
end

%Vector of payoff
PayOff = max(sig*(S_vector-K),0);

%Option Price
V = mean(PayOff * exp(-R*T));

opt = struct('Price', V, 'SimulAsset', S_vector, ...
             'SimulOption',PayOff,'T_vector',T:-dt:0);
end