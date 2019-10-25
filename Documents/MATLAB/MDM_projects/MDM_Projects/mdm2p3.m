tspan = linspace(0,100,250);
n = 100; % number of pedestrians on the bridge

%--------- INITIALISATION ---------
init = zeros(2*n+2,1);
init(1:2:2*n-1)=1; % initilisation of the pedestrian displacement
init(2:2:2*n) = 1.4; % initilisation of the pedestrian velocity
init(2*n+2) = 0; % initilisation of the bridge displacement
init(2*n+1) = 0; % initilisation of the bridge velocity

% ---------- Solve ODE -----------
[t,x] = ode45(@coupled, tspan, init);

figure(1);

plot(t,x(:,2*n+1),'b-');
grid on

%{
------------- Function -------------
x - movement of the bridge
y - movement of the pedestrian
%}

 function dxdt = coupled(t,x)

 % ------------ Constants -----------
n = 100; % number of pedestrians on the bridge
mx = 113000;   % [kg]
my = n * 70;   % [kg]
kx = 10^6;  % [N/m]
ky = 284;  % [N/m]
cx = 10^4;   % [Ns/m]
cy = 10;   % [Ns/m]
h = 0.05 ;%(-cx/mx) / (2 * (mx + n * my));
r = my / (mx + n * my);
omeg = 1 ;%sqrt((-kx/mx) / (mx +n*my));
a = 1;
v = 0.01;
g = 9.8; 
L = 1; %[m]
omeg_i = 1.097; %(1/v)*(sqrt(g/L));
lambda = 0.23; % damping parameter

% ------------- Function ---------------
dxdt = zeros(2*n+2,1);
dxdt(1:2:2*n-1) = x(2:2:2*n) ;
dxdt(2:2:2*n) = -lambda .* ((x(2:2:2*n)).^2 + x(1:2:2*n-1) - a^2) .* x(2:2:2*n) - omeg_i .* x(1:2:2*n-1) - dxdt(2*n+2);
dxdt(2*n+1) = x(2*n+2);
dxdt(2*n+2) = - ((omeg).^2) .* x(2*n+2) - 2*h*x(2*n+1) - r .* sum(subs(dxdt(2:2:2*n), t));

end