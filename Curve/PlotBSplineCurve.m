% This script plots a random B-splines of degree 3 with a knot vector
% of knotVector = [0,0,0,0.33,0.66,1,1,1] and random control points.
% This script also plots the shape functions of such an B-spline. 
clc; clear; close all;
%% Inputs
knotVector = [0,0,0,0.33,0.66,1,1,1];
shapeFuncDg = 3;
%% Plots B-spline Basis Functions
[sfv, ksi] = computebspbfunctions(knotVector, shapeFuncDg);
[shpeFuncs, pKsi, usfv, uksi] = pairrngdmin(sfv, ksi, knotVector,...
    shapeFuncDg);
figure(1)
for ii = 1:size(uksi, 1)
    plot(uksi(ii, :), usfv(ii, :), 'color', "k", 'LineWidth', 1.5)
    hold on
end
axis([0 1 0 1])
xlabel('\fontname{Courier}\fontsize{12}\xi') 
subtitle({'\fontname{Courier}\fontsize{14} Polynomial Degree = 3'; ...
    '\fontname{Courier}\fontsize{14}\xi = [0,0,0,0.33,0.66,1,1,1]'})
title('\fontname{Courier}\fontsize{16} Shape Functions')
%% Plots B-spline Curves
num = length(knotVector) - 1 - shapeFuncDg;
cps = zeros(2, 1, num);
rng("shuffle")
for ii=1:num
   cps(:,:,ii) = 200 * rand(2,1) - 100;
end
curve = getbsplncrv(cps, shpeFuncs);
cps = reshape(permute(cps, [2, 1, 3]),...
    size(cps, 1)*size(cps, 2), size(cps, 3));
figure(2)
plot(cps(1,:), cps(2,:),"--o" , "color", "k",...
    "MarkerFaceColor", "k", 'LineWidth', 1.0)
hold on
plot(curve(1, :), curve(2, :), "k", 'LineWidth',1.5)
xlabel('\fontname{Courier}\fontsize{12} x') 
ylabel('\fontname{Courier}\fontsize{12} y')
subtitle({'\fontname{Courier}\fontsize{14} Polynomial Degree = 3'; ...
    '\fontname{Courier}\fontsize{14}\xi = [0,0,0,0.33,0.66,1,1,1]'})
title('\fontname{Courier}\fontsize{16} A Random B-spline Curve')
