function [ q_final ] = irPosicion(s1, s2, xf, yf, q_inicial, tiempo )
%xf, yf: en mm
 q_final = resolverCI( xf, yf, q_inicial);
 q_final = nuevaConfiguracion( s1,s2, q_inicial, q_final, tiempo );
end

