function [ dA, dB, dC ] = calculaDistancias(R, h, q1, q2 )
%CALCULADISTANCIAS Summary of this function goes here
%   Detailed explanation goes here

%Dibujo en pág 119
%clear all;
%syms R q1 q2 h alpha beta gamma x real
%syms Roty Rotx Trasz

S60 = sin(deg2rad(60));
C60 = cos(deg2rad(60));

A0 = [-R, 0, 0, 1]';
B0 = [R*C60, -R*S60, 0, 1]';
C0 = [R*C60, R*S60, 0, 1]';

% F = trasz(h)*rotx(q2)*trasz(h)*roty(q1)*[0; 0; h; 1];
% A1 = trasx(-R)*rotz(0)*F;
% B1 = rotz(deg2rad(-60))*trasx(R)*F;
% C1 = rotz(deg2rad(60))*trasx(R)*F;

% A1 = trasz(h)*rotx(q2)*trasz(h)*roty(q1)*trasz(h)*A0;
% B1 = trasz(h)*rotx(q2)*trasz(h)*roty(q1)*trasz(h)*B0;
% C1 = trasz(h)*rotx(q2)*trasz(h)*roty(q1)*trasz(h)*C0;

A1 = rotx(q2)*trasz(h)*roty(q1)*trasz(h)*trasx(-R)*rotz(0)*[0;0;0;1];
B1 = rotx(q2)*trasz(h)*roty(q1)*trasz(h)*rotz(deg2rad(-60))*trasx(R)*[0;0;0;1];
C1 = rotx(q2)*trasz(h)*roty(q1)*trasz(h)*trasx(R)*[0;0;0;1];

% A1 = trasz(h)*rotx(q2)*roty(q1)*trasx(-R)*rotz(0)*[0;0;0;1];
% B1 = trasz(h)*rotx(q2)*roty(q1)*rotz(deg2rad(-60))*trasx(R)*[0;0;0;1];
% C1 = trasz(h)*rotx(q2)*roty(q1)*rotz(deg2rad(60))*trasx(R)*[0;0;0;1];

%Cálculo distancias
dA = sqrt(sum((A1-A0).^2));
dB = sqrt(sum((B1-B0).^2));
dC = sqrt(sum((C1-C0).^2));

end

