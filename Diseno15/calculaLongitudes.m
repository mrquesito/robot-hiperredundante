function [ vec_longitudes ] = calculaLongitudes( q )

%% Parámetros del robot (mirar dibujo cuaderno)
h = 59.5;
d = 16;
R = 27;
ng = 12; 

%% Generación de parámetros DH
n = 4;
vec_theta = q; %Vector de q's
%vec_theta(1) = 0.2;
%vec_theta(2) = -0.5;
%vec_theta(3) = -0.1;
%vect_theta(4) = 0.6;
%vec_theta = 0.5*(rand(1,n)-0.5);

vec_d = zeros(1,n);
vec_a = h*ones(1,n);
vec_a(n) = d;
vec_alpha = zeros(1,n);
for i = 1:n-1
    vec_alpha(i) = pi/2;
    if mod(i,2) == 0
        vec_alpha(i) = -vec_alpha(i);
    end
end

%% Cálculo de Matrices DH
%Primero, las simples/de un solo paso (0A1, 1A2, 2A3...)
MTH_simples = cell(1,n);
for i = 1:n
    MTH_simples{i} = calculoMTH_DH(vec_theta(i),vec_d(i),vec_a(i),vec_alpha(i));
end
%Ahora, las cumulativas: para pasar de la base del robot al eslabón i 
MTH_cumulativas = cell(1,n);
MTH_cumulativas{1} = MTH_simples{1};
for i = 2:n
    MTH_cumulativas{i} = MTH_cumulativas{i-1}*MTH_simples{i};
end

%% Obtenemos las coordenadas de las bases
vec_x_bases = zeros(1,n+1);
vec_y_bases = zeros(1,n+1);
vec_z_bases = zeros(1,n+1);

for i = 2:n+1
    [~, vec_x_bases(i), vec_y_bases(i), vec_z_bases(i)] = partePosicion(MTH_cumulativas{i-1});
end

%% Cálculo de matrices de agujero
MTH_agujeros_impar = cell(1,ng);
MTH_agujeros_par = cell(1,ng);

for i = 1:ng
    gamma = 2*pi*(i-1)/ng;
    Cg = cos(gamma);
    Sg = sin(gamma);

    
    MTH_agujeros_impar{i} = [1,  0,   0,   d-h;
                             0, Cg, -Sg, -R*Sg;
                             0, Sg,  Cg,  R*Cg;
                             0,  0,   0,    1];
    MTH_agujeros_impar{i} = [rotx(gamma), [d-h; -R*Sg; R*Cg]; 0, 0, 0, 1];
    %Giro en torno a Z
    
    MTH_agujeros_par{i} = [1,  0,   0,     d-h;
                           0, Cg, -Sg,  -R*Cg;
                           0, Sg,  Cg,  -R*Sg;
                           0,  0,   0,     1];
    

end

%% Cálculo de los puntos característicos de los agujeros
coords_agujeros = cell(n,ng);
x_agujeros = zeros(n,ng);
y_agujeros = zeros(n,ng);
z_agujeros = zeros(n,ng);
%Primero calculamos todos los discos, salvo el del efector final
for i = 1:n-1
    for j = 1:ng
        T_base = MTH_cumulativas{i};
%        [vec_base, ~, ~, ~] = partePosicion(T_base);
%        R_base = parteRotacion(T_base);
        if mod(i,2)
            MTH_agujeros = MTH_agujeros_impar{j};
        else
            MTH_agujeros = MTH_agujeros_par{j};
        end
