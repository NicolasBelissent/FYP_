function dXdt = MassSpringVocal(t,X)

% User defined constants
m = 1.7; % mass [kg]
k = 34; % spring constant [N/m]
beta = sqrt(k/m);% damping coefficient


%Extension
P_l = 2000; % lung pressure [cmH2O]
ro =  1.15; % density of air
U = 6; % flow
a1 = 0.1; % cross sectional area (at the entrance of the glottis)

P = P_l-(1/2)*ro*(U/a1)^2 % driving pressure
S = 15; % surface where pressure is exerted


% set of first-orders equations
dXdt1 = X(2);
dXdt2 = (-1/m)*((beta).*X(2) + (k).*X(1)-P*S);
dXdt = [dXdt1 ; dXdt2];