function [ A0, O, B0, X, M, U, C, Y, N, V, A1, F, B1 ] = calculaPuntos(R, h, a, b, q)
%Pasamos q a radianes
q = deg2rad(q);
Sq = sin(q);
Cq = cos(q);
%Asignamos las coordenadas de los puntos fijos
A0 = [-R,0];
O = [0,0];
B0 = [R,0];
X = [-a, b];
M = [0,b];
U = [a, b];
C = [0,h/2];
%Ahora, los variables
N = [-(h/2-b)*Sq, h/2+(h/2-b)*Cq];
V = N+[a*Cq, a*Sq];
Y = N-[a*Cq, a*Sq];
F = C+(h/2)*[-Sq, Cq];
B1 = F + R*[Cq,Sq];
A1 = F - R*[Cq,Sq];

end

