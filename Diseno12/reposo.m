function [ q_final ] = reposo( s1, s2, q_actual, tiempo)
q_final = zeros(1,4);
nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );


end

