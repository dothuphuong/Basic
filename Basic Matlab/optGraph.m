%Written by: Thu Phuong DO
%Last modified: 2015-12-19

%Usage: 3D graph demonstrating the price of an option in function of Stock price
%at time t0 and the time to maturity

function optGraph(pricingMethod, UndlData,nS0,nT)
%nS0: precision setting for S0 array
%nT: precision setting for T array

S0 = UndlData.S0;
T = UndlData.Maturity;
S0_arr = linspace(0.8*S0,1.2*S0,nS0);
T_arr = linspace(T,0,nT);
grp = zeros(nS0,nT); %define output matrix

for i = 1:nS0
    for j = 1:(nT-1)
        UndlData.S0 = S0_arr(i);
        UndlData.Maturity = T_arr(j);
        grp(i,j) = optPrice(pricingMethod, UndlData);
    end
end

X = S0_arr - UndlData.Strike;
X(X<0) = 0;
grp(:,nT) = X;

figure
mesh(S0_arr,T_arr,transpose(grp))
ylim([0 T])

xlabel('Stock Price at t0')
ylabel('Time to maturity')
zlabel('Option Price')

end