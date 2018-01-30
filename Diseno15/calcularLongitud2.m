function [ longitud ] = calcularLongitud2( theta, d, R, r, h )

    [ A, B, ~, D, ~, ~, ~, ~, ~, ~ ] = puntosPolea( theta, d, R, r, h );
    nTangente = norm(A-D);
    nNoTangente = norm(A-B);
    if nTangente < nNoTangente
        longitud = nTangente;
    else
        longitud = nNoTangente;
    end
    incCir = deg2rad(5);
    vec_Cir = 0:incCir:(pi-acos(d/r));
    N_Cir = length(vec_Cir);
    mat_puntos_deslizan = D;
    for j = 1:N_Cir
        a = vec_Cir(j)+theta;
        c = [cos(a), -sin(a); sin(a), cos(a)]*[0; -r]+[0;h];
        if (c(2) > D(2))
            mat_puntos_deslizan = [mat_puntos_deslizan, c];
        end
    end
    if size(mat_puntos_deslizan, 2) > 1
        for j = 2:size(mat_puntos_deslizan,2)
            incx = mat_puntos_deslizan(1,j)-mat_puntos_deslizan(1,j-1);
            incy = mat_puntos_deslizan(2,j)-mat_puntos_deslizan(2,j-1);
            longitud = longitud + norm([incx, incy]);
        end
    end

end

