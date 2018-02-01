g = 10;     %acc. gravedad, m/s*s
r = 0.05;   %distancia, cm
theta0 = pi/4;
C = 1;
S = 1;
N = 10;
mHerr = 0.2;   %kg

pares = zeros(1,N);
masas = zeros(1,N); %kg

%Motor 10
tau10 = C*mHerr*g*r
pares(10) = tau10;
%Elegimos pues el DRS-0101, el más barato (1.2Nm)
masas(10) = 0.045;

%Motor 9
%Probamos con el mismo, DRS-0101
m = 2*masas(10);
tau9 = S*g*(m*r+mHerr*3*r)
%Sale, así que lo elegimos
masas(9) = masas(10);

%Motor 8
%Probamos con el mismo, DRS-0101
tau8 = C*g*((masas(9)+masas(10))*3*r+mHerr*5*r)
%También sale, así que elegido
masas(8) = masas(10);

%Motor 7
%Probamos con el mismo, DRS-0101
m = 2*masas(8);
tau7 = S*g*(m*r+(masas(9)+masas(10))*5*r+mHerr*7*r)
%Nos sigue valiendo, así que elegido
masas(7) = masas(8);

%Motor 6
%Probamos con el mismo, DRS-0101
tau6 = C*g*((masas(7)+masas(8))*3*r+(masas(9)+masas(10))*7*r+mHerr*9*r)
%No vale, hay que pasar al DRS-0201 (2.4Nm)
masas(6) = 0.06;

%Motor 5
%Probamos con el último, DRS-0201
m56 = 2*masas(6);
m78 = masas(7)+masas(8);
m910 = masas(9)+masas(10);
tau5 = S*g*(m56*r+m78*5*r+m910*9*r+mHerr*11*r)
%Elegido, el DRS-0201

%Motor 4
%Probamos con el DRS-0201
tau4 = C*g*(m56*3*r+m78*7*r+m910*11*r+mHerr*13*r)
%Bien, lo cogemos

%Motor 3
%Probamos con el  DRS-0201
masas(3) = masas(4);
m34 = masas(3)+masas(4);
tau3 = S*g*(m34*r+m56*5*r+m78*9*r+m910*13*r+mHerr*15*r)
%No llega pero por poco, lo cogemos por tener motores del mismo tipo


%Motor 2
%Calculamos el par
tau2 = C*g*(m34*3*r+m56*7*r+m78*11*r+m910*15*r+mHerr*17*r)
%Elegimos el DRS-0401 (4.3Nm@12V, 5.2@14.8V).
masas(2) = 0.123;

%Motor 1
%Ponemos a priori el mismo que para la art. 2
masas(1) = masas(2);
m12 = masas(1)+masas(2);
tau1 = S*g*(m12*r+m34*5*r+m56*9*r+m78*13*r+m910*17*r+mHerr*19*r)
%Y ya está, elegido