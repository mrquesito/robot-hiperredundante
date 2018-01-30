theta_min = deg2rad(-80);
theta_max = deg2rad(80);
inc_theta = deg2rad(5);
d = 14;
R = 13.5;
r = 19.5;
h = 50.4;

vec_theta = theta_min:inc_theta:theta_max;
N = length(vec_theta);
vec_longitudes = zeros(1,N);
close all;
figure(1);
for i = 1:N
    cla;
    longitud = 0;
    %vec_longitudes(i) = longitudPolea(vec_theta(i), d, R, r, h);
    [ A, B, C, D, E, F, G, O, X, Y ] = puntosPolea( vec_theta(i), d, R, r, h );
    scatter(X, Y); hold on;
    plot([C(1),O(1),A(1)], [C(2),O(2),A(2)],'k');
    plot([E(1), B(1)], [E(2), B(2)],'k');
    plot([F(1), G(1)], [F(2), G(2)], 'k');
    nTangente = norm(A-D);
    nNoTangente = norm(A-B);
    if nTangente < nNoTangente
        plot([A(1), D(1)], [A(2), D(2)], 'r');
        longitud = nTangente;
    else
        plot([A(1), B(1)], [A(2), B(2)], 'r');
        longitud = nNoTangente;
    end
    incCir = deg2rad(5);
    vec_Cir = 0:incCir:(pi-acos(d/r));
    N_Cir = length(vec_Cir);
    mat_puntos_deslizan = D;
    for j = 1:N_Cir
        a = vec_Cir(j)+vec_theta(i);
        c = [cos(a), -sin(a); sin(a), cos(a)]*[0; -r]+[0;h];
        if (c(2) > D(2))
            scatter(c(1), c(2), 'r');
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
    vec_longitudes(i) = longitud;
    axis([-r*1.1 r*1.1 0 h+r*1.1]);
    axis equal
    axis 'auto y'
    pause(0.1);
end
figure(2);
plot(vec_theta,vec_longitudes);

figure(3);
for i = 1:N
    vec_longitudes(i) = calcularLongitud2(vec_theta(i),d, R, r, h );
end
plot(vec_theta,vec_longitudes);
