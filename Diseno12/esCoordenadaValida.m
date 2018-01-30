function [ esValida ] = esCoordenadaValida( x, y, matrizPosiblesXY, xVec, yVec, res)
xi = find(xVec == floor(x/res)*res);
yi = find(yVec == floor(y/res)*res);

[Ny,Nx] = size(matrizPosiblesXY);

esValida = matrizPosiblesXY(xi,yi);
end

