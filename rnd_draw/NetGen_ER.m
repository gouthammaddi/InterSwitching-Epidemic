function Net=NetGen_ER(N,p)

% Generates Erdos Reyni network
% Faryad Darabi Sahneh
% Kansas State University
% Last Modified: Sep 2013
% Copyright (c) 2013, Faryad Darabi Sahneh. All rights reserved. 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted

l=0; L1=[]; L2=[];
for i=1:N
    for j=i+1:N
         if rand<=p
            l=l+1;
            L1(l)=i; L2(l)=j;
        end;
    end;
end;

[ NeighVec , I1 , I2 , d ] = NeighborhoodData ( N , L1 , L2 ); I1=I1'; I2=I2';
Neigh{1}=NeighVec;

adj=cell(1);
adj{1}=sparse(L1,L2,1,N,N); adj{1}=adj{1} + adj{1}';

Net={Neigh,I1,I2,d,adj};

end