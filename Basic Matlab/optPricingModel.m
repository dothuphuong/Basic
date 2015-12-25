%Written by: Thu Phuong DO
%Last modified: 2015-12-25
%Library of option pricing model available

classdef optPricingModel
    enumeration
        MonteCarlo,
        Binomial,
        Implicit, %Finite Difference - Implicit method
        Explicit  %Finite Difference - Explicit method
    end
end