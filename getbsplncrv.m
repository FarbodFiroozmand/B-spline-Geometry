% This functions approximates a B-spline curve by computing enough number 
% of points on the ideal curve using control points (cPts) and the shape
% (or basis) function values.
%
% INPUTS:
%   cPts - A real-valued 3-d vector containing all the necessary control points.
%   shapeFuncs - A real-valued vector containg the shape function values.
% OUTPUTS:
%   bSpln - The computed points on the B-spline curve.
% Example:
%   bSpln = getbsplncrv(cPts, shpeFuncs);
function bSpln = getbsplncrv(cPts, shpeFuncs)
    if size(cPts, 3) ~= size(shpeFuncs, 1)  % Checks if the number of control points is correct.
        error('NO B-SPLINE CURVE FOR YOU!')
    else
    bSpln = zeros(size(cPts, 1), size(shpeFuncs, 2));   % Initiliases the 2-d vector of the points on the curve. 
    for ii = 1:size(cPts, 3)
        bSpln = bSpln + cPts(:, :, ii) .* shpeFuncs(ii, :); % Estimates the B-spline curve. 
    end
        for ii = 1:size(bSpln, 1)
            for jj = 1:size(bSpln, 2)
                if bSpln(ii, jj) == 0 
                    bSpln(ii, jj) = NaN;    % Substitutes all zeros in the vector with NaNs. 
                end
            end
        end
    end
end