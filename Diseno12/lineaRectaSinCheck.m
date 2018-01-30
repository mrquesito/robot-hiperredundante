function [ q_final ] = lineaRectaSinCheck(s1, s2, xf, yf, q_inicial, tiempo)
%Describe una línea recta hasta (xf, yf) desde la posición de partida
%asumiendo que esa trayectoria es posible
[ posArt, ~ ] = calcularPosicion( q_inicial );  %Calculamos la cinemática directa
xi = posArt(1,4);
yi = posArt(2,4);

%Calculamos la distancia cartesiana
dx = xf-xi;
dy = yf-yi;
dist = norm([dx,dy]);
incMax = 10; %En mm
n = ceil(dist/incMax);  %Número de coordenadas
%Vectores con coordenadas
x_vec = linspace(xi,xf,n);
y_vec = linspace(yi,yf,n);

for i = 2:n
    x_next = x_vec(i);
    y_next = y_vec(i);
    q_inicial = irPosicion(s1,s2,x_next,y_next,q_inicial,tiempo/(n-1));
end
q_final = q_inicial;


end

