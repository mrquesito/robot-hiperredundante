%Para calcular las distancias entre el centro del módulo y los centros de
%los piñones
a1 = 23;    %mm de distancia entre ejes de sinfin y piñón
a2 = 25;

vector_d = 45:5:100;
vector_r = zeros(1,length(vector_d));

for i = 1:length(vector_d)
    d = vector_d(i);
    t = -(a1+a2);
    t = t + sqrt(2*d*d-(a1-a2)^2);
    t = t/2;
    vector_r(i) = t;
end
figure(1); plot(vector_d,vector_r,'*');