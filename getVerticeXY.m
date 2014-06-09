function [verticeX, verticeY] = getVerticeXY(nsz, gridLen)
    h = nsz(1);
    w = nsz(2);
    if mod(h, gridLen) ~= 0 || mod(w, gridLen) ~= 0
        display('the rows is not valid');
        % exit(1);
    end
    verticeX = 1:gridLen:(h+1);
    verticeX(end) = verticeX(end) - 1;
    verticeY = 1:gridLen:(w+1);
    verticeY(end) = verticeY(end) - 1;    
    
end