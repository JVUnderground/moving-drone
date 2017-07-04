function [futurePos, futureVel] = move(currentPos, currentVel, acceleration, t)
    % r = r0 + v0t + at^2/2
    % v = v0 + at

    ro = currentPos;
    vo = currentVel;
    a = acceleration;

    futurePos = ro + vo*t + 0.5*a*t^2;
    futureVel = vo + a*t;
end