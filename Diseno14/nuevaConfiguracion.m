function [ q_final ] = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo )
%Interpolación entre q_actual y q_final, para evitar máximos locales
maxGrados = 5; %Tamaño máximo del paso

if(max(abs(q_actual-q_final)) > maxGrados)
    nEtapas = ceil(max(abs(q_actual-q_final))/maxGrados);   %Sin contar la inicial
    inc = (q_final-q_actual)./nEtapas;
    incT = tiempo/nEtapas;
    for i = 1:nEtapas-1
        q_next = q_actual + inc;
        q_actual = fuerzaConfiguracion(s1,s2, q_actual, q_next, incT );
    end
    q_final = fuerzaConfiguracion(s1,s2, q_actual, q_final, incT );
else
    q_final = fuerzaConfiguracion(s1,s2, q_actual, q_final, tiempo );
end

end

