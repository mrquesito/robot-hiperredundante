%Dibujo en pág 119
%clear all;
syms R q1 q2 h alpha beta gamma x real
syms Roty Rotx Trasz

Rotx(alpha) = [1, 0, 0, 0; 
               0, cos(alpha), -sin(alpha), 0;
               0, sin(alpha), cos(alpha),0;
               0, 0, 0, 1];

Roty(beta) = [cos(beta), 0, sin(beta), 0;
              0, 1, 0, 0;
              -sin(beta), 0, cos(beta), 0;
              0, 0, 0, 1];
          
Rotz(gamma) = [cos(gamma), -sin(gamma), 0, 0;
               sin(gamma), cos(gamma), 0, 0;
               0, 0, 1, 0;
               0, 0, 0, 1];
Trasx(x) = [1, 0, 0, x; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];

Trasz(h) = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, h; 0, 0, 0, 1];

S60 = sin(deg2rad(60));
C60 = cos(deg2rad(60));

A0(R) = [-R, 0, 0, 1]';
B0(R) = [R*C60, -R*S60, 0, 1]';
C0(R) = [R*C60, S60, 0, 1]';

F(h, q1, q2) = Trasz(h)*Rotx(q2)*Trasz(h)*Roty(q1)*[0; 0; h; 1];
A1(h, R, q1, q2) = Trasx(R)*Rotz(0)*F;
B1(h, R, q1, q2) = Trasx(R)*Rotz(deg2rad(-60))*F;
C1(h, R, q1, q2) = Trasx(R)*Rotz(deg2rad(60))*F;


%Cálculo distancias
dA(h, R, q1, q2) = sqrt(sum((A1(h, R, q1, q2)-A0(R)).^2)-1);
dB(h, R, q1, q2) = sqrt(sum((B1(h, R, q1, q2)-B0(R)).^2)-1);
dC(h, R, q1, q2) = sqrt(sum((C1(h, R, q1, q2)-C0(R)).^2)-1);
disp('dA');
pretty(dA)
disp('dB');
pretty(dB)
disp('dC');
pretty(dC)
