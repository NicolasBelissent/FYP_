
% Parametrisation
initialCond = [0.1 0]; 
a1=0;
a2=20;
y = 10;

% User defined constants
m = 1.7; % mass [kg]
k = 34; % spring constant [N/m]
beta = sqrt(k/m);% damping coefficient


%Extension
%P_l = 1350; % lung pressure [cmH2O]
%ro =  1.15; % density of air
%U = 600; % flow
 % cross sectional area (at the entrance of the glottis)

%P = P_l-(1/2)*ro*(U/a1)^2; % driving pressure
S = 0.000015; % surface where pressure is exerted
P = 600;

%a1_values = linspace(0,10,200);
%a2_values = linspace(0,10,200);

%{
for i = 1:length(a1)
    for j = 1:length(a2)
        
        a1 = a1_values(i);
        a2 = a2_values(j);
        
%}        
if a1 == 0
            
    options = odeset('Events', @(t,x) EventsCond1(t,S,P));
            
    % solves ODE returning a struct
    [t,X] = ode45(@MassSpringVocal,[0,10],initialCond,options);
    
    figure(1);
    
    plot(t,X,'-r')     
    
elseif 0 <= a2 <= y*a1 
        
    options = odeset('Events', @(t,x) EventsCond2(t,S,P,a1,a2));
           
    [t,X] = ode45(@MassSpringVocal,[0,10],initialCond,options);
            
    plot(t,X,'-m')
            
elseif 0 < y*a1 < a2
            
      options = odeset('Events', @(t,x) EventsCond3(t,S,P,y));
            
      % solves ODE returning a struct
      [t,X] = ode45(@MassSpringVocal,[0,5],initialCond,options);
            
      plot(t,X,'-blue')
            
else 
    
    msg = 'Error occurred.';
    error(msg)
    
end
            


     