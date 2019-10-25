function dXdt = MassSpringVocal1(t,X)

% User defined constants
m = 0.00017; % mass [kg]
k = 34; % spring constant [N/m]
r = 0.069;% damping coefficient
L = 0.014;
x01 = 0.0001;
x02 = 0.0001;
T = 0.006;
c_f = 992;
tau=T/c_f;
y = 1.3;
S = 0.0006;% surface where pressure is exerted
P = 2000;


a1 = (2*L*(x01 + X(1)));

%Extension
P_l = 2000; % lung pressure [cmH2O]
ro =  1.15; % density of air
U = 6; % flow
%P = P_l-(1/2)*ro*(U/a1)^2; % driving pressure


% set of first-orders equations
dXdt1 = X(2);
dXdt2 = (-1/m)*((r).*X(2) + (k).*X(1)-P*S);
dXdt = [dXdt1 ; dXdt2];