% Defines an events function

function [value,isterminal,direction] = EventsCond2(t,S,P,a1,a2)
% defines the plane
value= @MassSpringVocal - (S*P*(1-((a2^2)/(a1^2))));  
direction=0;    
isterminal=0;    

end

