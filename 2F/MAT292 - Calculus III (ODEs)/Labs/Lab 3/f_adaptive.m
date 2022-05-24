% ADAPTIVE EULER'S METHOD

function [t, y] = f_adaptive(func,t0,tN,y0,h)
    tol = 1e-8;
    t = [t0];
    y = [y0];
    tn = t0;
    while tn < tN
        m_prev = func(t(end), y(end));
        
        %first case
        Y = y(end) + m_prev*h;
        
        %second case
        tz = t(end) + h/2;
        yz = y(end) + m_prev*(h/2);
        mz = func(tz, yz);
        Z = yz + mz*(h/2);
        
        %error handling
        D = Z - Y;
        if abs(D) < tol
            tn = tn + h;
            t = [t, tn];
            y = [y, Z-D];
        else
            h = 0.9*h*min(max(tol/abs(D),0.3),2);
        end
    end
    m_prev = func(t(end), y(end));
    h_last = h - (tn - tN);
    y_last = y(end) + m_prev*h_last;
    t = [t, tN];
    y = [y, y_last];
end