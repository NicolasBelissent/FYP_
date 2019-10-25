
tspan = linspace(0,500,50000);
n = 10; % number of pedestrians on the bridge

%--------- INITIALISATION ---------
init = zeros(2*n+2,1);
init(1:2:2*n)=1; % initilisation of the pedestrian displacement
init(2:2:2*n) = 1.4; % initilisation of the pedestrian velocity
init(2*n+2) = 0; % initilisation of the bridge displacement
init(2*n+1) = 0; % initilisation of the bridge velocity

% ---------- Solve ODE -----------
[t,x] = ode45(@coupled, tspan, init);

%figure(1);

% -------- Displacement of the Bridge ---------
%plot(t,x(:,2*n+1),'r-');
f = fit(t(300:end),x(300:end,2*n+1),'fourier2');
A = coeffvalues(f);
A(6) = [];
amplitude = sqrt(sum(A.^2))
plot(f,t,x(:,2*n+1))
grid on

% -------- Limit Cycle Oscillation -------
u = x(:,2*n+1);
v = x(:,2*n+2);

%plot(x(:,2*n+1),x(:,2*n+2),'b-');

%{
------------- Function -------------
x - movement of the bridge
y - movement of the pedestrian
%}

 function dxdt = coupled(t,x)

 % ------------ Constants -----------
n = 10; % number of pedestrians on the bridge
mx = 113000;   % [kg] 
my = 70;   % [kg]
h = 0.05 ;
r = my / (mx + n * my);
omeg = 1.2 ;
a = 0.7;
omeg_i = 1.097; %
lambda = 0.23; % damping parameter

% ------------- Function ---------------


dxdt = zeros(2*n+2,1);
dxdt(1:2:2*n) = x(2:2:2*n) ;
dxdt(2:2:2*n) = -lambda.*( (x(2:2:2*n)).^2 + x(1:2:2*n) - a^2 ) .* x(2:2:2*n) - ((omeg_i)^2) .* x(1:2:2*n) - dxdt(2*n+2);
dxdt(2*n+1) = x(2*n+2);
dxdt(2*n+2) = - ((omeg).^2) .* x(2*n+1) - 2*h*x(2*n+2) - r*sum(dxdt(2:2:2*n));
end