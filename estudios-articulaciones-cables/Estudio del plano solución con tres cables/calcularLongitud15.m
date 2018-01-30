function [ longitud ] = calcularLongitud15( theta, h, R, r )
%Dibujo en p�g 142
m = sqrt(R*R+h*h-r*r);
alpha = atan(R/h);
beta = atan(m/r);
longitud = m + r*(pi+theta-alpha-beta);


end

