function UV = calculateUV(m, nsz)
    m = reshape(m, [3,3]);
    m = m';
    
    X = repmat((1:nsz(1))', [nsz(2),1]);    % the num of rows as X
    Y = repmat(1:nsz(2), [nsz(1),1]);
    Y = Y(:);
    CXY = [X, Y, ones(nsz(1)*nsz(2), 1)];
    CXY = CXY';
    
    factors = m*CXY;
    u = factors(1, :)./factors(3, :) - X';
    u = reshape(u, [nsz(1), nsz(2)]);
    v = factors(2, :)./factors(3, :) - Y';
    v = reshape(v, [nsz(1), nsz(2)]);
    
    UV = cat(3, u, v);
end