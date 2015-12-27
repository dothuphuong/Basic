%Written by: Thu Phuong DO
%Last modified: 2015-12-27
%Pricing options by Binomial tree

function opt = optPriceBino(UndlData, nStep)
%INPUTS
%UndlData: Structure containing basic pricing parameters
%nStep: number of periods to construct Binomial tree

S0 = UndlData.S0;
K = UndlData.Strike;
R = UndlData.Rate/100;
T = UndlData.Maturity;
sigma = UndlData.sigma/100;
TypeEx = UndlData.TypeExercise;
c = UndlData.DividendRate/100;

%Compute time step
dt = T/nStep;

switch UndlData.Type
    case {'C', 'Call'}
        sig = 1;    
    case {'P', 'Put'}
        sig = -1;
end

%Calculate the parameters of binomial tree
u = exp(sigma * sqrt(dt));
d = exp(-sigma * sqrt(dt));
%Risk-neutral probability
q = (exp((R-c)*dt)-d)/(u-d);

%Underlying Binomial tree
AssetPrice = zeros(nStep+1,nStep+1);
AssetPrice(1,1) = S0;

for j = 2:(nStep+1)
    m = 0;
    for i = 1:j
        AssetPrice(i,j) = S0*u^(j-m-1)*d^m;
        m = m+1;
    end
end

%Option price binomial tree
V = zeros(nStep+1,nStep+1);
%Payoff at maturity T
V(:,nStep+1) = max(sig*(AssetPrice(:,nStep+1)-K),0);

%Roll backward to calculate option price at each node
switch TypeEx
    case 'European'
        for j = nStep:-1:1
            for i = 1:j
                V(i,j) = (V(i,j+1)*q+V(i+1,j+1)*(1-q))*exp(-R*dt);
            end
        end
        
    case 'American'
        for j = nStep:-1:1
            for i = 1:j
                v = (V(i,j+1)*q+V(i+1,j+1)*(1-q))*exp(-R*dt);
                V(i,j) = max(v,sig*(AssetPrice(i,j)-K));
            end
        end
    otherwise
        V = NaN(nStep+1,nStep+1);
end
    opt = struct('Price', V(1,1), 'AssetTree', AssetPrice, ...
                 'OptionTree',V,'T_vector',T:-dt:0);
end

