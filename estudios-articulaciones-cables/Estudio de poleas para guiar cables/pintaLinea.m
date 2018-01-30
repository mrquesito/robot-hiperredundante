function [  ] = pintaLinea( A, B, LineSpec )
%Pinta línea entre los puntos A y B
X = [A(1), B(1)];
Y = [A(2), B(2)];
plot(X,Y,LineSpec,'LineWidth',2);



end

