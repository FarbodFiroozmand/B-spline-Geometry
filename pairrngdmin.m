% This function pairs the shape (basis) function values with  its domain.
% It takes two 3d matrices of shape function values and knots, knot vector,
% and the polynomial degree (shapeFuncDg) as inputs, and returns
% the basis function values (shapeFuncVals) and returns four outputs, among
% which two are 2d matrices of the same shape function values and knot
% values, and the other two are the same matrices without zero-valued rows.
%
% INPUTS:
%   shapeFuncVals - A 3d matrix comprising shape function values 
%   pKsi - A 3d matrix containing the knot values.
%   knotVector  - A vector containing the knots for the B-spline.
%   shapeFuncDg - An integer specifying the polynomial degree of the B-spline.
%
% OUTPUTS:
%   shapeFuncVals - A 2d matrix of shape function values.
%   pKsi - A 2d matrix of knot values.
%   usfv - A reduced 2d matrix of shape function values without zero rows.
%   uski - A reduced 2d matrix of knot values without zero rows. 
% Example :
%   shapeFuncVals, pKsi, usfv, uksi] = pairrngdmin(sfv, ksi, knotVector, shapeFuncDg);
function [shapeFuncVals, pKsi, usfv, uksi]...
    = pairrngdmin(sfv, ksi, knotVector, shapeFuncDg)
    nShapeFunc = length(knotVector);
    nd = nShapeFunc - shapeFuncDg - 1;
    sfvSqueezed = (reshape(permute(sfv, [2, 1, 3]),...
        size(sfv, 1)*size(sfv, 2), size(sfv, 3)))';
    shapeFuncVals = sfvSqueezed;
    pKsiRaw = zeros(nShapeFunc-1, size(ksi, 2), size(ksi, 3));
    for ii = 1:nd
        pKsiRaw(ii:shapeFuncDg+ii, :, ii) = ksi(:, :, ii);
    end
    pKsi = (reshape(permute(pKsiRaw, [2, 1, 3]),...
        size(pKsiRaw, 1)*size(pKsiRaw, 2), size(pKsiRaw, 3)))';

    usfv = zeros(shapeFuncDg+1, size(sfv, 2), size(sfv, 3));
    uksi = zeros(shapeFuncDg+1, size(sfv, 2), size(sfv, 3));
    for ii = 1:nd
        usfv(:,:,ii) = sfv(ii:ii+shapeFuncDg, :, ii);
        uksi(:, :, ii) = pKsiRaw(ii:ii+shapeFuncDg, :, ii);
    end
    for ii = 1:size(usfv, 3)
        for jj = 1:size(usfv, 1)
            if all(usfv(jj, :, ii) == 0) 
                usfv(jj, :, ii) = NaN;
            end
        end
    end
    usfv = (reshape(permute(usfv, [2, 1, 3]),...
        size(usfv, 1)*size(usfv, 2), size(usfv, 3)))';
    uksi = (reshape(permute(uksi, [2, 1, 3]),...
        size(uksi, 1)*size(uksi, 2), size(uksi, 3)))';
end