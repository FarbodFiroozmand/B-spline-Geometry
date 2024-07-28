% This script plots a random B-spline surface of degree 2 in one direction
% and of degree 1 in another dircetion. with a knot vector
% of knotVector = [0,0,0,0.33,0.66,1,1,1] and random control points.
% This script also plots the shape functions of such an B-spline.
%%
clc; clear; close all;
%% Inputs
knotVectorKsi = [0,0,0,0.5,1,1,1];
knotVectorEta = [0,0,1,1];
nShapeFuncDg = 2;
mShapeFuncDg = 1;
%% Plot B-spline Basis Functions
[nsfv, ksi] = computebspbfunctions(knotVectorKsi, nShapeFuncDg);
[msfv, eta] = computebspbfunctions(knotVectorEta, mShapeFuncDg);
[nShpeFuncs, pKsi, nusfv, uksi] = pairrngdmin(nsfv, ksi, knotVectorKsi,...
    nShapeFuncDg);
[mShpeFuncs, pEta, mUSFV, ueta] = pairrngdmin(msfv, eta, knotVectorEta,...
    mShapeFuncDg);
figure(1)
zksi = zeros(1, length(uksi(2, :)));
zeta = zeros(1, length(ueta(2, :)));    
plot3(zeta, ueta(1, :), mUSFV(1, :), 'color', "k", 'LineWidth', 1.0)
hold on
plot3(uksi(2, :), zksi, nusfv(2, :), 'color', "k", 'LineWidth', 1.0)
hold on
shapeSrf = mUSFV(1, :)' * nusfv(2, :);
surf(uksi(2, :), ueta(1, :), shapeSrf)
shading faceted;
colormap("gray(10)");
grid on
xlabel('\fontname{Courier}\fontsize{12}\xi') 
ylabel('\fontname{Courier}\fontsize{12}\eta')
subtitle({'\fontname{Courier}\fontsize{14} Polynomial Degrees, \xi and \eta = 2 and 1'; ...
    '\fontname{Courier}\fontsize{14}\xi = [0,0,0,0.5,1,1,1], \eta = [0,0,0,1,1,1]'})
title('\fontname{Courier}\fontsize{16} Shape Function, 2 (\xi) and 1 (\eta)')
%% Plot B-spline Surface
nNum = length(knotVectorKsi) - 1 - nShapeFuncDg;
mNum = length(knotVectorEta) - 1 - mShapeFuncDg;
rng("shuffle")
cPs = zeros(nNum, mNum, 3);
for ii=1:nNum
    for jj = 1:mNum
        cPs(ii, jj, :) = rand(3,1);
    end
end
srf = getbsplnsrf(cPs, nShpeFuncs, mShpeFuncs);
x=(nonzeros(srf(:,:,1)));
y=(nonzeros(srf(:,:,2)));
z=(nonzeros(srf(:,:,3)));
figure(2)
plot3(x,y,z,'Color','#48494B')
for ii = 1:size(cPs, 1)
    hold on
    plot3(cPs(ii,:,1), cPs(ii,:,2), cPs(ii,:,3), '--.', 'color', 'k',...
        'LineWidth', 0.75)
end
for ii = 1:size(cPs, 2)
    hold on
    plot3(cPs(:,ii,1), cPs(:,ii,2), cPs(:,ii,3), '--.', 'color', 'k',...
        'LineWidth', 0.75)
end
grid on
xlabel('\fontname{Courier}\fontsize{12} x') 
ylabel('\fontname{Courier}\fontsize{12} y')
zlabel('\fontname{Courier}\fontsize{12} z')
subtitle({'\fontname{Courier}\fontsize{14} Polynomial Degrees, \xi and \eta = 2 and 1'; ...
    '\fontname{Courier}\fontsize{14}\xi = [0,0,0,0.5,1,1,1], \eta = [0,0,0,1,1,1]'})
title('\fontname{Courier}\fontsize{16} A Random B-spline Surface')