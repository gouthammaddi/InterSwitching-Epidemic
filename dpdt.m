function [ functionValue ] = dpdt(node_list, graphA, graphB, graphC, beta, gamma, epsilon, p1_list, p2_list, p3_list, layer)

    %layer - either graphA or graphB or graphC
    functionValue = [];
    
    
    for node = node_list
        adjA = graphA(node, :);
        adjB = graphB(node, :);
        adjC = graphC(node, :);
        
        adj = [adjA; adjB; adjC];
        p = [p1_list(node), p2_list(node), p3_list(node)];
        
%         if(layer == 1)
%             functionValue = [functionValue, beta1*(1-p1-(1-(epsilon2/beta1))*p2)*(sum(adjA.*p1_list))-(delta1*p1)-epsilon1*p1*(sum(adjB.*p2_list))];
%         else
%             functionValue = [functionValue, beta2*(1-p2-(1-(epsilon1/beta2))*p1)*(sum(adjB.*p2_list))-(delta2*p2)-epsilon2*p2*(sum(adjA.*p1_list))];
%         end
        switch layer
            case 1
                firstSum = 0;
                for k = 1:3
                    firstSum = firstSum + ( (1-(epsilon(k,1)/beta(1))) * (1-(Delta(1,k))) * p(k) );
                end
                secondSum = 0;
                for k = 1:3
                    secondSum = secondSum + ( epsilon(1,k)*(1-Delta(1,k))*p(1)*sum(adj(k,:).*p(k)) );
                end
                functionValue = [functionValue, ( ( beta(1)*(1-p(1)-firstSum) )*sum(adjA.*p1_list) - ( gamma(1)*p(1) ) - secondSum)];
                
            case 2
                firstSum = 0;
                for k = 1:3
                    firstSum = firstSum + ( (1-(epsilon(k,2)/beta(2))) * (1-(Delta(2,k))) * p(k) );
                end
                secondSum = 0;
                for k = 1:3
                    secondSum = secondSum + ( epsilon(2,k)*(1-Delta(2,k))*p(2)*sum(adj(k,:).*p(k)) );
                end
                functionValue = [functionValue, ( ( beta(2)*(1-p(2)-firstSum) )*sum(adjB.*p2_list) - ( gamma(2)*p(2) ) - secondSum)];
                    
            case 3
                firstSum = 0;
                for k = 1:3
                    firstSum = firstSum + ( (1-(epsilon(k,3)/beta(3))) * (1-(Delta(3,k))) * p(k) );
                end
                secondSum = 0;
                for k = 1:3
                    secondSum = secondSum + ( epsilon(3,k)*(1-Delta(3,k))*p(3)*sum(adj(k,:).*p(k)) );
                end
                functionValue = [functionValue, ( ( beta(3)*(1-p(3)-firstSum) )*sum(adjC.*p3_list) - ( gamma(3)*p(3) ) - secondSum)];
                    
        end
    end
end

