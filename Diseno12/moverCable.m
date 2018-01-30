function [] = moverCable(s1,s2,lado, motor, distancia, tiempo)
    %lado: 0(izquierda)/1(derecha)
    %motor: 0,1,2,3 (empieza a contar desde abajo)
    R = 6;      %mm
    m = 1200;   %pasos/vuelta
    L = 2*pi*R; %Longitud bobina
    
    nPasos = distancia*m/L;
    
    if(sign(distancia) == -1)
        str_Signo = '1';
    else
        str_Signo = '0';
    end
    
    str_Pasos = num2str(abs(ceil(nPasos)));
    
    MOD = abs(ceil(1000*tiempo/nPasos));
    str_MOD = num2str(MOD);
    
    stringMotor = [str_Signo,',',str_Pasos,',',str_MOD,','];
    stringCeros = '0,0,0,';
    str = '';
    for i = 0:3
        if i == motor
            str = [str,stringMotor];
        else
            str = [str,stringCeros];
        end
    end
    str = [str,'1'];
    
    if lado == 0
        fprintf(s1,str);
    else
        fprintf(s2,str);
    end
end
