function [notch_filter] = myIdealNotchFilter(D,u0,v0,s)
notch_filter = ones(s);
for u = -(s(1)/2)+1:(s(1)/2)
	for v = -(s(2)/2)+1:(s(2)/2)
        u2 = u - u0;
        v2 = v - v0;
        if(u2*u2 + v2*v2 < D*D)
            notch_filter(u+(s(1)/2),v+(s(2)/2)) = 0.25;
        end;
	end
end
%log_notch_filter = log(abs(notch_filter)+1);
%imshow(log_notch_filter,[0 1]);
%colormap(jet);
%colorbar;
    
 
    
    
