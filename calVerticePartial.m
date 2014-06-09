function [gu, gv] = calVerticePartial(verX, verY, It, Ix, Iy, gridLen)
    % TODO(yiminglu): could we transfer the 'for' to operation of matrix
    h = size(It, 1);
    w = size(It, 2);
    verH = length(verX);
    verW = length(verY);
    gu = zeros(verH*verW, 1);
    gv = zeros(verH*verW, 1);
    ig = 1;
    for i = verY
        for j = verX
            lin = (i-gridLen+1):(i+gridLen-1);
            row = (j-gridLen+1):(j+gridLen-1);
            indl = find(lin<1 | lin>w);
            lin(indl) = [];
            indr = find(row<1 | row>h);
            row(indr) = [];
            
            e = It(row, lin);
            Gx = Ix(row, lin);
            Gy = Iy(row, lin);
            y = meshgrid(lin, row);
            x = meshgrid(row, lin);
            x = x';
            omi = (1-abs(x-j)).*(1-abs(y-i));
            
            guMat = e.*Gx.*omi;
            gvMat = e.*Gx.*omi;
            gu(ig) = 2*sum(guMat(:));
            gv(ig) = 2*sum(gvMat(:));
            ig = ig + 1;
        end
    end
end


