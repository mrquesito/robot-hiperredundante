function [ vec, x, y, z ] = partePosicion( T )
%Devuelve la parte de posici�n de una MTH
vec = T(1:3,4);
x = vec(1);
y = vec(2);
z = vec(3);
end

