function [ d0, d1 ] = calcularLongitudesConfiguracion( q )
%q es un vector de 1x4 ángulos, en grados
q = deg2rad(q);
d0 = zeros(1,4);
d1 = zeros(1,4);
%Todo de forma muy aproximada. Ángulo positivo al ser antihorario mirando
%desde el bloque de motores hacia el robot.
%De la estructura
h = 67.3; %mm
r = 30;   %mm
%Del tambor
R = 6;    %mm
m = 1200;   %pasos/vuelta
L = 2*pi*R; %Longitud bobina

for i = 1:4
    %Longitud asociada al segmento actual
    d0_ = norm([r*(1-cos(q(i))),h-r*sin(q(i))]);
    d1_ = norm([r*(1-cos(-q(i))),h-r*sin(-q(i))]);
    if i == 1
        d0(i) = d0_;
        d1(i) = d1_;
    else
        d0(i) = d0_ + d0(i-1);
        d1(i) = d1_ + d1(i-1);        
    end
end
end

