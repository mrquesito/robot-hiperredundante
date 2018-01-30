qi = [5,5,5,5];
xf = 0;
yf = 260;
%q = resolverCI(xf,yf,qi)
%q_inicial = resolverCI(40,180,zeros(1,4))

%q_inicial = zeros(1,4);
tiempo = 8;


%q_inicial = irPosicion(s1,s2,-142,220,q_inicial,tiempo);
%q_inicial = irPosicion(s1,s2,91,240,q_inicial,tiempo);
%Dos puntos entre los que puede haber línea recta
% (xi,yi) = (-91,240)
% (xf,yf) = (60,250)
%Reposo
x_reposo = 0;
y_reposo = 269;
%Otros, en vertical
x1 = -165;
y1 = 202;
x2 = -66;
y2 = 256;
q_inicial = irPosicion(s1,s2,x1,y1,q_inicial,tiempo);
pause(1);
q_inicial = irPosicion(s1,s2,x2,y2,q_inicial,tiempo);
pause(1);
q_inicial = reposo(s1,s2,q_inicial, tiempo);


%% Pruebas línea recta
%Dos puntos entre los que puede haber línea recta
%(xi,yi) = (-91,240)
%(xf,yf) = (60,250)
%disable(s1,s2)
xi = -245;
yi = 67;
xf = 38;
yf = 260;
tiempo = 4;
q_inicial = irPosicion(s1,s2,xi,yi,q_inicial,tiempo);
pause(1);
tiempo = 24;
q_inicial = lineaRectaSinCheck(s1, s2, xf, yf, q_inicial, tiempo);

%% Dibujar cuadrado
x1 = -96;
y1 = 247;
x2 = -62;
y2 = 247;
x3 = -62;
y3 = 231;
x4 = -96;
y4 = 231;
x_Vec = [x1, x2, x3, x4];
y_Vec = [y1, y2, y3, y4];
tiempo = 2;
q_inicial = irPosicion(s1,s2,x_Vec(4),y_Vec(4),q_inicial,tiempo*2);
%for i = 1:2 %Número de cuadrados
    for j = 1:4
       q_inicial = irPosicion(s1,s2,x_Vec(j),y_Vec(j),q_inicial,tiempo);
       pause(0.15);
    end
%end

