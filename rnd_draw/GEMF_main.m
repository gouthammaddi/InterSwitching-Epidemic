% Faryad Darabi Sahneh
% Kansas State University
% Last Modified: Sep 2013
% Copyright (c) 2013, Faryad Darabi Sahneh. All rights reserved. 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted


clear; clc

% Initial Setup
 N=202;

%Network

graphA = csvread('C:\Users\Gowtham Maddi\Desktop\GIST Internship\Social Network Data\facebook_201.csv');
graphB = csvread('C:\Users\Gowtham Maddi\Desktop\GIST Internship\Social Network Data\youtube_201.csv');

Net1 = Web_Net('facebook');
Net2 = Web_Net('youtube');

Net=NetCmbn({Net1,Net2});


% Parameters and initial conditions
% Values to be changed for the parameters for various
% simulations:(Dr.Aresh) 

% [lambda1,v1]=EIG1(Net,1);
% [lambda2,v2]=EIG1(Net,2);

v1 = eigs(graphA, 1);
v2 = eigs(graphB, 1);

delta_1=v1; delta_2=v2;
beta_1=10; beta_2=6;
e_1=3.5; e_2=0.4;
Para=Para_SI1SI2S(delta_1,delta_2,beta_1,beta_2,e_1,e_2); M=Para{1};
StatesPlot=[1,2,3];
x0=Initial_Cond_Gen(N,'Population',[2,3],[5,5]);


%% Stochastic
% StopCond={'EventNumber',15000};
StopCond={'RunTime',20};
tic;
[ts,n_index,i_index,j_index]=GEMF_SIM(Para,Net,x0,StopCond);
toc;
% Post Processing
[T, StateCount]=Post_Population(x0,M,N,ts,i_index,j_index);
% plot(T,StateCount([2,3],:)/N)
figure

plot(T,StateCount(StatesPlot(2),:)/N,'r'); 
hold on
plot(T,StateCount(StatesPlot(3),:)/N,'b'); 

for lg=1:length(StatesPlot)
    legendsymb{lg}=int2str(StatesPlot(lg));
end;
legend('Infected by Virus1','Infected by Virus2','Alert Infected');

% ODE Solution
X0=zeros(M,N);
for i=1:N
    X0(x0(i),i)=1;
end;
tic;
[t,X]=GEMF_ODE(Para,Net,X0,T(end));
toc;
hold on;
% plot(t,sum(X(:,2:3:end),2)/N,'r')
% plot(t,sum(X(:,3:3:end),2)/N,'b')
for k=2:length(StatesPlot)
    plot(t,sum(X(:,StatesPlot(k):M:end),2)/N,'k','linewidth',2);
end;