%        [vec_agujeros,~,~,~] = partePosicion(MTH_agujeros);
%        R_agujeros = parteRotacion(MTH_agujeros);
        
        T = T_base*MTH_agujeros;
        %T = [R
        [vec,x,y,z] = partePosicion(T);
        coords_agujeros{i,j} = vec;
        x_agujeros(i,j) = x;
        y_agujeros(i,j) = y;
        z_agujeros(i,j) = z;
    end
end

%Y ahora, el último
T_base = MTH_cumulativas{n};
for j = 1:ng
    if mod(n,2)
        MTH_agujeros = MTH_agujeros_par{j};
    else
        MTH_agujeros = MTH_agujeros_impar{j};
    end
    MTH_agujeros(1,4) = MTH_agujeros(1,4)+h-d;
    T = T_base*MTH_agujeros;

    [vec,x,y,z] = partePosicion(T);
    coords_agujeros{i,j} = vec;
    x_agujeros(n,j) = x;
    y_agujeros(n,j) = y;
    z_agujeros(n,j) = z;
end

%% Coordenadas de los anclajes de los cables
T_base_anclajes = eye(4); T_base_anclajes(1,4) = d;
x_anclajes = zeros(1,ng);
y_anclajes = zeros(1,ng);
z_anclajes = zeros(1,ng);
for i = 1:ng
    Ti = T_base_anclajes*MTH_agujeros_par{i};
    [~, x_anclajes(i), y_anclajes(i), z_anclajes(i)] = partePosicion(Ti);
end


%% Definimos los cables. La primera columna: nivel/disco. Segunda: agujero
%ÍNDICE CERO (de acuerdo con la teoría, luego se actualiza)
cables = [1, 0;
          2, 4;
          2, 8;
          3, 6;
          4, 2;
          4, 10];

cables(:,2) = cables(:,2) + 1;      
      
%% Calculamos los cables
nCables = size(cables,1);
vec_longitudes = zeros(1,nCables);

%Cable 1: tipo 1
h = 50.4;
R = 13.5;
r = 29.5; %1
%r = 28;  %5
vec_longitudes(1) = calcularLongitud15(q(1), h, R, r); 

%Cable 2: tipo 2 + tipo 1
d = 14;
R = 13.5;
r = 28;  %5
h = 50.4;
vec_longitudes(2) = calcularLongitud2( -q(1), d, R, r, h );
vec_longitudes(2) = vec_longitudes(2) + calcularLongitud15(q(2), h, R, r);

%Cable 3: tipo 2 + tipo 1
vec_longitudes(3) = calcularLongitud2( -q(1), d, R, r, h );
vec_longitudes(3) = vec_longitudes(3) + calcularLongitud15(-q(2), h, R, r);

%Cable 4: tipo 3 + tipo 3 + tipo 1
p1 = [x_anclajes(5); y_anclajes(5); z_anclajes(5)]; %Debería ser 6, pero constructivo
p2 = [x_agujeros(1,6); y_agujeros(1,6); z_agujeros(1,6)];
p3 = [x_agujeros(2,6); y_agujeros(2,6); z_agujeros(2,6)];
vec_longitudes(4) = norm(p3-p2) + norm(p2-p1);
h = 50.4;
R = 13.5;
r = 29.5; %1
vec_longitudes(4) = vec_longitudes(4) + calcularLongitud15(q(3), h, R, r); 

%Cable 5: tipo 4 + tipo 3 + tipo 2 + tipo 5
d = 14;
R = 13.5;
h = 50.4;
b = 34.8;
c = 3.5;
vec_longitudes(5) = calcularLongitud4( q(1), h, R, d, b, c );
p1 = [x_agujeros(1,10); y_agujeros(1,10); z_agujeros(1,10)];
p2 = [x_agujeros(2,10); y_agujeros(2,10); z_agujeros(2,10)];
vec_longitudes(5) = vec_longitudes(5) + norm(p2-p1);
d = 14;
R = 13.5;
r = 28;  %5
h = 50.4;
vec_longitudes(5) = vec_longitudes(5) + calcularLongitud2( -q(3), d, R, r, h );
vec_longitudes(5) = vec_longitudes(5) + calcularLongitud15(q(4), h, R, r);

%Cable 6: tipo 4 + tipo 3 + tipo 2 + tipo 5
d = 14;
R = 13.5;
h = 50.4;
b = 34.8;
c = 3.5;
vec_longitudes(6) = calcularLongitud4( q(1), h, R, d, b, c );
p1 = [x_agujeros(1,2); y_agujeros(1,2); z_agujeros(1,2)];
p2 = [x_agujeros(2,2); y_agujeros(2,2); z_agujeros(2,2)];
vec_longitudes(6) = vec_longitudes(6) + norm(p2-p1);
d = 14;
R = 13.5;
r = 28;  %5
h = 50.4;
vec_longitudes(6) = vec_longitudes(6) + calcularLongitud2( -q(3), d, R, r, h );
vec_longitudes(6) = vec_longitudes(6) + calcularLongitud15(-q(4), h, R, r);
vec_temp = vec_longitudes(6);
vec_longitudes(6) = vec_longitudes(5);
vec_longitudes(5) = vec_temp;
end

