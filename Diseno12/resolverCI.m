function [ q ] = resolverCI( xf, yf, q_inicial)
nArt = 4;
error = 100;
errorMax = 1;
limSup = deg2rad(30);
limInf = deg2rad(-30);

qTemp = deg2rad(q_inicial);
k = 0;
i = nArt;
while (error>errorMax) && (k < 100)
    [posArt,mth] = calcularPosicion(rad2deg(qTemp));
    x = posArt(1,nArt);
    y = posArt(2,nArt);
    delta_x = xf-x;
    delta_y = yf-y;
    
    T = eye(3);
    for j = 1:i-1
        T = T*mth(:,:,j);
    end
    xi1 = T(1,3);
    yi1 = T(2,3);
    
    xi1 = 0;
    yi1 = 0;
    if i > 1
        xi1 = posArt(1,i-1);
        yi1 = posArt(2,i-1);
    end
    
    T = T*mth(:,:,i);
    xi = T(1,3);
    yi = T(2,3);
    
    xi = posArt(1,i);
    yi = posArt(2,i);
    
    v1 = [xf-xi1, yf-yi1, 0];
    v2 = [x-xi1, y-yi1, 0];
    
    s = -sign(cross(v1,v2));
    beta = s(3)*atan2(norm(cross(v1,v2)),dot(v1,v2));
    qTemp(i) = beta;
    
    for n = 1:nArt
        qTemp(n) = min(qTemp(n),limSup);
        qTemp(n) = max(qTemp(n),limInf);
    end
    
    [posArt, mth] = calcularPosicion(rad2deg(qTemp));
    x = posArt(1,nArt);
    y = posArt(2,nArt);
    error = sqrt((x-xf)^2+(y-yf)^2);
    
    i = i - 1;
    if i == 0
        i = nArt;
    end
    
    k = k + 1;
    
    
end
q = rad2deg(qTemp);
end

