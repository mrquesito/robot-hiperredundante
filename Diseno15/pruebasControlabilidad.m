%% Ejecutar una vez
s1 = serial('COM5');    %El izquierdo
s2 = serial('COM6');    %El derecho
set(s1,'BaudRate',19200);
set(s2,'BaudRate',19200);
fopen(s1)
fopen(s2)
set(s1,'Timeout',0.1);        %Timeout para serial: 1s
set(s2,'Timeout',0.1);        %Timeout para serial: 1s

%% Encendido y apagado
disable(s1,s2);
enable(s1,s2);

%% Tensar cables
tensarCables
enable(s1,s2)
disable(s1,s2)
q_actual = zeros(1,4)
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[10 0 0 0],0.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[-10 0 0 0],1.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 0],0.5)
drawnow

q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 10 0 0],0.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 -10 0 0],1.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 0],0.5)
drawnow

q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 10 0],0.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 -10 0],1.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 0],0.5)
drawnow

q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 5],0.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 -5],1.5)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 0],0.5)
drawnow


q_actual = fuerzaConfiguracion(s1,s2,q_actual,[10 10 15 0],2)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[10 10 18 10],2)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 0],2)
drawnow
for i = 0:5:40
    q_actual = fuerzaConfiguracion(s1,s2,q_actual,[i 0 0 i],0.8)
    drawnow
end
for i = 38:-5:-38
    q_actual = fuerzaConfiguracion(s1,s2,q_actual,[i 0 0 i],0.8)
    drawnow
end

%Tensar primer módulo
fprintf(s1,'1,10,2,0,0,0,1,10,2,0,0,0,1');
fprintf(s2,'0,0,0,1,10,2,0,0,0,0,0,0,1');

%Tensar segundo módulo
fprintf(s1,'0,0,0,1,10,2,0,0,0,0,0,0,1');
fprintf(s2,'1,10,2,0,0,0,1,10,2,0,0,0,1');
