%Written by: Thu Phuong DO
%Last modified: 2015-12-23
%Pricing options by Finite Difference method

function opt = optPriceFD(pricingMethod,UndlData, nS, nT)
%INPUTS
%pricingMethod:Explicit, Implicit
%UndlData: Structure containing basic pricing parameters
%nS: number of points for S0
%nT: number of points for T

S0 = UndlData.S0;
K = UndlData.Strike;
R = UndlData.Rate/100;
T = UndlData.Maturity;
sigma = UndlData.sigma/100;
TypeEx = UndlData.TypeExercise;
c = UndlData.DividendRate;

%Create vector j. By default, Smax = 2*S0
Smax = 2*S0;
dS = Smax/nS;
j = transpose(nS:-1:0);

%Compute time step
dt = T/nT;

%Create matrix for final option values
V = zeros(nS+1,nT+1);

%Setting boundary conditions
switch UndlData.Type
    case {'C', 'Call'}
        sig = 1;    
        V(nS+1,:) = 0; %when S = 0, payoff = 0 for Call
        V(1,:) = Smax; %when S = Smax, payoff = Smax for Call
    case {'P', 'Put'}
        sig = -1;
        V(nS+1,:) = K; %when S = 0, payoff = K for Put
        V(1,:) = 0; %when S = Smax, payoff = 0 for Put
end

%Terminal payoff in both cases
V(:,nT+1) = max(sig*(dS*j - K),0);

switch pricingMethod
    case 'Explicit'
    %Calculate the parameter aj, bj, cj 
        aj = 1/(1+R*dt)*(-0.5*(R-c)*j*dt + 0.5*dt*j.^2*sigma^2);
        bj = 1/(1+R*dt)*(1-dt*j.^2*sigma^2);
        cj = 1/(1+R*dt)*(0.5*(R-c)*j*dt + 0.5*dt*j.^2*sigma^2);
    
        %Determine the option prix for each date t and price S by solving
        %backward
        switch TypeEx
            case 'European'
                for col = nT:-1:1
                    for row = 2:nS
                        V(row,col) = aj(row)*V(row+1,col+1)+bj(row)*V(row,col+1)+ ...
                                        cj(row)*V(row-1,col+1);
                    end
                end
                
            case 'American'
                for col = nT:-1:1
                    for row = 2:nS
                        v = aj(row)*V(row+1,col+1)+bj(row)*V(row,col+1)+ ...
                                        cj(row)*V(row-1,col+1);
                    %Compare the value of each node to the intrinsic value
                    %to determine possibility of early exercise
                       V(row,col) = max(sig*(dS*j(row)-K),v);
                    end
                end
        end
        
    case 'Implicit'
        %Calculate the parameter aj, bj, cj 
        aj = flipud(0.5*(R-c)*j*dt - 0.5*dt*j.^2*sigma^2);
        bj = flipud(1+dt*j.^2*sigma^2 + R*dt);
        cj = flipud(-0.5*(R-c)*j*dt - 0.5*dt*j.^2*sigma^2);
        
        %Set up the matrix of parameters to solve equation of (nS-1)
        %unknowns. 3 diagonals are filled with the value of aj,bj,cj
        B = diag(aj(3:nS),-1)+diag(bj(2:nS))+diag(cj(2:(nS-1)),+1);
        
        %Intitialize vector of residual values
        res = zeros(nS-1,1);
        res(1,1) = -1*aj(2)*V(nS+1,nT+1);
        res(nS-1,1) = -1*cj(nS)*V(1,nT+1);
        
        %Determine the option prix for each date t and price S by solving
        %equation backward
        %B*Vi = V(i+1)+res
        switch TypeEx
            case 'European'
                for col = nT:-1:1
                    %Compute the vector V(i+1)+res
                    F = flipud(V(2:nS,col+1))+res;
                    V(2:nS,col) = flipud(B\F);                    
                end
            case 'American'
                for col = nT:-1:1
                %Compare the value of each node to the intrinsic value
                %to determine possibility of early exercise
                    F = flipud(V(2:nS,col+1))+res;
                    V(2:nS,col) = max(flipud(B\F), sig*(dS*j(2:nS)-K));   
                end
        end
end
    opt = V(j*dS==S0,1);
end