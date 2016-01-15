%Written by: Thu Phuong Do
%Last modified: 2016-01-13
%Class object for Vanilla option

classdef opt_Vanilla
    %Define the properties of class opt_Vanilla
    %%UndlData:Parameters of underlying security
    
    properties
        UndlData
    end
    
    methods
        %Constructor to validate input values for pricing
        function obj = opt_Vanilla(TypeOption,S0,K,R,T,sigma,...
                        TypeExercise,c)
            if nargin > 0
                obj.UndlData = struct('S0', S0, 'Strike', K, ...
                   'Rate', R, 'Maturity', T, ...
                   'sigma', sigma, 'Type', TypeOption, ...
                   'TypeExercise', TypeExercise, ...
                   'DividendRate', c);
            else
                error('Wrong number of input arguments')
            end
        end
        
        %Main pricing function
        %Call optPrice function
        function r = Pricing(obj,pricingMethod,modelParams)
            if nargin > 0 
                r = optPrice(pricingMethod,obj.UndlData,modelParams);
            else
                error('Wrong number of input arguments')
            end
        end
    end
    
end
    
