function [ longitud ] = calcularLongitud4( theta, h, R, d, b, c )
%Dibujo en pág 142
rot = [cos(theta), -sin(theta); sin(theta), cos(theta)];
O = [0; 0];
A = [R; 0];
C = [0; h];
G = rot*[c; -b]+C;
B = rot*[R; d]+C;
if G(1) > A(1)  %Toca el borde
    longitud = norm(A-G)+norm(G-B);
else
    longitud = norm(A-B);
end
end

