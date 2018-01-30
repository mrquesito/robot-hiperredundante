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
q_inicial = zeros(1,4);
%% Algunas posiciones de largo recorrido
q_inicial = irPosicion(s1,s2,-143.5,211,q_inicial,8);
q_inicial = irPosicion(s1,s2,202,144,q_inicial,8);
q_inicial = reposo(s1,s2,q_inicial,4);
