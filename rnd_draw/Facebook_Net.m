function [Net] = Web_Net(media)

    if(strcmp(media, 'facebook'))
        graph = csvread('C:\Users\Gowtham Maddi\Desktop\GIST Internship\Social Network Data\facebook_201.csv');
    elseif (strcmp(media, 'twitter'))
        graph = csvread('C:\Users\Gowtham Maddi\Desktop\GIST Internship\Social Network Data\youtube_201.csv');
    end
        
    L1 = [];
    L2 = [];
    N = length(graph);
    for i = 1:N
        dummy2 = find(graph(i, :));
        dummy1 = zeros(1, length(dummy2)) + i;
        
        L1 = [L1, dummy1];
        L2 = [L2, dummy2];
    end
    
    [ NeighVec , I1 , I2 , d ] = NeighborhoodData ( N , L1 , L2 ); I1=I1'; I2=I2';
    Neigh{1}=NeighVec;

    adj=cell(1);
    adj{1}=sparse(L1,L2,1,N,N); adj{1}=adj{1}+adj{1}'; 

    Net={Neigh,I1,I2,d,adj};
end

