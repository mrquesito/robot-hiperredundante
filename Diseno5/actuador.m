close all;
%Dimensiones barras (en mm)

a = 40;
b = 40;
s = 10;
l = 55;

g = sqrt(a*a+b*b);

%Preparamos simulación
rho_inicial = 30;
rho_final = 80;

N = 50;
vector_rho = linspace(rho_inicial,rho_final,N);
vector_alpha = zeros(1,N);

%Bucle

for i = 1:N
    rho = vector_rho(i);
    f = sqrt(rho*rho+s*s);
    gamma = pi/2-acos((l*l-f*f-g*g)/(-2*f*g))-atan(b/a);
    alpha = gamma+atan(s/rho);
    vector_alpha(i) = rad2deg(alpha);
end

%Plot

figure(1);
plot(vector_rho,vector_alpha);


%Puntos 
v_1x = zeros(1,N);
v_1y = zeros(1,N);

v_2x = b*ones(1,N);
v_2y = zeros(1,N);
v_3x = zeros(1,N);
v_3y = zeros(1,N);
v_5x = zeros(1,N);
v_5y = a*ones(1,N);

for i = 1:N
    rho = vector_rho(i);
    f = sqrt(rho*rho+s*s);
    gamma = pi/2-acos((l*l-f*f-g*g)/(-2*f*g))-atan(b/a);
    alpha = gamma+atan(s/rho);
    
    x4 = rho*cos(alpha);
    y4 = a-rho*sin(alpha);
    
    v_4x(i) = x4;
    v_4y(i) = y4;
    
    R = [cos(alpha),-sin(alpha);sin(alpha),cos(alpha)];
    x3 = rho;
    y3 = -s;
    v3 = R'*[x3;y3];
    v_3x(i) = v3(1);
    v_3y(i) = v3(2)+a;
    
    vector_alpha(i) = rad2deg(alpha);
    
end

%Plot
figure(2); hold on;
for i = 1:N
    vx = [v_1x(i),v_2x(i),v_3x(i),v_4x(i),v_5x(i),v_1x(i)];
    vy = [v_1y(i),v_2y(i),v_3y(i),v_4y(i),v_5y(i),v_1y(i)];
    plot(vx,vy);
    drawnow;
    %pause(0.1);
end
    