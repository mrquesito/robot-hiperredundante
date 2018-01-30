function [ posArt, mth ] = calcularPosicion( q )
longitud = 67.3;
nArt = 4;
mth = zeros(3,3,nArt);
posArt = zeros(2,nArt);
q(1) = q(1)+90;
q = deg2rad(q);
%Primero calculamos las matrices de transformación
for i = 1:nArt
    valor = q(i);
    T = [cos(valor) -sin(valor) longitud*cos(valor);
        sin(valor)  cos(valor) longitud*sin(valor);
        0           0          1];
    mth(:,:,i) = T;
end

producto = eye(3);
for i = 1:nArt
    producto = producto*mth(:,:,i);
    posArt(1,i) = producto(1,3);
    posArt(2,i) = producto(2,3);
end

end

