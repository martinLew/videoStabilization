function y = myBilinear(ori, lat, gridLen)
    [h,w] = size(ori);
    % gridX = floor(size(ori, 2)/gridLen);    % make the last column +1
    % gridY = floor(size(ori, 1)/gridLen);
    x = lat(:, :, 1);
    y = lat(:, :, 2);
    
    indOut = find(x<1 | x>w | y<1 | y> h);
    x(indOut) = 1;
    y(indOut) = 1;              % make the out of range poixel to (1,1)
    
    % for spline 1 sp1_x, sp1_y
    % for spline 2 sp1_x-1, sp1_y
    % for spline 3 sp1_x-1, sp1_y-1
    % for spline 4 sp1_x, sp1_y-1
    sp1_x = mod(x-1, gridLen)/gridLen;
    sp1_y = mod(y-1, gridLen)/gridLen;
    left = floor((x-1)/gridLen) * gridLen;
    right = (floor((x-1)/gridLen)+1) * gridLen-1;
    down = floor((y-1)/gridLen) * gridLen * w;
    up = ((floor((y-1)/gridLen) + 1) * gridLen -1) * w;
    
    
    % indOut = find(left<0 | right>gridX | down<0 | up>gridY);

    oriTmp = ori';
    spPoint1 = down + left + 1;
    %spPoint1(indOut) = 1;
    point1 = oriTmp(spPoint1);
    spPoint2 = down + right + 1;
    %spPoint2(indOut) = 1;
    point2 = oriTmp(spPoint2);
    spPoint3 = up + right + 1;
    %spPoint3(indOut) = 1;
    point3 = oriTmp(spPoint3);
    spPoint4 = up + left + 1;
    %spPoint4(indOut) = 1;
    point4 = oriTmp(spPoint4);   
    
    %point1(indOut)=0; point2(indOut)=0; point3(indOut)=0; point4(indOut)=0;
    
    y = point1.*(1-abs(sp1_x)).*(1-abs(sp1_y)) + point2.*(1-abs(sp1_x-1)).*(1-abs(sp1_y)) + ...
        point3.*(1-abs(sp1_x-1)).*(1-abs(sp1_y-1)) + point4.*(1-abs(sp1_x)).*(1-abs(sp1_y-1));
    
    y(indOut) = 0;
end