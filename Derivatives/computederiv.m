% This function computes the derivative of B-spline shape (basis) functions.
% It takes the polynomial degree (shapeFuncDg), the order of the derivative
% and a set of knots (knotVector) as inputs, and returns the values of the derivative of 
% basis functions.
%
% INPUTS:
%   degree  - An integer defining the polynomial degree of the B-spline.
%   order - An integer defining the order of the derivative
%   knotVec - An array allocated to the knot vector
%
% OUTPUTS:
%   derivShapeFunction - A 2d matrix each row of which represents the derivative of a shape function.
%
% Example:
%   derivShapeFunction = computederiv(degree, order, knotVec);
function derivShapeFunction = computederiv(degree, order, knotVec)
    if order == 1 
        lowShapeFunctions = computebspbfunctions(knotVec, degree-1);
        lowShapeFunctions2d = (reshape(permute(lowShapeFunctions, [2, 1, 3]),...
        size(lowShapeFunctions, 1)*size(lowShapeFunctions, 2), size(lowShapeFunctions, 3)))';
        shapeFuncNum = size(lowShapeFunctions2d,1)-1;
        shapeFuncLength =  size(lowShapeFunctions2d, 2);
        derivShapeFunction = zeros(shapeFuncNum, shapeFuncLength);        
        for ii = 1:shapeFuncNum
            if knotVec(ii+degree) - knotVec(ii) == 0 && knotVec(ii+degree+1) - knotVec(ii+1) == 0
                derivShapeFunction(ii, :) = 0;
            elseif knotVec(ii+degree) - knotVec(ii) == 0
                derivShapeFunction(ii, :) = -1*degree*lowShapeFunctions2d(ii+1, :)...
                    /(knotVec(ii+degree+1) - knotVec(ii+1));
            elseif knotVec(ii+degree+1) - knotVec(ii+1) == 0
                derivShapeFunction(ii, :) = degree*lowShapeFunctions2d(ii, :)...
                    /(knotVec(ii+degree) - knotVec(ii));
            else
                derivShapeFunction(ii, :) = degree*lowShapeFunctions2d(ii, :)/...
                    (knotVec(ii+degree) - knotVec(ii))... 
                -(degree*lowShapeFunctions2d(ii+1, :)/...
                (knotVec(ii+degree+1) - knotVec(ii+1)));
            end 
        end
    else
        lowShapeFunctions2d = computederiv(degree-1, order-1, knotVec);
        shapeFuncNum = size(lowShapeFunctions2d,1)-order;
        shapeFuncLength =  size(lowShapeFunctions2d, 2);
        derivShapeFunction = zeros(shapeFuncNum, shapeFuncLength);
        for ii = 1:shapeFuncNum
            if knotVec(ii+degree) - knotVec(ii) == 0 && knotVec(ii+degree+1) - knotVec(ii+1) == 0
                derivShapeFunction(ii, :) = 0;
            elseif knotVec(ii+degree) - knotVec(ii) == 0
                derivShapeFunction(ii, :) = -degree*lowShapeFunctions2d(ii+1, :)...
                    /(knotVec(ii+degree+1) - knotVec(ii+1));
            elseif knotVec(ii+degree+1) - knotVec(ii+1) == 0
                derivShapeFunction(ii, :) = degree*lowShapeFunctions2d(ii, :)...
                    /(knotVec(ii+degree) - knotVec(ii));
            else
                derivShapeFunction(ii, :) = degree*lowShapeFunctions2d(ii, :)/...
                    (knotVec(ii+degree) - knotVec(ii))... 
                -degree*lowShapeFunctions2d(ii+1, :)/...
                (knotVec(ii+degree+1) - knotVec(ii+1));
            end 
        end
    end
end
