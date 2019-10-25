function [dXdt] = MassSpringVocalALL(t,X)
%{
--------------------------------------------------------------------------
USAGE
--------------------------------------------------------------------------
To run this program we decided to use ode45, a built-in MATLAB ODE solver.
The sample run code commented below, can be copied and run on a seperate 
m-file.

    %set the initial conditions
    initialCond = [0.001 0]; 

    [t,X] = ode45(@MassSpringVocalALL,[0,0.1],initialCond);

    plot(t,X(:,1),'r-');
    figure(1);
    grid on


--------------------------------------------------------------------------
 USER DEFINED CONSTANTS
--------------------------------------------------------------------------
%}
% Vocal Fold Properties:
m = 0.00017; % mass [kg]
k = 34; % spring constant [N/m]
r = 0.069; % damping coefficient
x01 = 0.0001; % rest position of the masses at the entrance
x02 = 0.0001; % rest position of the masses at the exit
T = 0.0015; % thickness of the vocal fold

% Glottis Properties
S = 0.0006; % surface where pressure is exerted
L = 0.014; % length of the glottis


% Air Flow Properties
c_f = 1; % wave velocity on the vocal surface
tau=T/c_f; % wave propagation time
y = 1.3; % constant of air flow seperation
P_L = 2000; % lung pressure


% Movement of the glottal areas
a1 = (2*L*(x01 + X(1))); % at the entrance
a2 = (2*L*(x02 + X(1) - tau.*X(2))); % at the exit

%{
--------------------------------------------------------------------------
SINGLE MASS MODEL OF THE VOCAL FOLDS
--------------------------------------------------------------------------
The single mass model considers a mass spring oscillator that acts upon a
driving force. This driving force has varied values for the 3 following
cases:
- case a : The entrance and exit of the folds are shut (assuming that if 
one is closed the other must be closed)
- case b : The entrance is open wider than the exit
- case c : The exit is open wider that the entrance
%}


% case a)
if a1 <= 0
    
dXdt1 = X(2);
dXdt2 = (-1/m)*((r).*X(2) + (k).*X(1)-P_L*S);
dXdt = [dXdt1 ; dXdt2];

elseif a2> 0
    
    % case c)
    dXdt1 = X(2);
    dXdt2 = (-1/m)*((r).*X(2) + (k).*X(1) - S*P_L*(1-y^2));
    dXdt = [dXdt1 ; dXdt2];    
    
    if a2 < y*a1
    
        % case b)
        dXdt1 = X(2);
        dXdt2 = (-1/m)*((r).*X(2) + (k).*X(1) - (S*P_L*(1-((a2^2)/(a1^2)))));
        dXdt = [dXdt1 ; dXdt2];
        
    end

% case a)
else
    
    dXdt1 = X(2);
    dXdt2 = (-1/m)*((r).*X(2) + (k).*X(1)-P_L*S);
    dXdt = [dXdt1 ; dXdt2];
    
end

