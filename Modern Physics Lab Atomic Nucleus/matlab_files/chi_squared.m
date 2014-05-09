clear all
clc
myPath = ['/Users/kevin/SkyDrive/KTH Work/Period 3'...
    ' 2014/SH2008/Atomic Nucleus Revised/'];
addpath(genpath(myPath));
%% Start
densityOfAluminum = 1.13; % mg/cm^3
y = log(1.13*1000*(0.204748-[0 0.0054 0.0108 0.0162 0.0216 0.027 0.0324]));
x = log(1/1000*[624.259 601 577.5 550.5 505.5 470.5 450.5]);
sigmaE = [3, 4, 1.5, 7.5, 1.5, 8.5, 10.5];
sigmay = log([1.3764 2.9822 2.5234 2.9822 4.1292 2.0646 5.9644]);
N = length(y);
M = 2;
%%
[a_fit, sig_a, yy, chisqr] = linreg(x,y,sigmay);
%%
%% * Print out the fit parameters, including their error bars.
fprintf('Fit parameters:\n');
for i=1:M
  fprintf(' a(%g) = %g +/- %g \n',i,a_fit(i),sig_a(i));
end
%% * Graph the data, with error bars, and fitting function.
figure(1); clf;           % Bring figure 1 window forward
errorbar(x,exp(y),sigmay,'o');  % Graph data with error bars
hold on;                  % Freeze the plot to add the fit
%%
plot(x,exp(yy),'-');           % Plot the fit on same graph as data
xlabel('x_i'); ylabel('y_i and Y(x)');
title(['\chi^2 = ',num2str(chisqr),'    N-M = ',num2str(N-2)]);
%%
figure(2)
clf;
[Kinetic,CSDA] = importNISTdataNow('edataCSDA_Range.txt',6, 86);
% CSDA = 1000*CSDA;
plot(Kinetic,CSDA)