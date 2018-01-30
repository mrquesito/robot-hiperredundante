function [ longitud ] = longitudPolea(theta, d, R, r, h)
%Dibujo en la p�g 141
%C�lculo de la longitud del cable desde su punto superior hasta el
%inferior, en una polea con posible interrupci�n (d)
%El sentido de giro es saliendo del papel.
alpha = acos(d/r);
m = sqrt(R*R+h*h-r*r);
beta = asin(m/sqrt((R*R+h*h)));
n = r*(pi-alpha-beta+theta);
if n >= 0
    longitud = m + n;
else
    v1 = [R;0];
    v2 = [R*cos(theta)-d*sin(theta); R*sin(theta)+d*cos(theta)+h];
    longitud = norm(v2-v1);
end
end

