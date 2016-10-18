clc
clear
DIFF = 0.0010;

graphA = csvread('C:\Users\Gowtham Maddi\Desktop\GIST Internship\Social Network Data\facebook_201.csv');
graphB = csvread('C:\Users\Gowtham Maddi\Desktop\GIST Internship\Social Network Data\youtube_201.csv');
graphC = csvread('C:\Users\Gowtham Maddi\Desktop\GIST Internship\Social Network Data\flickr_201.csv');

disp('Topologies read');
graphA = graphA(1:200, 1:200);
graphB = graphB(1:200, 1:200);
graphC = graphC(1:200, 1:200);

eig_maxA = eigs(graphA,1); 
eig_maxB = eigs(graphB,1);
eig_maxC = eigs(graphC,1);

gamma = [eig_maxA eig_maxB eig_maxC];
beta1 = (0.001:0.1:15)*(gamma(1)/eig_maxA);
beta2 = 6;
beta3 = 2;

epsilon = [
           0, 2, 2;
           3, 0, 2;
           1, 2, 0;
          ];


[pss1, pss2, pss3] = steadystate(graphA, graphB, graphC, beta1, beta2, beta3, gamma, epsilon, DIFF);