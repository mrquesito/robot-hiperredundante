g = 10;     %acc. gravedad, m/s*s
r = 0.05;   %distancia, cm
theta0 = pi/4;
C = 1;
S = 1;
N = 10;
mHerr = 0.25;   %kg

pares = zeros(1,N);
masas = zeros(1,N); %kg

%Motor 10
tau10 = C*mHerr*g*r
pares(10) = tau10;
%Elegimos pues el AX-12A, el más barato (1.5Nm)
masas(10) = 0.0546;

%Motor 9
%Probamos con el mismo, AX-12A
m = 2*masas(10);
tau9 = S*g*(m*r+mHerr*3*r)
%Sale, así que lo elegimos
masas(9) = masas(10);

%Motor 8
%Probamos con el mismo, AX-12A
tau8 = C*g*((masas(9)+masas(10))*3*r+mHerr*5*r)
%También sale, así que elegido
masas(8) = masas(10);

%Motor 7
%Probamos con el mismo, AX-12A
m = 2*masas(8);
tau7 = S*g*(m*r+(masas(9)+masas(10))*5*r+mHerr*7*r)
%Nos sigue valiendo, así que elegido
masas(7) = masas(8);

%Motor 6
%Probamos con el mismo, AX-12A
tau6 = C*g*((masas(7)+masas(8))*3*r+(masas(9)+masas(10))*7*r+mHerr*9*r)
%No vale, hay que pasar al AX-18A (1.8Nm)
masas(6) = 0.0059;

%Motor 5
%Probamos con el último, AX-18A
m56 = 2*masas(6);
m78 = masas(7)+masas(8);
m910 = masas(9)+masas(10);
tau5 = S*g*(m56*r+m78*5*r+m910*9*r+mHerr*11*r)
%Se pasa. Hay que ir a otro motor. El MX-28T (2.5Nm)
masas(5) = 0.072;
%A ver si ahora...
m56 = masas(5)+masas(6);
tau5 = S*g*(m56*r+m78*5*r+m910*9*r+mHerr*11*r)
%Elegido, el MX-28T

%Motor 4
%Probamos con el MX-28T
tau4 = C*g*(m56*3*r+m78*7*r+m910*11*r+mHerr*13*r)
%No llega. Ponemos el XM430-W210-T (4.1Nm)
masas(4) = 0.082;

%Motor 3
%Probamos con el  XM430-W210-T
masas(3) = masas(4);
m34 = masas(3)+masas(4);
tau3 = S*g*(m34*r+m56*5*r+m78*9*r+m910*13*r+mHerr*15*r)
%Llega, lo cogemos

%Motor 2
%Calculamos el par
tau2 = C*g*(m34*3*r+m56*7*r+m78*11*r+m910*15*r+mHerr*17*r)
%Elegimos el XM430-W210-T (4.1Nm). No llega, pero se queda cerca.
masas(2) = 0.082;

%Motor 1
%Ponemos a priori el mismo que para la art. 2
masas(1) = masas(2);
m12 = masas(1)+masas(2);
tau1 = S*g*(m12*r+m34*5*r+m56*9*r+m78*13*r+m910*17*r+mHerr*19*r)
%Y no da, pero si se pone con el eje paralelo al vector gravedad no tendría
%que vencerla. Así que igual ésta es una posible distribución. Escribir en
%el cuaderno.