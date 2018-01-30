theta_min = deg2rad(-80);
theta_max = deg2rad(80);
inc_theta = deg2rad(5);
d = 14;
R = 13.5;
h = 50.4;
b = 34.8;
c = 3.5;

vec_theta = theta_min:inc_theta:theta_max;
N = length(vec_theta);
vec_longitudes = zeros(1,N);
close all;
figure(1);
for i = 1:N
    vec_longitudes(i)  = calcularLongitud4( vec_theta(i), h, R, d, b, c );
end

plot(vec_theta, vec_longitudes);