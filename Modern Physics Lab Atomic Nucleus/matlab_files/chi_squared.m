clear all
clc
myPath = ['/Users/kevin/SkyDrive/KTH Work/Period 3'...
    ' 2014/SH2008/Atomic Nucleus Revised/'];
addpath(genpath(myPath));
cd(myPath);
%% Aluminum data
thickAlum = 0.000054; % thickness in meters
expData=[... % plate length in meters, energy in (keV)
0,624.259; 
1,601    ;
2,577.5  ;
3,550.5  ;
4,505.5  ;
5,470.5  ;
6,450.5 ];
%% Start
densityOfAluminum = 1.13; % mg/cm^3
% ln(Range) = y
plateLength = [0 0.000054 ... % in meters
0.000108 0.000162 0.000216 0.00027 0.000324];
y = log10(1.13*1000*(plateLength*100));
% ln(E) = x
x = log10(1/1000*[624.259 601 ...
    577.5 550.5 505.5 470.5 450.5]);
sigmaX = log10(1/1000*[3, 4, 1.5, 7.5, 1.5, 8.5, 10.5]);
sigmaY = log10([1.3764 2.9822 ...
    2.5234 2.9822 4.1292 2.0646 5.9644]);
N = length(y);
M = 2;
%%
[a_fit, sig_a, yy, chisqr] = linreg(x,y,sigmaY);
%%
%% * Print out the fit parameters, including their error bars.
fprintf('Fit parameters:\n');
fprintf(' b = %g +/- %g \n',a_fit(1),sig_a(1));
fprintf(' m = %g +/- %g \n',a_fit(2),sig_a(2));
fprintf('ln(k)=b and B=m \n');
fprintf(' R(E)=kE^B\n');
fprintf(' R(E)=%g E^(%g)\n',10^(a_fit(1)),a_fit(2));
%% * Graph the data, with error bars, and fitting function.
figure(1); clf;           % Bring figure 1 window forward
errorbar(x,10.^y',sigmaY,'o');  % Graph data with error bars
hold on;                  % Freeze the plot to add the fit
%%
plot(x,10.^(yy),'-');      % Plot the fit on same graph as data
xlabel('x_i'); ylabel('y_i and Y(x)');
title(['\chi^2 = ',num2str(chisqr),'    N-M = ',num2str(N-2)]);
%%
figure(2)
clf;
[Kinetic,CSDA] = importNISTdataNow('edataCSDA_Range.txt',6, 86);
% CSDA = 1000*CSDA;
plot(log10(Kinetic),log10(CSDA))
%%
figure(3)
clf;
plot(x,10.^(yy),'-'); 
hold on;
startN = 42;
finishN = 55;
plot(log(Kinetic(startN:finishN)),CSDA(startN:finishN));