function dXdt = MassSpringVocal3(t,X)

% User defined constants
m = 170; % mass [kg]
k = 34; % spring constant [N/m]
beta = sqrt(k/m);% damping coefficient

a1 = 0.1;
a2 = 3;
y = 3;

%Extension
%P_l = 2000; % lung pressure [cmH2O]
%ro =  1.15; % density of air
%U = 6; % flow

%P = P_l-(1/2)*ro*(U/a1)^2; % driving pressure
S = 1500; % surface where pressure is exerted
P = 600;

% set of first-orders equations
dXdt1 = X(2);
dXdt2 = (-1/m)*((beta).*X(2) + (k).*X(1) - S*P*(1-y^2));
dXdt = [dXdt1 ; dXdt2];