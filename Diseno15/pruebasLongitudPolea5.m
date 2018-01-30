theta_min = deg2rad(-80);
theta_max = deg2rad(80);
inc_theta = deg2rad(5);
d = 14;
h = 50.4;
r = 29.5; %1
%r = 28;  %5

vec_theta = theta_min:inc_theta:theta_max;
N = length(vec_theta);
vec_longitudes = zeros(1,N);
close all;
figure(1);
for i = 1:N
    vec_longitudes(i)  = calcularLongitud15( vec_theta(i), h, R, r );
end

plot(vec_theta, vec_longitudes);