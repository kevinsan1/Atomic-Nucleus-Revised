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
range.meters = zero.thicknessPlas - x.plasOne * thick.plastic; % in meters
range.centimeters = range.meters * 100; % in cm
range.plasticgcm2 = range.centimeters * density.plastic; % in g/cm^2
energy.keV = y.plasOne; % in keV
energy.MeV = energy.keV * 1e-3; % in MeV
y.plasTwo = log(range.plasticgcm2);
dx.plastic = sigma.plasOne./y.plasOne;
x.plasTwo = log(energy.MeV);
sigma.plasTwo = dx.plastic; %R.plasticgcm2*0.05./R.plasticgcm2;
%% Chi-Fit
[a_fit.plasTwo, sig_a.plasTwo, yy.plasTwo, chisqr.plasTwo] = ...
    linreg(x.plasTwo,y.plasTwo,sigma.plasTwo);
db.plastic = sig_a.plasTwo(1);
B.plastic = a_fit.plasTwo(2);
dB.plastic = sig_a.plasTwo(2);
k.plastic = exp(a_fit.plasTwo(1));
%% Print out statistics
fprintf(' Plastic Fit parameters:\n');
fprintf(' b = %g +/- %g \n',a_fit.plasTwo(1),db.plastic);
fprintf(' m = %g +/- %g \n',B.plastic,dB.plastic);
fprintf('log10(k)=b and B=m \n');
fprintf(' R(E)=kE^B\n');
fprintf('R(E)=%g E^(%g)\n',k.plastic,B.plastic);
fprintf(' B = %g +/- %g \n',B.plastic,dB.plastic);
%% Aluminum data ------------------------------
density.aluminum = 2.70; % g/cm^3
thick.Aluminum = 0.000054; % thickness in meters
expData.Aluminum=load('aluminumData.mat');
y.one=expData.Aluminum.data(:,2)';
x.one=expData.Aluminum.data(:,1)';
sigma.one = expData.Aluminum.data(:,3)';
dx.aluminum = sigma.one./y.one; % dE/E
[a_fit.one, sig_a.one, yy.one, chisqr.one] = ...
    linreg(x.one,y.one,sigma.one);
