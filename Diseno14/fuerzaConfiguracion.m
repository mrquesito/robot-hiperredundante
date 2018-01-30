function [q_final] = fuerzaConfiguracion(s1,s2, q_actual, q_final, tiempo )
%Fuerza la configuración deseada partiendo de la actual, sin importar que
%puedan existir problemas de mínimos locales (longitudes no monótonas)

%Del tambor
R = 6;    %mm
m = 1200;   %pasos/vuelta
L = 2*pi*R; %Longitud bobina

%Calculamos variación de longitud
d_actual = calculaLongitudes( deg2rad(q_actual) );
d_final = calculaLongitudes( deg2rad(q_final) );

diff = d_final - d_actual;

nPasos = diff*m/L;

str_0 = '';
str_1 = '';

strings = cell(1,length(diff));
%Aquí obtenemos los strings de cada uno de los motores
for i = 1:6 
    if(sign(nPasos(i)) == -1)
        str_Signo = '1';
    else
        str_Signo = '0';
    end
    str_Pasos = num2str(abs(ceil(nPasos(i))));
    MOD = abs(ceil(1000*tiempo/nPasos(i)));
    if(MOD == 1)
        disp('Ojo! MOD == 1');
    end
    if(isinf(MOD))
        MOD = 0;
    end
    str_MOD = num2str(MOD);
    strings{i} = [str_Signo,',',str_Pasos,',',str_MOD,','];
end

%Y bueno, ahora hay que juntarlos. Para eso, hay que definir el orden.
%Visto desde detrás del robot (es decir, el robot está al final):
%Nivel 1: [derecha, 0] -> 1
%Nivel 2, izquierda: [izquierda, 0] -> 2
%Nivel 2, derecha: [derecha, 1] -> 3
%Nivel 3: [izquierda, 2] -> 4
%Nivel 4, izquierda: [izquierda, 1] -> 5
%Nivel 4, derecha: [derecha, 2] -> 6
vector_0 = [2, 5, 4];
vector_1 = [1, 3, 6];
for i = 1:3
    str_0 = [str_0, strings{vector_0(i)}];
    str_1 = [str_1, strings{vector_1(i)}];    
end
str_0 = [str_0,'0,0,0,1'];
str_1 = [str_1,'0,0,0,1'];
pause(0.05);
t = tic;
fprintf(s1,str_0);
fprintf(s2,str_1);
tElapsed = toc(t);
pause(tiempo-tElapsed);

end

