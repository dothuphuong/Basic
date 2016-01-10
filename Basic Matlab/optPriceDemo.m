%Written by: Thu Phuong Do
%Last modified: 2016-01-10

%This Demo is to test function OptPrice%
%Function OptPrice: determine option price using different methods in the
%library

%Example from Hull(2014). Options, Futures and Other derivatives. 9th
%edition

%INPUTS
S0 = 930;
K = 900;
R = 8;
T = 2/12; %2 months
sigma = 20;
TypeOption = 'C';
TypeExercise = 'European';
c = 3;

%Store inputs in a structure
UndlData = struct('S0', S0, 'Strike', K, 'Rate', R, 'Maturity', T, ...
                   'sigma', sigma, 'Type', TypeOption, ...
                   'TypeExercise', TypeExercise, ...
                   'DividendRate', c);

%Available option pricing model in the library
[~,modelLib] = enumeration('optPricingModel');

%Model parameters for each model in the library (matrix)
modelParams_M = [1000 NaN; 1000 NaN; 100 1000; 100 1000; NaN NaN];

opt = zeros(1,size(modelLib,1));

%Compare different methods of option pricing
for i = 1:size(modelLib,1)
    pricingMethod = modelLib(i);
    modelParams = modelParams_M(i,:);
    opt(i) = optPrice(pricingMethod{1}, UndlData, modelParams);
end

%Display the result
disp(transpose(modelLib))
disp(opt)





               
 

