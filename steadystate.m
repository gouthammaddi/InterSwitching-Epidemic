function [pss1, pss2, pss3] = steadystate(graphA, graphB, graphC, beta1, beta2, beta3, gamma, epsilon, DIFF)
    betaTWO = beta2;
    betaTHREE = beta3;
    pss1 = [];
    pss2 = [];
    pss3 = [];
    
    NUMBEROFNODES = length(graphA);
    
    p1_initial = 0.01*ones(1, NUMBEROFNODES);
    p2_initial = 0.01*ones(1, NUMBEROFNODES);
    p3_initial = 0.01*ones(1, NUMBEROFNODES);
    
    for betaONE = beta1
        [p1, p2, p3] = RK4(graphA, graphB, graphC, [betaONE, betaTWO, betaTHREE], gamma, epsilon, p1_initial, p2_initial, p3_initial, DIFF);
        pss1 = [pss1, mean(p1)];
        pss2 = [pss2, mean(p2)];
        pss3 = [pss3, mean(p3)];
        [(betaONE/gamma(1))*eigs(graphA,1), pss1(end), pss2(end), pss3(end)]
%         [betaONE, pss1(end), pss2(end), pss3(end)]
%           [betaTWO, pss1(end), pss2(end), pss3(end)]
    end
end

