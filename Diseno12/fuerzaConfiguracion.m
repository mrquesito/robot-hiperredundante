function [q_final] = fuerzaConfiguracion(s1,s2, q_actual, q_final, tiempo )
%Fuerza la configuración deseada partiendo de la actual, sin importar que
%puedan existir problemas de mínimos locales (longitudes no monótonas)

%De la estructura
h = 67.3; %mm
r = 30;   %mm
%Del tambor
R = 6;    %mm
m = 1200;   %pasos/vuelta
L = 2*pi*R; %Longitud bobina

%Calculamos variación de longitud
[ d0_actual, d1_actual ] = calcularLongitudesConfiguracion( q_actual );
[ d0_final, d1_final ] = calcularLongitudesConfiguracion( q_final );

d0_diff = d0_final - d0_actual;
d1_diff = d1_final - d1_actual;

str_0 = '';
str_1 = '';

for i = 1:4 %Motores
    %Motor lado izquierdo
    nPasos = d0_diff(i)*m/L;
    if(sign(d0_diff(i)) == -1)
        str_Signo = '1';
    else
        str_Signo = '0';
    end
    str_Pasos = num2str(abs(ceil(nPasos)));
    MOD = abs(ceil(1000*tiempo/nPasos));
    if(MOD == 1)
        disp('Ojo! MOD == 1');
    end
    if(isinf(MOD))
        MOD = 0;
    end
    str_MOD = num2str(MOD);
    str_0 = [str_0,str_Signo,',',str_Pasos,',',str_MOD,','];
    
    %Motor lado derecho
    nPasos = d1_diff(i)*m/L;
    if(sign(d1_diff(i)) == -1)
        str_Signo = '1';
    else
        str_Signo = '0';
    end
    str_Pasos = num2str(abs(ceil(nPasos)));
    MOD = abs(ceil(1000*tiempo/nPasos));
    if(MOD == 1)
        disp('Ojo! MOD == 1');
    end
    if(isinf(MOD))
        MOD = 0;
    end
    str_MOD = num2str(MOD);
    str_1 = [str_1,str_Signo,',',str_Pasos,',',str_MOD,','];
end

str_0 = [str_0,'1'];
str_1 = [str_1,'1'];
pause(0.05);
t = tic;
fprintf(s1,str_0);
fprintf(s2,str_1);
tElapsed = toc(t);
pause(tiempo-tElapsed);

end

