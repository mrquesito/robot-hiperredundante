%Como se discute en las últimas líneas de la pág 143. 
%Debería ser planteado de otra forma: fijar 2 cables, y ver la solución
%para la que sale anclado. Pero como hemos demostrado que es controlable,
%me limitaré a muestrear en los 2gdl y calcular así las 3 longitudes, para 
%después pintarlas en el espacio 3D

%Uso las funciones para calcular las longitudes, siguiendo los dibujos de
%la pág. 142 para el módulo de la pág. 139.

theta_min = deg2rad(-70);
theta_max = deg2rad(70);
theta_inc = deg2rad(3);

vec_theta = theta_min:theta_inc:theta_max;
N = length(vec_theta);

vec_d1 = zeros(N,N);
vec_d2 = zeros(N,N);
vec_d3 = zeros(N,N);

for i = 1:N     %q1
    for j = 1:N
        vec_d1(i,j) = calcularLongitud15( vec_theta(i), 50.4, 13.5, 29.5);
        vec_d2(i,j) = calcularLongitud15( vec_theta(i), 50.4, 13.5, 28) + ...
                      calcularLongitud2( vec_theta(j), 14, 13.5, 28, 50.4);
        vec_d3(i,j) = calcularLongitud15( vec_theta(i), 50.4, 13.5, 28) + ...
                      calcularLongitud2( -vec_theta(j), 14, 13.5, 28, 50.4);
    end
end

close all;
figure(1);
scatter3(vec_d1(:), vec_d2(:), vec_d3(:));
xlabel('Longitud 1');
ylabel('Longitud 2');
zlabel('Longitud 3');

%Interesaría pintar los puntos con color que mida la suma de los tres
%cables, a ver 