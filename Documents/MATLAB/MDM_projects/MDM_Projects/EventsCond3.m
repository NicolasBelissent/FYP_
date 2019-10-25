% Defines an events function

function [value,isterminal,direction] = EventsCond3(t,S,P,y)

value=S*P*(1-y^2);  
direction=0;    
isterminal=0;    

end

