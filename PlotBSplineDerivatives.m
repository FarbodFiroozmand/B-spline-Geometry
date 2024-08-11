% This script plots the derivatives of the shapes functions of the B-splines. 
clc; clear; close all;
%% Inputs
knotVector = [0,0,0,0,0,0.25,0.25,0.5,0.75,1,1,1,1,1];
shapeFuncDg = 4;
%% Plot Derivative of the Basis Functions
[sfv, ksi] = computebspbfunctions(knotVector, shapeFuncDg);
[shpeFuncs, pKsi, usfv, uksi] = pairrngdmin(sfv, ksi, knotVector,...
    shapeFuncDg);
order = 2;
derivShapeFunction = computederiv(shapeFuncDg, order, knotVector);
nsfv = length(knotVector)-shapeFuncDg-order*(order-1)/2-1;
nrange = size(derivShapeFunction, 2)/(length(knotVector)-1);
rdsfv = zeros(nsfv, (shapeFuncDg+1)*nrange);
derKsi = zeros(nsfv, (shapeFuncDg+1)*nrange);
for ii = 1:nsfv
    rdsfv(ii, :) = derivShapeFunction(ii, (ii-1)*nrange+1:(shapeFuncDg+ii)*nrange);
    derKsi(ii, :) = pKsi(ii, (ii-1)*nrange+1:(shapeFuncDg+ii)*nrange);
end
nrow = size(rdsfv, 1);
ncol = size(rdsfv, 2);
for ii = 1:nrow
    for jj = 1:ncol
        if rdsfv(ii, jj) == 0 && derKsi(ii, jj) == 0
            rdsfv(ii, jj) = NaN;
        end
    end
end
figure(1)
for ii = 1:size(derKsi, 1)
    plot(derKsi(ii, :), rdsfv(ii, :), 'color', "k", 'LineWidth', 1.5)
    hold on
end
xlabel('\fontname{Courier}\fontsize{12}\xi') 
subtitle({'\fontname{Courier}\fontsize{14} Polynomial Degree = 4'; ...
    '\fontname{Courier}\fontsize{14}Order = 2';...
    ['\fontname{Courier}\fontsize{12}' ...
    '\xi = [0,0,0,0,0.25,0.25,0.5,0.75,1,1,1,1]']})
title('\fontname{Courier}\fontsize{16} Derivatives of Shape Functions')
ax = gca;
ax.XAxisLocation = 'origin';
xticks([0 0.25 0.5 0.75 1])
xticklabels({'','','','', ''})