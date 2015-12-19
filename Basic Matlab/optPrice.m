%Written by: Thu Phuong DO
%Last modified: 2015-12-19
%Function to determine European option price by different methods

function opt = optPrice(pricingMethod, UndlData)
%Create structure containing the underlying inputs
%Rate and Dividend Rate in percentage (%)
%TypeOption: C/Call or P/Put

S0 = UndlData.S0;
K = UndlData.Strike;
R = UndlData.Rate/100;
T = UndlData.Maturity;
dt = T/UndlData.Nstep;
sigma = UndlData.sigma/100;

switch UndlData.Type
    case {'C', 'Call'}
        Flag = 1;
    case {'P', 'Put'}
        Flag = 0;
end
c = UndlData.DividendRate;

switch pricingMethod
    case 'Binomial'
        [~ , OptionValue] = binprice(S0, K, R, T,dt, sigma, Flag, c);
        opt = OptionValue(1,1);
end
end