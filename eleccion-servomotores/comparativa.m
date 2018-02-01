[num,txt,raw] = xlsread('tabla modelo peso par precio sin duplicados.xlsx');

modelos = txt;
pesos = num(:,3);
pares = num(:,4);
precios = num(:,5);

N = length(pesos);

%Plot par-peso

figure(1);
scatter(pares,pesos,[],precios,'filled');
labelpoints(pares,pesos,modelos,'N',0.05);
xlabel('Par [N*m]');
ylabel('Peso [g]');
colorbar
colormap(gray);