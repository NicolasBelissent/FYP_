
tspan = linspace(0,50,500);
h = tspan(2) - tspan(1);
n = 150;
%--------- INITIALISATION ---------
init = zeros(2*n+2,1);
init(1:2:2*n-1)=1; % initilisation of the pedestrian displacement
init(2:2:2*n) = 1.4; % initilisation of the pedestrian velocity
init(2*n+2) = 0; % initilisation of the bridge displacement
init(2*n+1) = 0; % initilisation of the bridge velocity

[t,x] = ode45(@coupled, tspan, init);

figure(1);

% -------- Displacement of the Bridge -------1--
%plot(t,x(:,2*n+1),'b-');
grid on

% -------- Limit Cycle Oscillation -------
u = x(:,2*n+1);
v = x(:,2*n+2);

plot(x(:,2*n+1),x(:,2*n+2),'b-');



function dxdt = coupled(t,x)
%%Constants

n = 150; % number of pedestrians on the bridge
a = 1;
p = 1; % equilibrium distance from com to cop [m]
L = 0.8; % leg length [m]
g = 9.8; % acceleration due to gravity [m/s^2]
h = 20; % damping coefficient [N/m]
k = 100; % spring elasticity [N/m]
M = 113000; % bridge mass [kg]
m = 70; % pedestrian mass [kg]
r = m / (M + (n * m)); % ratio - mass pedestrian to mass of bridge [null]
omega = 1.097; %sqrt(g/L); 
OMEGA = 1 ;%sqrt(k/(M + (n * m))); % natural frequency of bridge [Hz]
lambda = 0.23;
v = 0.01;

dxdt = zeros(2*n+2,1);
dxdt(1:2:2*n-1) = x(2:2:2*n) ;
sign2use = ones(n,1) ;
sign2use(x(1:2:2*n) > 0) = -1 
print(sign2use)

dxdt(2:2:2*n) = -omega.^2*(x(1:2:2*n-1) + sign2use.*p) - lambda .* ((x(2:2:2*n)).^2 - (v).^2 * (x(1:2:2*n-1)+sign2use.*p).^2   - a^2) + (v^2 * a^2)*x(2:2:2*n) - omega .* x(1:2:2*n-1);
% if x(1:2:2*(n-1)) > 0
%     print('true')
%     dxdt(2:2:2*n) = -omega.^2*(x(1:2:2*n-1) - p) - lambda .* ((x(2:2:2*n)).^2 - (v).^2 * (x(1:2:2*n-1)-p).^2   - a^2) + (v^2 * a^2)*x(2:2:2*n) - omega .* x(1:2:2*n-1);
% end
% if x(1:2:2*(n-1)) < 0
%     print('false')
%     dxdt(2:2:2*n) = -omega.^2*(x(1:2:2*n-1) + p) - lambda .* ((x(2:2:2*n)).^2 - (v).^2 * (x(1:2:2*n-1)+p).^2   - a^2) + (v^2 * a^2)*x(2:2:2*n) - omega .* x(1:2:2*n-1);
% end
dxdt(2*n+1) = x(2*n+2);
dxdt(2*n+2) = - ((OMEGA).^2) .* x(2*n+2) - 2*h*x(2*n+1) - r .* sum(subs(dxdt(2:2:2*n), t));
end
