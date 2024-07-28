% This functions approximates a B-spline surface by computing enough number 
% of points on the ideal surface using control points (cpts) and the shape
% (or basis) function values.
%
% INPUTS:
%   cpts - A real-valued 3-d vector containing all the necessary control points.
%   nShpeFuncs - A real-valued vector containg the shape function values in the ksi direction.
%   mShpeFuncs - A real-valued vector containg the shape function values in the eta direction.
% OUTPUTS:
%   bSpSrf - The computed points on the B-spline surface.
% Example:
%   bSpSrf = getbsplnsrf(cpts, nShpeFuncs, mShpeFuncs)
function bSpSrf = getbsplnsrf(cpts, nShpeFuncs, mShpeFuncs)     
    if size(cpts, 1) + size(cpts, 2) ~= size(nShpeFuncs, 1) + size(mShpeFuncs, 1)   % Checks if the number of control points is correct.
        error('NO B-SPLINE SURFACE FOR YOU!')
    else
        bSpSrf = zeros(size(nShpeFuncs, 2), size(mShpeFuncs, 2), size(cpts, 3));    % Initiliases the 3-d vector of the points on the surface.
        for ii = 1:size(cpts, 3)
           bSpSrf(:,:,ii) = nShpeFuncs' * cpts(:, :, ii) * mShpeFuncs;  % Estimates the B-spline surface.
        end
        for ii = 1:size(bSpSrf, 1)
            for jj = 1:size(bSpSrf, 2)
                if bSpSrf(ii, jj, :) == 0 
                    bSpSrf(ii, jj, :) = NaN;    % Substitutes all zeros in the vector with NaNs.
                end
            end
        end
    end
end