m.aluminum=2;n.aluminum = length(x.one);
% * Print out the fit parameters, including their error bars.
% fprintf('Fit parameters:\n');
% for i=1:M
%     fprintf(' a(%g) = %g +/- %g \n',i,a_fit.one(i),sig_a.one(i));
% end
% * Graph the data, with error bars, and fitting function.
% errorbar(x.one,y.one,sigma.one,'o'); % Graph data with error bars
% hold on;                  % Freeze the plot to add the fit
% plot(x.one,yy.one,'-');           % Plot the fit on same
% graph as data
% xlabel('x_i'); ylabel('y_i and Y(x)');
% title(['\chi^2 = ',num2str(chisqr.one),'  N-M = ',num2str(N-M)]);
% fprintf('  y(x) = %g + %g x \n',a_fit.one(1),a_fit.one(2));
% Find Zero of y(x)
zero.x = abs(a_fit.one(1)/a_fit.one(2)); % energy is zero when
% x is _. x is in units of # of sheets of aluminum multiply
% (# of sheets)
% by sheet thickness to get total sheet thickness when it should
% stop the electrons
zero.thickness = zero.x * thick.Aluminum;
% Define R(E) = kE^B
range.meters = zero.thickness - x.one * thick.Aluminum; % in meters
range.centimeters = range.meters * 100; % in cm
range.gcm2 = range.centimeters * density.aluminum; % in g/cm^2
energy.keV = y.one; % in keV
energy.MeV = energy.keV * 1e-3; % in MeV
y.two = log(range.gcm2);
x.two = log(energy.MeV);
sigma.two = dx.aluminum; %R.gcm2*0.05./R.gcm2;
%% Print out Statistics
[a_fit.two, sig_a.two, yy.two, chisqr.two] = ...
    linreg(x.two,y.two,sigma.two);
db.aluminum = sig_a.two(1);
B.aluminum = a_fit.two(2);
dB.aluminum = sig_a.two(2);
k.aluminum = exp(a_fit.two(1));
% fprintf(' b = %g +/- %g \n',a_fit.two(1),db.aluminum);
% fprintf(' m = %g +/- %g \n',B.aluminum,dB.aluminum);
% fprintf('ln(k)=b and B=m \n');
% fprintf(' R(E)=kE^B\n');
% fprintf('R(E)=%g E^(%g)\n',10^(a_fit.two(1)),B.aluminum);
%% * Graph the data, with error bars, and fitting function.
% Bring figure 1 window forward
figure('Units', 'pixels', ...
    'Position', [100 100 500 375]);
plotOf.OurErrorBarsPlastic = errorbar(exp(x.plasTwo),...
    exp(y.plasTwo),exp(sigma.plasTwo),'o'...
    ,'color','k');  % Graph data with error bars
hold on;                  % Freeze the plot to add the fit
plotOf.OurFitPlastic = plot(exp(x.plasTwo),exp(yy.plasTwo),'-'...
    ,'color','k');
plotOf.OurErrorBarsAluminum = errorbar(exp(x.two),...
    exp(y.two),exp(sigma.two),'o');  % Graph data with error bars
plotOf.OurFitAluminum = plot(exp(x.two),exp(yy.two),'-');
% Plot the fit on same graph as data
hXLabel =  xlabel('Energy [MeV]'); hYLabel = ylabel('R(E) [g/cm^{2}]');
hTitle = title(['\chi^2 = ',num2str(chisqr.plasTwo),'  N-M = ',...
    num2str(n.plastic-m.plastic)]);
fprintf('  y(x) = %g + %g x \n',a_fit.two(1),B.aluminum);
%% NIST
[kinetic,csda] = importNISTdataNow('edatacsda_Range.txt',6, 86);
nist.Range = 23:30;
plotOf.NIST=plot(kinetic(nist.Range),...
    csda(nist.Range),'color','r');
%% Other Source
nist.energy = kinetic;
source.Other = .412*nist.energy.^(1.265 - 0.0954*log(nist.energy));
plotOf.Other = plot(kinetic(nist.Range)...
    ,source.Other(nist.Range),'m');
%% Plot features
hLegend = legend([plotOf.OurFitAluminum,plotOf.OurFitPlastic,...
    plotOf.NIST,plotOf.Other],...
    sprintf('R(E)=%g E^{%g}\n',k.aluminum,B.aluminum),...
    sprintf('R(E)=%g E^{%g}\n',k.plastic,B.plastic),...
    'NIST','Other');
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel], ...
    'FontName'   , 'AvantGarde');
set([ gca]             , ...
    'FontSize'   , 8           );
set([hXLabel, hYLabel,hLegend]  , ...
    'FontSize'   , 10          );
set( hTitle                    , ...
    'FontSize'   , 12          , ...
    'FontWeight' , 'bold'      );
set([plotOf.OurFitAluminum,plotOf.OurFitPlastic,...
    plotOf.NIST,plotOf.Other], ...
    'LineWidth'       , 1.5          );
set([plotOf.OurErrorBarsAluminum,plotOf.OurErrorBarsPlastic], ...
    'LineWidth'       , 1.5          );
set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.02 .02] , ...
    'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'YGrid'       , 'on'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3], ...
    'LineWidth'   , 1         );
hold off;
printTrueFalse=0;
if printTrueFalse == 1
    set(gcf, 'PaperPositionMode', 'auto');
    figurePath = ['/Users/kevin/SkyDrive/KTH Work/Period 3'...
        ' 2014/SH2008/Atomic Nucleus Revised/Figures/'];
    print('-depsc2',[figurePath sprintf('alum_plas_NIST_plot')])
end
%% Print out latest statistics
fprintf('\n')
fprintf('Final Fit Parameters\n')
fprintf('Aluminum:\n');
fprintf(' k = %g +/- %g \n',k.aluminum,k.aluminum*db.aluminum);
fprintf(' B = %g +/- %g \n',B.aluminum,dB.aluminum);
fprintf(' Chi-squared: %g\n',chisqr.two);
fprintf('         N-M: %g \n',n.aluminum-m.aluminum);
fprintf('Plastic:\n');
fprintf(' k = %g +/- %g \n',k.plastic,k.plastic*db.plastic);
fprintf(' B = %g +/- %g \n',B.plastic,dB.plastic);
fprintf(' Chi-squared: %g\n',chisqr.plasTwo);
fprintf('         N-M: %g \n',n.plastic-m.plastic);
