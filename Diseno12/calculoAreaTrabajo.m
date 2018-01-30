limSup = 45;
limInf = -45;

N = 100000;
qVec = (limSup-limInf).*rand(N,4) + limInf;
coords = zeros(2,N);
for i = 1:N
    [ posArt, ~] = calcularPosicion( qVec(i,:) );
    coords(1,i) = posArt(1,4); %x
    coords(2,i) = posArt(2,4);%
end

scatter(coords(1,:),coords(2,:),'*');

%Matriz de densidad
res = 10;    %mm

xMin = floor(min(coords(1,:)));
xMax = ceil(max(coords(1,:)));
yMin = floor(min(coords(2,:)));
yMax = ceil(max(coords(2,:)));

xMin = floor(xMin/res)*res;
yMin = floor(yMin/res)*res;
xMax = floor(xMax/res)*res;
yMax = floor(yMax/res)*res;


xVec = xMin:res:xMax;
yVec = yMin:res:yMax;

[X,Y] = meshgrid(xVec,yVec);

Nx = length(xVec);
Ny = length(yVec);

matrizCoincidencias = zeros(Ny,Nx);

for i = 1:N
    x = coords(1,i); %x
    y = coords(2,i);%y
    %Lo bajamos a la resolución de la cuadrícula
    x = floor(x/res)*res;
    y = floor(y/res)*res;
    ix = find(xVec==x);
    iy = find(yVec==y);
    matrizCoincidencias(iy,ix) = matrizCoincidencias(iy,ix) + 1;
end

figure(2);
[Xgrid, Ygrid] = meshgrid(xVec, yVec);
surf(Xgrid, Ygrid,1-matrizCoincidencias, 'EdgeColor', 'none', 'FaceColor', 'interp');
colormap gray
xlim([min(xVec) max(xVec)]);
ylim([min(yVec) max(yVec)]);
axis tight
title('Espacio de trabajo del robot plano. Origen en q_{1}');
xlabel('X [cm]');
ylabel('Y [cm]');


figure(3);
matrizPosiblesXY = flipud(matrizCoincidencias >= 1);

imshow(matrizPosiblesXY);
