%moverCable(s1,s2,0,1,10,2)
%moverCable(s1,s2,0,1,-10,1)

% enable(s1,s2);
%disable(s1,s2);

%moverArticulacion(s1,s2,0,0,10,2);
% moverArticulacion(s1,s2,0,10,-10,2);
% moverArticulacion(s1,s2,0,-10,10,2);
% moverArticulacion(s1,s2,0,10,-10,2);
% moverArticulacion(s1,s2,0,-10,10,2);
% moverArticulacion(s1,s2,0,10,-10,2);
% moverArticulacion(s1,s2,0,-10,10,2);
% moverArticulacion(s1,s2,0,10,-10,2);
% moverArticulacion(s1,s2,0,-10,10,2);
% q_actual = [0,0,0,0];
% q_actual = [10,0,0,0];
% q_final = [0,0,0,0];
% q_actual = fuerzaConfiguracion(s1,s2, q_actual, q_final, 2);
%     q_final = [10,10,10,10];
%     q_actual = fuerzaConfiguracion(s1,s2, q_actual, q_final, 2);
%     pause(0.2);
%     q_final = -[10,10,10,10];
%     q_actual = fuerzaConfiguracion(s1,s2, q_actual, q_final, 2);
%     
%     %%
%     tiempo = 1;
%     q_final = [10,0,0,0];
%     q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     drawnow
%     q_final = [10,10,0,0];
%     q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     drawnow
%     q_final = [10,10,10,0];
%     q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     drawnow
%     q_final = -[30,30,30,30];
%     q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     pause(2);
%     q_final = [30,30,30,30];
%     q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     
%     %%
%      tiempo = 2;
%     q_final = [10,0,0,0];
%     q_actual = fuerzaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     pause(2);
%     q_final = [10,10,0,0];
%     q_actual = fuerzaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     pause(2);
%     q_final = [10,10,10,0];
%     q_actual = fuerzaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     pause(2);
%     q_final = [10,10,10,10];
%     q_actual = fuerzaConfiguracion( s1,s2, q_actual, q_final, tiempo );
%     
tiempo=5;
%q_actual = zeros(1,4);
q_final = -[30,30,30,30];
q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );
tiempo = 10;
q_final = [30,-30,30,-30];
q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );
tiempo = 5;
q_final = zeros(1,4);
q_actual = nuevaConfiguracion( s1,s2, q_actual, q_final, tiempo );

for i = 1:5
    enable(s1,s2);
    pause(0.2);
    disable(s1,s2);
    pause(0.1);
end
    