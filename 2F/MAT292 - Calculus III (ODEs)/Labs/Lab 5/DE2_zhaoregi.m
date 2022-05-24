function [t,y] = DE2_zhaoregi(f,t0,tN,y0,y1,h)
    % returns array of t values and corresponding solution y
    % f is a function where y'' = f(t,y,y')
    t = t0:h:tN;
    y = NaN(1, length(t));
    y(1) = y0;
    y(2) = y(1) + y1*h;
    for i = 3:length(t)
        yp = (y(i-1) - y(i-2)) / h;
        ypp = f(t(i-1), y(i-1), yp);
        y(i) = (ypp * h^2) + 2*y(i-1) - y(i-2);
    end
end

% function [t,y] = DE2_zhaoregi(f,t0,tN,y0,y1,h)
%     % returns array of t values and corresponding solution y
%     % f is a function where y'' = f(t,y,y')
%     t = t0:h:tN;
%     y = NaN(1, length(t));
%     yp = NaN(1, length(t));
%     y(1) = y0;
%     yp(1) = y1;
%     for i = 2:length(t)
%         ypp = f(t(i-1), y(i-1), yp(i-1));
%         y(i) = y(i-1) + h*yp(i-1);
%         yp(i) = yp(i-1) + h*ypp;
%     end
% end