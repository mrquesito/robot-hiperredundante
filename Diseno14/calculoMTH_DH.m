function [ T ] = calculoMTH_DH( theta, d, a, alpha )
Ct = cos(theta);
St = sin(theta);
Ca = cos(alpha);
Sa = sin(alpha);
T = [Ct, -Ca*St,  Sa*St, a*Ct;
     St,  Ca*Ct, -Sa*Ct, a*St;
      0,     Sa,     Ca,    d;
      0,      0,      0,    1];
end

