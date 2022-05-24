% IMPROVED EULER'S METHOD FOR SYSTEM OF 2 EQUATIONS

function [t, x] = solvesystem_zhaoregi(f1,f2,t0,tN,x0,h)
    t = t0:h:tN;
    x = NaN(2, length(t));
    x(:,1) = x0;
    for i = 2:length(t)
        m_prev = [f1(t(i-1), x(1,i-1), x(2,i-1)) f2(t(i-1), x(1,i-1), x(2,i-1))]';
        sol_cur = x(:,i-1) + m_prev.*h;
        m_cur = [f1(t(i), sol_cur(1), sol_cur(2)) f2(t(i), sol_cur(1), sol_cur(2))]';
        S = (m_prev + m_cur) ./ 2;
        x(:,i) = x(:,i-1) + S.*h;
    end
end