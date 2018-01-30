N = 1000;
tic
q = zeros(1,4);
mat_datos = zeros(N,6);
theta_max = deg2rad(80);
theta_min = deg2rad(+80);
for i = 1:N
    q = q + 0.05*(rand(1,4)-0.5);
    %q = min(q,theta_max);
    %q = max(q,theta_min);
    l = calculaLongitudes(q);
    mat_datos(i,:) = l;
end
toc

figure(1); hold on;
plot(1:N,mat_datos(:,1));
plot(1:N,mat_datos(:,2));
plot(1:N,mat_datos(:,3));
plot(1:N,mat_datos(:,4));
plot(1:N,mat_datos(:,5));
plot(1:N,mat_datos(:,6));