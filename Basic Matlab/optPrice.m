%Written by: Thu Phuong DO
%Last modified: 2015-12-31
%Function to determine option price by different methods

function opt = optPrice(pricingMethod, UndlData, modelParams)
switch pricingMethod
    case {'Implicit', 'Explicit'}
        nS = modelParams(1);
        nT = modelParams(2);
        optStruct = optPriceFD(pricingMethod,UndlData, nS, nT);
    case 'Binomial'
        nStep = modelParams(1);
        optStruct = optPriceBino(UndlData,nStep);
    case 'MonteCarlo'
        nSimul = modelParams(1);
        optStruct = optPriceMC(UndlData,nSimul);
    case 'BlackScholes'
        optStruct = optPriceBS(UndlData);
end
    opt = optStruct.Price;
end