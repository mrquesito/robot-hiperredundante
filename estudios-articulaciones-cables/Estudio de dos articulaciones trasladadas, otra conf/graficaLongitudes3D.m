%La imagen es la de la página 126
%Damos valores genéricos para la estructura
R = 5;
h = 5;
q1_min = deg2rad(-80);
q1_max = deg2rad(80);
%%
q2_min = deg2rad(-80);
q2_max = deg2rad(80);

inc = (q1_max-q1_min)/50;  %Tamaño de la celda

vec_q1 = q1_min:inc:q1_max;
vec_q2 = q2_min:inc:q2_max;

n1 = length(vec_q1); %Longitud de matriz en x/q1
n2= length(vec_q2); %Longitud de matriz en y/q2

mat_a = zeros(n1,n2);
mat_b = zeros(n1,n2);
mat_c = zeros(n1,n2);

N = 400;    %Número de puntos muestreados por coordenada
sigma = inc/10;    %Desviación típica de la muestra
matrizBondad = zeros(n1,n2);

for i = 1:n1
    q1 = vec_q1(i);
    for j = 1:n2
        q2 = vec_q2(j);
        resultadosBuenos = 0;   %Para contabilizar más adelante
        
        [dA, dB, dC] = calculaDistancias(R,h,q1,q2);    %Calculamos distancias
                                                        %En ese punto q1,q2
        vec_q1_ = q1+sigma*randn(1,N);  %Vector de qs en torno a q1
        vec_q2_ = q2+sigma*randn(1,N);  %Vector de qs en torno a q2
        vec_q1_ = max(vec_q1_, q1_min); %Contenemos las coordenadas dentro
        vec_q2_ = max(vec_q2_, q2_min); %del rango articular
        vec_q1_ = min(vec_q1_, q1_max);
        vec_q2_ = min(vec_q2_, q2_max);
        for k = 1:N
            [dA_, dB_, dC_] = calculaDistancias(R,h,vec_q1_(k), vec_q2_(k));
            %Criterio de bloqueo
            cablesMasLargos = 0;
            if dA_>dA
                cablesMasLargos = cablesMasLargos + 1;
            end
            if dB_>dB
                cablesMasLargos = cablesMasLargos + 1;
            end
            if dC_>dC
                cablesMasLargos = cablesMasLargos + 1;
            end
            if(cablesMasLargos >= 1)    %Con que haya un cable 
                                        %que deba ser más largo, no es una 
                                        %conf. alcanzable
                resultadosBuenos = resultadosBuenos + 1;
            end
            %matriz_longitudes_muestreo(:,i) = [dA_, dB_, dC_]';
        end
        %Ahora que tenemos calculadas las N longitudes, vemos cuántas son
        %válidas
        matrizBondad(i,j) = resultadosBuenos/N;
    end
end

matrizEstabilidad = matrizBondad;
matrizEstabilidad(matrizEstabilidad<=0.98)=0;

for i = 1:n1
    q1 = vec_q1(i);
    for j = 1:n2
        q2 = vec_q2(j);
        [dA, dB, dC] = calculaDistancias(R,h,q1,q2);    %Calculamos distancias
        mat_a(i,j) = dA;
        mat_b(i,j) = dB;
        mat_c(i,j) = dC;
    end
end

v_a = mat_a(:);
v_b = mat_b(:);
v_c = mat_c(:);

v_a = v_a(matrizEstabilidad == 1);
v_b = v_b(matrizEstabilidad == 1);
v_c = v_c(matrizEstabilidad == 1);

close all;
figure(1);
scatter3(v_a, v_b, v_c);
%colormap gray
%shading interp
title('Superficie S');
xlabel('l_{A}, cm');
ylabel('l_{B}, cm');
zlabel('l_{C}, cm');
