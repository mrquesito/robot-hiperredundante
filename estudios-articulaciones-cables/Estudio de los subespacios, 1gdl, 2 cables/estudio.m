%Cálculo de la longitud de la cuerda en función del ángulo, para
%dimensionar los "estiradores" de sirga. Página 107.
R = 8;          %cm
h = 10;         %cm
thetaMin = -45; %º
thetaMax = 45;  %º
thetaStep = 1;  %º
%%
vector_theta = thetaMin:thetaStep:thetaMax;
N = length(vector_theta);
vector_A = zeros(1,N);
vector_B = zeros(1,N);
for i = 1:N
    theta = deg2rad(vector_theta(i));
    xA = R*(1-cos(theta));
    yA = h-R*sin(theta);
    xB = R*(1-cos(theta));
    yB = h+R*sin(theta);
    vector_A(i) = sqrt(xA*xA+yA*yA);
    vector_B(i) = sqrt(xB*xB+yB*yB);
end

close all;
figure(1);
subplot(1,2,1);
plot(vector_A,vector_B);
xlim([min(vector_A), max(vector_A)]);
ylim([min(vector_B), max(vector_B)]);
title('Semiplanos característicos y curva de soluciones');
xlabel('Longitud A [cm]');
ylabel('Longitud B [cm]');
subplot(1,2,2);
scatter3(vector_A, vector_B, vector_theta);
hold on;
for i = 1:N
    plot3([vector_A(i),vector_A(i)], [vector_B(i),vector_B(i)], [0, vector_theta(i)],'c');
end
title('Proyección del ángulo sobre la curva de soluciones');
xlabel('Longitud A [cm]');
ylabel('Longitud B [cm]');
zlabel('Ángulo girado [deg]');
suptitle('R = 8cm, h = 10cm');

figure(2);
plot(vector_A,vector_B); hold on;
plot(0.85*vector_A,0.85*vector_B);
plot(0.92*vector_A,0.92*vector_B);
xlim([min(vector_A), max(vector_A)]);
ylim([min(vector_B), max(vector_B)]);
[X,Y] = meshgrid(floor(min(vector_A)):ceil(max(vector_A)), floor(min(vector_B)):ceil(max(vector_B)));
title('Regiones y curvas características');
xlabel('Longitud A [cm]');
ylabel('Longitud B [cm]');

figure(3);
alpha = 0.9;
beta = 0.8;
scatter3(alpha*vector_A, alpha*vector_B, vector_theta, 'b'); %U
hold on;
scatter3(beta*vector_A, beta*vector_B, vector_theta, 'r');   %V
hold on;
surf(X,Y,zeros(size(X,2),size(Y,1)),'FaceAlpha',0.25,'EdgeColor','none');
for i = 1:N
    plot3([alpha*vector_A(i),alpha*vector_A(i)], [alpha*vector_B(i),alpha*vector_B(i)], [0, vector_theta(i)],'g');
    plot3([beta*vector_A(i),beta*vector_A(i)], [beta*vector_B(i),beta*vector_B(i)], [0, vector_theta(i)],'g');
    plot3([alpha*vector_A(i),beta*vector_A(i)], [alpha*vector_B(i),beta*vector_B(i)], [vector_theta(i), vector_theta(i)],'k');
end
xlim([min(beta*vector_A), max(vector_A)]);
ylim([min(beta*vector_B), max(vector_B)]);

title('Proyección del ángulo sobre la curva de soluciones');
xlabel('Longitud A [cm]');
ylabel('Longitud B [cm]');
zlabel('Ángulo girado [deg]');
suptitle('R = 8cm, h = 10cm');
