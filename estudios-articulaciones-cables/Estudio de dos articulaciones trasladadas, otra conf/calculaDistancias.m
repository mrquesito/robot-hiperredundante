function [ dA, dB, dC ] = calculaDistancias(R, h, q1, q2 )
%Dibujo en pág 126

S60 = sin(deg2rad(60));
C60 = cos(deg2rad(60));

A0 = [-R, 0, 0, 1]';
B0 = [R*C60, -R*S60, 0, 1]';
C0 = [R*C60, R*S60, 0, 1]';

%F = trasz(h)*rotx(q2)*trasz(h)*roty(q1)*[0; 0; h; 1];
%F = [0; 0; h; 1];
% A1 = trasz(h)*rotx(q2)*roty(q1)*trasx(-R)*rotz(0)*[0;0;0;1];
% B1 = trasz(h)*rotx(q2)*roty(q1)*rotz(deg2rad(-60))*trasx(R)*[0;0;0;1];
% C1 = trasz(h)*rotx(q2)*roty(q1)*rotz(deg2rad(60))*trasx(R)*[0;0;0;1];

A1 = trasz(h)*roty(q1)*trasx(-R)*rotz(0)*[0;0;0;1];
B1 = trasz(h)*rotx(q2)*trasz(h)*roty(q1)*rotz(deg2rad(-60))*trasx(R)*[0;0;0;1];
C1 = trasz(h)*rotx(q2)*trasz(h)*roty(q1)*rotz(deg2rad(60))*trasx(R)*[0;0;0;1];

%Cálculo distancias
dA = sqrt(sum((A1-A0).^2));
dB = sqrt(sum((B1-B0).^2));
dC = sqrt(sum((C1-C0).^2));

end

