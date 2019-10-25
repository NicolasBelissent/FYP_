% initial conditions
initialCond = [0.001 0]; 

% solve for 0 < t < 10
[t1,X1] = ode45(@MassSpringVocal1,[0,0.1],initialCond);

figure(1); 

plot(t1,X1(:,1),'r')
