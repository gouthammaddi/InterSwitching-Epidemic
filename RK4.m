function [p1, p2, p3] = RK4(graphA, graphB, graphC, beta, gamma, epsilon, p1_initial, p2_initial, p3_initial, DIFF)
    
    node_list = 1:length(graphA);
    N = length(graphA);
    
    iter = 0;
    time = 0;
    while(time < 30)
        
        k1 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial, p2_initial, p3_initial, 1)*DIFF;
        l1 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial, p2_initial, p3_initial, 2)*DIFF;
        m1 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial, p2_initial, p3_initial, 3)*DIFF;
        
        k2 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+(k1/2), p2_initial+(l1/2), p3_initial+(m1/2), 1)*DIFF;
        l2 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+(k1/2), p2_initial+(l1/2), p3_initial+(m1/2), 2)*DIFF;
        m2 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+(k1/2), p2_initial+(l1/2), p3_initial+(m1/2), 3)*DIFF;

        k3 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+(k2/2), p2_initial+(l2/2), p3_initial+(m2/2), 1)*DIFF;
        l3 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+(k2/2), p2_initial+(l2/2), p3_initial+(m2/2), 2)*DIFF;
        m3 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+(k2/2), p2_initial+(l2/2), p3_initial+(m2/2), 3)*DIFF;

        k4 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+k3, p2_initial+l3, p3_initial+m3, 1)*DIFF;
        l4 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+k3, p2_initial+l3, p3_initial+m3, 2)*DIFF;
        m4 = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_initial+k3, p2_initial+l3, p3_initial+m3, 3)*DIFF;
  
    
%         norm(Xn-X)+norm(Yn-Y)+norm(Zn-Z)<=eb*(norm(X)+norm(Y)+norm(Z))/N
%         if( norm((k1+2*k2+2*k3+k4)/6) + norm((l1+2*l2+2*l3+l4)/6 + norm((m1+2*m2+2*m3+m4)/6)) <= 0.001*(norm(p1_initial)+norm(p2_initial)+norm(p3_initial))/N )
%                 break;
%         else
            p1_initial = p1_initial + (k1+2*k2+2*k3+k4)/6;
            p2_initial = p2_initial + (l1+2*l2+2*l3+l4)/6;
            p3_initial = p3_initial + (m1+2*m2+2*m3+m4)/6;
%         end
        
%         iter = iter + 1;
        time = time + DIFF;
%         disp(['iteration', num2str(iter)]);
    end

    p1 = p1_initial;
    p2 = p2_initial;
    p3 = p3_initial;
    
    csvwrite('C:\Users\Gowtham Maddi\Desktop\optimization\steady_state.csv', [p1', p2', p3']);
    
    disp('finished');
end

