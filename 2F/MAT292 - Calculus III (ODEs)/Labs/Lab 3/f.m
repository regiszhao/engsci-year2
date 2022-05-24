% IMPROVED EULER'S METHOD

function [t, y] = f(func,t0,tN,y0,h)
    t = t0:h:tN;
    y = NaN(1, length(t));
    y(1) = y0;
    for i = 2:length(t)
        m_prev = func(t(i-1), y(i-1));
        sol_cur = y(i-1) + m_prev*h;
        m_cur = func(t(i), sol_cur);
        S = (m_prev + m_cur) / 2;
        y(i) = y(i-1) + S*h;
    end
end