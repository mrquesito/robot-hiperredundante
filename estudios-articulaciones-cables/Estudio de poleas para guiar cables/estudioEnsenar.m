%El dibujo es de una sección/cable de la articulación de tipo rótula, tal y
%como se ve en la pág. 127. Es en 2D, pero la mitad correspondería a dicha
%sección (para que se vea mejor, se ha pintado plano)

%Primero, damos algunos valores iniciales
R = 5;
h = 16;
a = R*0.8;
b = h/4;
q_min = -70;
q_max = 70;

conPoleas = 1;  %Poner a 0 si queremos ver el efecto de no tenerlas

%Ahora, pintamos
N = 100;
figure(1);
vec_q = linspace(q_min, q_max, N);
vec_q = [vec_q(1:end-1), fliplr(vec_q)];
inc = vec_q(2)-vec_q(1);
for i = 1:length(vec_q)
    q = vec_q(i);
    [A0, O, B0, X, M, U, C, Y, N, V, A1, F, B1 ] = calculaPuntos(R, h, a, b, q);
    cla; hold on;
    xlim([-10,10]);
    ylim([0,20]);

    %La base
    pintaLinea(A0,B0,'b');
    pintaLinea(O,C,'b');
    pintaLinea(X,U,'b');
    %La estructura superior
    pintaLinea(A1,B1,'r');
    pintaLinea(C,F,'r');
    pintaLinea(Y,V,'r');
    %Las poleas
    scatter(U(1),U(2),80,'k','filled');
    scatter(V(1),V(2),80,'k','filled');
    scatter(X(1),X(2),80,'k','filled');
    scatter(Y(1),Y(2),80,'k','filled');
    %Los cables
    if ~conPoleas
        pintaLinea(A0,A1,'g');
        pintaLinea(B0,B1,'g');
    else
        %Los cables pasan por U,V,X,Y si estos puntos están contenidos en el
        %semiplano exterior a A0-A1, o a B0-B1. Para representarlo 
        %adecuadamente, veremos cuál es el punto de corte de la recta con
        %vector A0-A1 que pasa por Y, y el de la recta con vector B0-B1 
        %que pasa por V.
        mB = (B1(2)-B0(2))/(B1(1)-B0(1));
        if(V(2) > mB*(V(1)-B0(1))+B0(2) && q > 0) %Golpea la polea derecha
            pintaLinea(B1,V,'g');
            pintaLinea(V,U,'g');
            pintaLinea(U,B0,'g');
        else
            pintaLinea(B0,B1,'g');
        end
        mA = (A1(2)-A0(2))/(A1(1)-A0(1));
        if(Y(2) > mA*(Y(1)-A0(1))+A0(2) && q < 0) %Golpea la polea izquierda
            pintaLinea(A1,Y,'g');
            pintaLinea(Y,X,'g');
            pintaLinea(X,A0,'g');
        else
            pintaLinea(A0,A1,'g');
        end
        %Y, aun así, pintamos en azul clarito cómo serían los cables sin
        %poleas
        pintaLinea(A0,A1,'c');
        pintaLinea(B0,B1,'c');
    end
    drawnow;
    %pause(0.1);
end

