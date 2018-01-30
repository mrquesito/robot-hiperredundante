
enable(s1,s2)
disable(s1,s2)
q_actual = zeros(1,4)
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[10 0 0 0],1)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[10 5 0 0],2)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[10 10 15 0],2)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[10 10 18 10],2)
drawnow
q_actual = fuerzaConfiguracion(s1,s2,q_actual,[0 0 0 0],8)
drawnow
for i = 30:-2:0
    q_actual = fuerzaConfiguracion(s1,s2,q_actual,[i i i i],1.5)
    drawnow
end


