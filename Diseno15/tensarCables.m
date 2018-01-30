disable(s1,s2);
disp('Pon el robot en la posición de reposo, a mano');
pause
enable(s1,s2);
disp('Ahora, pulsa + para retraer el cable, - para soltarlo; para cada motor');

y = input('[Izquierda, 0]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,0,0,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,0,0,-0.5,0.5);
    end
    y = input('[Izquierda, 0]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end

y = input('[Izquierda, 1]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,0,1,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,0,1,-0.5,0.5);
    end
    y = input('[Izquierda, 1]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end

y = input('[Izquierda, 2]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,0,2,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,0,2,-0.5,0.5);
    end
    y = input('[Izquierda, 2]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end

y = input('[Izquierda, 3]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,0,3,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,0,3,-0.5,0.5);
    end
    y = input('[Izquierda, 3]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end


y = input('[Derecha, 0]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,1,0,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,1,0,-0.5,0.5);
    end
    y = input('[Derecha, 0]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end

y = input('[Derecha, 1]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,1,1,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,1,1,-0.5,0.5);
    end
    y = input('[Derecha, 1]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end

y = input('[Derecha, 2]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,1,2,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,1,2,-0.5,0.5);
    end
    y = input('[Derecha, 2]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end

y = input('[Derecha, 3]    + [retraer], - [soltar], x [siguiente motor]\n','s');
while(~strcmp(y,'x'))
    if(strcmp(y,'+'))
        moverCable(s1,s2,1,3,0.5,0.5);
    elseif(strcmp(y,'-'))
        moverCable(s1,s2,1,3,-0.5,0.5);
    end
    y = input('[Derecha, 3]    + [retraer], - [soltar], x [siguiente motor]\n','s');
end

q_actual = [0,0,0,0];

