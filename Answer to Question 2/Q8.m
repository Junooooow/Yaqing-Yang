clear;clc;
% Q8.2
E(1)  = 1;
S(1)  = 10;
ES(1) = 0;
P(1)  = 0;
k1 = 100;
k2 = 600;
k3 = 150;
KM = (k2+k3)/k1;
h  = 1*1e-5; 

eq_ES = @(E,S,ES) k1*E*S-k2*ES-k3*ES;
eq_S  = @(ES,S)   -k1*S+k2*ES;
eq_E  = @(ES,S,E) -k1*E*S+k2*ES+k3*ES;
eq_P  = @(ES,P)   k3*ES;

T=20000;
for dt=1:1:T-1
    % ES
    K1 = eq_ES(E(dt)    ,S(dt)    ,ES(dt)       );
    K2 = eq_ES(E(dt)+h/2,S(dt)+h/2,ES(dt)+h*K1/2);
    K3 = eq_ES(E(dt)+h/2,S(dt)+h/2,ES(dt)+h*K2/2);
    K4 = eq_ES(E(dt)+h  ,S(dt)+h  ,ES(dt)+h*K3  );
    ES(dt+1) = ES(dt) + h*(K1 + 2*K2 + 2*K3 + K4) / 6;
    % S
    K1 = eq_S(ES(dt)    ,S(dt)       );
    K2 = eq_S(ES(dt)+h/2,S(dt)+h*K1/2);
    K3 = eq_S(ES(dt)+h/2,S(dt)+h*K2/2);
    K4 = eq_S(ES(dt)+h  ,S(dt)+h*K3  );
    S(dt+1) = S(dt) + h*(K1 + 2*K2 + 2*K3 + K4) / 6;
    % E
    K1 = eq_E(ES(dt)    ,S(dt)    ,E(dt)   );
    K2 = eq_E(ES(dt)+h/2,S(dt)+h/2,E(dt)+h*K1/2);
    K3 = eq_E(ES(dt)+h/2,S(dt)+h/2,E(dt)+h*K2/2);
    K4 = eq_E(ES(dt)+h  ,S(dt)+h  ,E(dt)+h*K3);
    E(dt+1) = E(dt) + h*(K1 + 2*K2 + 2*K3 + K4) / 6;
    % P
    K1 = eq_P(ES(dt)    ,P(dt)   );
    K2 = eq_P(ES(dt)+h/2,P(dt)+h*K1/2);
    K3 = eq_P(ES(dt)+h/2,P(dt)+h*K2/2);
    K4 = eq_P(ES(dt)+h  ,P(dt)+h*K3);
    P(dt+1) = P(dt) + h*(K1 + 2*K2 + 2*K3 + K4) / 6;
end
figure(1);
subplot(2,2,1);plot(1:T,ES);title('ES');
subplot(2,2,2);plot(1:T,E); title('E');
subplot(2,2,3);plot(1:T,S); title('S');
subplot(2,2,4);plot(1:T,P); title('P');

% Q8.3
i=1;
for dt=T-1:-i:1
    V(dt) = (P(dt+1)-P(dt))/i;
end
V(1:250)=[];
figure(2);
plot(S(1:T-251),V);


