%% Ejecutar una vez
s1 = serial('COM5');    %El izquierdo
s2 = serial('COM6');    %El derecho
set(s1,'BaudRate',19200);
set(s2,'BaudRate',19200);
fopen(s1)
fopen(s2)
set(s1,'Timeout',0.1);        %Timeout para serial: 1s
set(s2,'Timeout',0.1);        %Timeout para serial: 1s

%%
fprintf(s1,'0,100,10,0,0,0,0,0,0,0,0,0,1');
fprintf(s2,'0,10,10,0,0,0,0,0,0,0,0,0,1');

enable(s1,s2);
disable(s1,s2);
moverCable(s1,s2,0,1,10,2)