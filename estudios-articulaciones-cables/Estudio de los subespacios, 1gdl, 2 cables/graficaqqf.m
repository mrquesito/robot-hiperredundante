%Gráfica para representar la curva l_A, l_B, f y colorear las distintas
%regiones 
R = 8;          %cm
h = 10;         %cm
thetaMin = -45; %º
thetaMax = 45;  %º
thetaStep = 2;  %º
%%
vector_theta = thetaMin:thetaStep:thetaMax;
N = length(vector_theta);
vector_A = zeros(1,N);
vector_B = zeros(1,N);
matriz_f = zeros(N,N);
for i = 1:N
    theta = deg2rad(vector_theta(i));
    xA = R*(1-cos(theta));
    yA = h-R*sin(theta);
    xB = R*(1-cos(theta));
    yB = h+R*sin(theta);
    vector_A(i) = sqrt(xA*xA+yA*yA);
    vector_B(i) = sqrt(xB*xB+yB*yB);
end

%Ahora, para cada f(l_A, l_B) con l_A, l_B los que están en los vectores...
%operamos

for i = 1:N
    lA = vector_A(i);
    for j = 1:N
        lB = vector_B(j);
        if lB <= vector_B(i)    %Entonces, no estamos en J
            sumaS = vector_A(i) + vector_B(i);  %Suma de longitudes en S
            sumaP = lA + lB;    %Suma de longitudes del punto en sí
            f = (sumaS-sumaP)/sumaS;    %Pseudofuerza ejercida
            matriz_f(i,j) = f;
        end
    end
end
%Colores
C = zeros(N,N);
for i = 1:N
    for j = 1:N
        f = matriz_f(i,j);
        if f < 0.01
            c = 0.7;
        elseif f < 0.1
            c = 0.2;
        elseif f < 0.2
            c = 0.1;
        else
            c = 0;
        end
        C(i,j) = c;
    end
end
C(1,1) = 1;

m = max(max(matriz_f));
matriz_f = matriz_f./m; %Normalizamos


close all;
X = repmat(vector_A(:),1,N);
Y = repmat(vector_B(:),1,N)';
surf(X,Y,sin(pi.*matriz_f./2),C);
xlim([min(vector_A), max(vector_A)]);
ylim([min(vector_B), max(vector_B)]);
colormap hsv
%shading interp 
xlabel('l_{A} [cm]');
ylabel('l_{B} [cm]');
zlabel('f (normalizada)');

%Ahora, la curva qf
figure(2);
