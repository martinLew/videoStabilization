function M = levelOptimation(img, nsz, m, gridLen, iterNum)
    if nargin < 5
        iterNum = 9;
    end
    
    for i=1:iterNum     % iterNum to converge
        uv = calculateUV(m, nsz);   % TODO(yiminglu): here, we use m to cal uv, maybe should
                                    % use control vertice info, too
        [It, Ix, Iy] = partial_deriv(img, uv)   % use inter='cubic' default filter b=0.5
                                                % TODO(yiminglu): adjust the
                                                % param to observe the performance 
                                                
        [conVerX, conVerY] = getVerticeXY(nsz, gridLen); % get the coordinate of control vertice
        
        [gu, gv] = calVerticePartial(conVerX, conVerY, It, Ix, Iy);
    end
    
end