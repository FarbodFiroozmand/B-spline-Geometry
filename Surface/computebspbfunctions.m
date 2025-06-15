% This function computes the shape (basis) function values for a B-spline.
% It takes a set of knots (knotVector) and the polynomial degree (shapeFuncDg) 
% as inputs, and returns the basis function values (shapeFuncVals) and a 
% knot vector (ksi) containing 100 values in each interval.
%
% INPUTS:
%   knotVector  - A vector containing the knot values for the B-spline.
%   shapeFuncDg - An integer specifying the polynomial degree of the B-spline.
%
% OUTPUTS:
%   shapeFuncVals - The computed shape (basis) function values.
%   ksi - A vector containing 100 values in each interval of the original knot vector.
%
% Example:
%   [shapeFuncVals, ksi] = computebspbfunctions(knotVector, shapeFuncDg);
function [shapeFuncVals, ksi] = computebspbfunctions(knotVector, shapeFuncDg)
    nShapeFunc = length(knotVector);    % Stores the number of shape functions.
    num = 100;  % Stores the number of values in each interval of the knot vector.
    ksi0 = zeros(1, num, nShapeFunc-1); % Knot vector initialisation for the degree of zero.
        for ii = 1:nShapeFunc-1     % Generates knot vector for the degree of zero.
            if knotVector(ii) < knotVector(ii+1)
                ksi0(1, :, ii) = linspace(knotVector(ii),...
                    knotVector(ii+1), num);
            end
        end 
    if shapeFuncDg == 0 % Computes shape functions for the degree of zero.
        ksi = ksi0;
        shapeFuncVals = zeros(nShapeFunc-1, num, nShapeFunc-1);
        for ii = 1:nShapeFunc-1
            if knotVector(ii) >= knotVector(ii+1)
                shapeFuncVals(ii, :, ii) = 0;
            else 
                shapeFuncVals(ii, :, ii) = 1;
            end
        end
    elseif shapeFuncDg < 0  % Checks whether someone has been nughty!
            error("NO BASIS FUNCTION FOR YOU!")
    else    % Computes shape functions for the degrees greater than zero.
        SFV0 = computebspbfunctions(knotVector, shapeFuncDg-1);
        shapeFuncVals = zeros(nShapeFunc-1, num, nShapeFunc-shapeFuncDg-1);
        ksi = zeros(shapeFuncDg+1, num, nShapeFunc-shapeFuncDg-1);
        ksi0 = permute(ksi0, [3,2,1]);
        for ii = 1:nShapeFunc-shapeFuncDg-1
            ksi(:, :, ii) = ksi0(ii:shapeFuncDg+ii, :, :);
        end
        for ii = 1:nShapeFunc-shapeFuncDg-1
            if ii+shapeFuncDg+1 > nShapeFunc
                shapeFuncVals(jj, :, ii) = 0;   
            else
                knVeca1 = knotVector(ii);
                knVeca2 = knotVector(ii+shapeFuncDg);
                knVecb1 = knotVector(ii+1);
                knVecb2 = knotVector(ii+shapeFuncDg+1);
            end
            for jj = 1:shapeFuncDg+1
                if knVeca2 - knVeca1 == 0 && knVecb2 - knVecb1 == 0
                    shapeFuncVals(jj,:,ii) = 0;
                elseif knVeca2 - knVeca1 == 0
                    shapeFuncVals(ii+jj-1,:,ii) = (knVecb2 - ksi(jj, :, ii))...
                        /(knVecb2 - knVecb1).* SFV0(ii+jj-1, :, ii+1);
                elseif knVecb2 - knVecb1 == 0
                    shapeFuncVals(ii+jj-1,:,ii) = (ksi(jj, :, ii) - knVeca1)...
                        /(knVeca2 - knVeca1).* SFV0(ii+jj-1, :, ii);
                else
                firstPart = (ksi(jj, :, ii) - knVeca1)/(knVeca2 - knVeca1)...
                    .* SFV0(ii+jj-1, :, ii);
                secondPart = (knVecb2 - ksi(jj, :, ii))/(knVecb2 - knVecb1)...
                    .* SFV0(ii+jj-1, :, ii+1);
                shapeFuncVals(ii+jj-1,:,ii)=firstPart+secondPart;
                end                
            end
        end
    end
