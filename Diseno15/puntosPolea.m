function [ A, B, C, D, E, F, G, O, X, Y ] = puntosPolea( theta, d, R, r, h )
rot = [cos(theta), -sin(theta); sin(theta), cos(theta)];
O = [0;0];
C = [0;h];
A = [R;0];
B = rot*[R;d] + C;
E = rot*[0;d] + C;
F = rot*[0;r] + C;
G = rot*[0;-r] + C;
beta = asin(sqrt(1-r*r/(R*R+h*h)));
gamma = atan(R/h);
D = [r*sin(gamma+beta); -r*cos(gamma+beta)+h];

X = [A, B, C, D, E, F, G, O];
Y = X(2,:);
X = X(1,:);

end

