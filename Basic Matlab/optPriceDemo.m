%Written by: Thu Phuong Do
%Last modified: 2016-01-16

%This Demo is to test function OptPrice class opt_Vanilla%
%Function OptPrice: determine option price using different methods in the
%library

%Example from Hull(2014). Options, Futures and Other derivatives. 9th
%edition

%INPUTS
S0 = 900;
K = 900;
R = 8;
T = 2/12; %2 months
sigma = 20;
TypeOption = 'C';
TypeExercise = 'European';
q = 3;

pricingMethod = 'BlackScholes';
modelParams = NaN;

S0_otm = S0 * 0.95;   %5% OTM Call
S0_itm = S0 * 1.05;   %5% ITM Call

c_atm = opt_Vanilla(TypeOption,S0,K,R,T,sigma,TypeExercise,q);
c_otm = opt_Vanilla(TypeOption,S0_otm,K,R,T,sigma,TypeExercise,q);
c_itm = opt_Vanilla(TypeOption,S0_itm,K,R,T,sigma,TypeExercise,q);

n = 100;

T_vector = linspace(T,0,n);
V = zeros(n,3);
D = zeros(n,3);
G = zeros(n,3);
Th = zeros(n,3);

for i = 1:n
    c_atm.UndlData.Maturity = T_vector(i);
    c_otm.UndlData.Maturity = T_vector(i);
    c_itm.UndlData.Maturity = T_vector(i);
    
    v1 = Pricing(c_atm,pricingMethod,modelParams); 
    v2 = Pricing(c_otm,pricingMethod,modelParams); 
    v3 = Pricing(c_itm,pricingMethod,modelParams);
    
    V(i,1) = v1.Price;
    V(i,2) = v2.Price;
    V(i,3) = v3.Price;
    
    D(i,1) = v1.Delta;
    D(i,2) = v2.Delta;
    D(i,3) = v3.Delta;
    
    G(i,1) = v1.Gamma;
    G(i,2) = v2.Gamma;
    G(i,3) = v3.Gamma;
    
    Th(i,1) = v1.Theta;
    Th(i,2) = v2.Theta;
    Th(i,3) = v3.Theta;
end

subplot(2,2,1)
plot(T_vector*12,V)
title('Option Price')

subplot(2,2,2)
plot(T_vector*12,D)
title('Delta')

subplot(2,2,3)
plot(T_vector*12,G)
title('Gamma')

subplot(2,2,4)
plot(T_vector*12,Th)
title('Theta')
legend('ATM','OTM','ITM')



               
 

