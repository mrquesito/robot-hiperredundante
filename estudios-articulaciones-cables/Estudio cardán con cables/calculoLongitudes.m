syms alpha beta R h real
syms Rotx Roty Trasz A0 B0 C0 A1 B1 C1
Rotx(alpha) = [1, 0, 0, 0; 
               0, cos(alpha), -sin(alpha), 0;
               0, sin(alpha), cos(alpha),0;
               0, 0, 0, 1];

Roty(beta) = [cos(beta), 0, sin(beta), 0;
              0, 1, 0, 0;
              -sin(beta), 0, cos(beta), 0;
              0, 0, 0, 1];

Trasz(h) = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, h; 0, 0, 0, 1];

S60 = sin(deg2rad(60));
C60 = cos(deg2rad(60));

A0(R) = [0, -R, 0, 1]';
B0(R) = [S60*R; C60*R; 0; 1];
C0(R) = [-S60*R, C60*R, 0, 1]';

A1(alpha, beta, h, R) = Roty(beta)*Rotx(alpha)*Trasz(h)*A0(R);
B1(alpha, beta, h, R) = Roty(beta)*Rotx(alpha)*Trasz(h)*B0(R);
C1(alpha, beta, h, R) = Roty(beta)*Rotx(alpha)*Trasz(h)*C0(R);

%Cálculo distancias
dA(alpha, beta, h, R) = sqrt(sum((A1(alpha, beta, h, R)-A0(R)).^2)-1);
dB(alpha, beta, h, R) = sqrt(sum((B1(alpha, beta, h, R)-B0(R)).^2)-1);
dC(alpha, beta, h, R) = sqrt(sum((C1(alpha, beta, h, R)-C0(R)).^2)-1);

disp('dA');
pretty(simplify(dA))
disp('dB');
pretty(simplify(dB))
disp('dC');
pretty(simplify(dC))
