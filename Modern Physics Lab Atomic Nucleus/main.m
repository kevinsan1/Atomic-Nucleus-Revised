%% Clear all
% clear variables
clear all
clc
%% IMPORT DATA
% Import Alum and Plastic data
alum = importdata('alumData.mat');
plas = importdata('plasData.mat');
load cs137.mat
load calibcs137.mat
%% PLOT
% 
clf;
figure(1)
plot(calibCs137(:,2),'o')
axis([0,5000,0,1.2*max(calibCs137(:,2))])
%% FIND MAX
%
[val ind] = max(calibCs137(1500:end,2));
realMax = 1500 + ind;
m = 604/realMax;
%% PLOT ENERGIES
% Plot the same with channel numbers replaced by energies
plot(calibCs137(:,1)*m,calibCs137(:,2),'.');
axis([0,5000*m,0,1.2*max(calibCs137(:,2))]);