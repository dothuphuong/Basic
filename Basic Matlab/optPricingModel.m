%Written by: Thu Phuong DO
%Last modified: 2016-01-10
%Library of option pricing model available

classdef optPricingModel
    enumeration
        MonteCarlo,
        Binomial,
        Implicit, %Finite Difference - Implicit method
        Explicit,  %Finite Difference - Explicit method
        BlackScholes
    end
end