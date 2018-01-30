function [d_0_final, d_1_final] = moverArticulacion( s1,s2,articulacion, q_actual, q_final, tiempo)
%Todo de forma muy aproximada. Ángulo positivo al ser antihorario mirando
%desde el bloque de motores hacia el robot.
%De la estructura
h = 67.3; %mm
r = 30;   %mm
%Del tambor
R = 6;    %mm
m = 1200;   %pasos/vuelta
L = 2*pi*R; %Longitud bobina

%Cálculo de la variación de longitud
angulo_actual = deg2rad(q_actual);
angulo_final = deg2rad(q_final);
d_0_actual = norm([r*(1-cos(angulo_actual)),h-r*sin(angulo_actual)]);
d_1_actual = norm([r*(1-cos(-angulo_actual)),h-r*sin(-angulo_actual)]);
d_0_final = norm([r*(1-cos(angulo_final)),h-r*sin(angulo_final)]);
d_1_final = norm([r*(1-cos(-angulo_final)),h-r*sin(-angulo_final)]);

distancia_0 = d_0_final - d_0_actual;
distancia_1 = d_1_final - d_1_actual;

%Motor lado izquierdo
    nPasos = distancia_0*m/L;
    if(sign(distancia_0) == -1)
        str_Signo = '1';
    else
        str_Signo = '0';
    end
    str_Pasos = num2str(abs(ceil(nPasos)));
    MOD = abs(ceil(1000*tiempo/nPasos));
    str_MOD = num2str(MOD); 
    stringMotor_0 = [str_Signo,',',str_Pasos,',',str_MOD,','];
%Motor lado derecho
    nPasos = distancia_1*m/L;
    if(sign(distancia_1) == -1)
        str_Signo = '1';
    else
        str_Signo = '0';
    end
    str_Pasos = num2str(abs(ceil(nPasos)));
    MOD = abs(ceil(1000*tiempo/nPasos));
    str_MOD = num2str(MOD); 
    stringMotor_1 = [str_Signo,',',str_Pasos,',',str_MOD,','];
    
%Mover motores
    stringCeros = '0,0,0,';
    str_0 = '';
    str_1 = '';
    for i = 0:3
        if i == articulacion
            str_0 = [str_0,stringMotor_0];
            str_1 = [str_1,stringMotor_1];
        else
            str_0 = [str_0,stringCeros];
            str_1 = [str_1,stringCeros];
        end
    end
    str_0 = [str_0,'1'];
    str_1 = [str_1,'1'];
    pause(0.5);
    t = tic;
        fprintf(s1,str_0);
        fprintf(s2,str_1);
    tElapsed = toc(t);
    pause(tiempo-tElapsed);
end


