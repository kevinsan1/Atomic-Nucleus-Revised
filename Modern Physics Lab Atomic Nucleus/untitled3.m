clear all;clc;close all;
myPath = ['/Users/kevin/SkyDrive/KTH Work/Period'...
    ' 3 2014/SH2008/Atomic Nucleus Revised/Modern'...
    ' Physics Lab Atomic Nucleus/'];
addpath(genpath(myPath));
cd(myPath);
%% Plastic data
density.plastic = 1.13; % g/cm^3
thick.plastic = 0.0001; % thickness in meters
% # of sheets, energy in (keV)
expData.Plastic = load('plasticData.mat');
y.plasOne=expData.Plastic.data(:,2)'; % Energy in keV
x.plasOne=expData.Plastic.data(:,1)'; % plate numbers
sigma.plasOne = expData.Plastic.data(:,3)';
[a_fit.plasOne, sig_a.plasOne, yy.plasOne, chisqr.plasOne] = ...
    linreg(x.plasOne,y.plasOne,sigma.plasOne);m.plastic=2;n.plastic =...
    length(x.plasOne);
% Print out the fit parameters, including their error bars.
fprintf('Fit parameters:\n');
for i=1:m.plastic
    fprintf(' a(%g) = %g +/- %g \n',i,a_fit.plasOne(i),sig_a.plasOne(i));
end
% Find Zero of y(x) Plastic
zero.xPlas = abs(a_fit.plasOne(1)/a_fit.plasOne(2)); % energy is zero when
% x is _. x is in units of # of sheets of plastic multiply
% (# of sheets)
% by sheet thickness to get total sheet thickness when it should
% stop the electrons
zero.thicknessPlas = zero.xPlas * thick.plastic;
% Define R(E) = kE^B
range.plasticmeters = zero.thicknessPlas - x.plasOne * thick.plastic; % in meters
range.plasticcentimeters = range.plasticmeters * 100; % in cm
range.plasticgcm2 = range.plasticcentimeters * density.plastic; % in g/cm^2
energy.plaskeV = y.plasOne; % in keV
energy.plasMeV = energy.plaskeV * 1e-3; % in MeV
y.plasTwo = log(range.plasticgcm2);
dx.plastic = sigma.plasOne./y.plasOne;
x.plasTwo = log(energy.plasMeV);
sigma.plasTwo = dx.plastic; % R.plasticgcm2*0.05./R.plasticgcm2;
%% Chi-Fit
[a_fit.plasTwo, sig_a.plasTwo, yy.plasTwo, chisqr.plasTwo] = ...
    linreg(x.plasTwo,y.plasTwo,sigma.plasTwo);
dc.plastic = sig_a.plasTwo(1);
B.plastic = a_fit.plasTwo(2);
c.plastic = a_fit.plasTwo(1);
dB.plastic = sig_a.plasTwo(2);
k.plastic = exp(c.plastic);
dy.plasRange = dc.plastic + B.plastic*dx.plastic...
    + x.plasTwo * dB.plastic;
%% Print out statistics
fprintf(' Plastic Fit parameters:\n');
fprintf(' c = %g +/- %g \n',c.plastic,dc.plastic);
fprintf(' m = %g +/- %g \n',B.plastic,dB.plastic);
fprintf('log10(k)=b and B=m \n');
fprintf(' R(E)=kE^B\n');
fprintf('R(E)=%g E^(%g)\n',k.plastic,B.plastic);
fprintf(' B = %g +/- %g \n',B.plastic,dB.plastic);
fprintf('\n')
fprintf('Final Fit Parameters\n')
fprintf('Plastic:\n');
fprintf(' k = %g +/- %g \n',k.plastic,k.plastic*dc.plastic);
fprintf(' B = %g +/- %g \n',B.plastic,dB.plastic);
fprintf(' Chi-squared: %g\n',chisqr.plasTwo);
fprintf('         N-M: %g \n',n.plastic-m.plastic);