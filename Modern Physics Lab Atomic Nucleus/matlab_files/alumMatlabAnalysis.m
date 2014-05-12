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
<<<<<<< HEAD
% fprintf('Fit parameters:\n');
% for i=1:m.plastic
%     fprintf(' a(%g) = %g +/- %g \n',i,a_fit.plasOne(i),sig_a.plasOne(i));
% end
% Find Zero of y(x) Plastic
zero.xPlas = abs(a_fit.plasOne(1)/a_fit.plasOne(2)); % energy is zero when
zero.thicknessPlas = zero.xPlas * thick.plastic;
range.plasticmeters = zero.thicknessPlas - x.plasOne * thick.plastic; % in meters
range.plasticcentimeters = range.plasticmeters * 100; % in cm
range.plasticgcm2 = range.plasticcentimeters * density.plastic; % in g/cm^2
energy.plaskeV = y.plasOne; % in keV
energy.plasMeV = energy.plaskeV * 1e-3; % in MeV
y.plasTwo = log(range.plasticgcm2); % y = ln(R)
dx.plastic = sigma.plasOne./y.plasOne; % dx = dE/E
x.plasTwo = log(energy.plasMeV); % x = ln(E)
sigma.plasTwo = 0.412*dx.plastic; % dy = dR/R = y*dx
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
% fprintf(' Plastic Fit parameters 1:\n');
% fprintf(' c = %g +/- %g \n',c.plastic,dc.plastic);
% fprintf(' m = %g +/- %g \n',B.plastic,dB.plastic);
% fprintf('log10(k)=b and B=m \n');
% fprintf(' R(E)=kE^B\n');
% fprintf('R(E)=%g E^(%g)\n',k.plastic,B.plastic);
% fprintf(' B = %g +/- %g \n',B.plastic,dB.plastic);

%% Aluminum data ------------------------------
density.aluminum = 2.70; % g/cm^3
thick.Aluminum = 0.000054; % thickness in meters
expData.Aluminum=load('aluminumData.mat');
y.one=expData.Aluminum.data(:,2)';
x.one=expData.Aluminum.data(:,1)';
sigma.one = expData.Aluminum.data(:,3)';
dx.aluminum = sigma.one./y.one; % dE/E
%% Chi-Fit
[a_fit.one, sig_a.one, yy.one, chisqr.one] = ...
    linreg(x.one,y.one,sigma.one);
m.aluminum=2;n.aluminum = length(x.one);
zero.x = abs(a_fit.one(1)/a_fit.one(2)); % energy is zero when
zero.thickness = zero.x * thick.Aluminum;
range.alummeters = zero.thickness - x.one * thick.Aluminum; % in meters
range.alumcentimeters = range.alummeters * 100; % in cm
range.alumgcm2 = range.alumcentimeters * density.aluminum; % in g/cm^2
energy.alumkeV = y.one; % in keV
energy.alumMeV = energy.alumkeV * 1e-3; % in MeV
y.two = log(range.alumgcm2);
x.two = log(energy.alumMeV);
%%
sigma.two = y.two.*dx.aluminum;
%% Print out Statistics
[a_fit.two, sig_a.two, yy.two, chisqr.two] = ...
    linreg(x.two,y.two,sigma.two);
dc.aluminum = sig_a.two(1);
B.aluminum = a_fit.two(2);
dB.aluminum = sig_a.two(2);
k.aluminum = exp(a_fit.two(1));
dy.alumRange = dc.aluminum + B.aluminum*dx.aluminum...
    + x.two	*dB.aluminum; %R.gcm2*0.05./R.gcm2;
%% Print out latest statistics
fprintf('\n')
fprintf('Final Fit Parameters before loop\n')
fprintf('Aluminum:\n');
fprintf(' k = %g +/- %g \n',k.aluminum,k.aluminum*dc.aluminum);
fprintf(' B = %g +/- %g \n',B.aluminum,dB.aluminum);
fprintf(' Chi-squared: %g\n',chisqr.two);
fprintf('         N-M: %g \n',n.aluminum-m.aluminum);
fprintf('Plastic:\n');
fprintf(' k = %g +/- %g \n',k.plastic,k.plastic*dc.plastic);
fprintf(' B = %g +/- %g \n',B.plastic,dB.plastic);
fprintf(' Chi-squared: %g\n',chisqr.plasTwo);
fprintf('         N-M: %g \n',n.plastic-m.plastic);
chisqr.allsaved(1,1) = chisqr.plasTwo;
chisqr.allsaved(2,1) = chisqr.two;
%% * Graph the data, with error bars, and fitting function.
% Bring figure 1 window forward
% k.aluminum = 0.412;
% k.plastic = 0.412;
dRsample.alum(:,1) = dy.alumRange.*range.alumgcm2;
dRsample.plas(:,1) = dy.plasRange.*range.plasticgcm2;
for ii=1:15
dR.plastic = k.plastic*sigma.plasOne*1e-2;
dR.aluminum = k.aluminum*sigma.one*1e-2;
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
% fprintf('Fit parameters:\n');
% for i=1:m.plastic
%     fprintf(' a(%g) = %g +/- %g \n',i,a_fit.plasOne(i),sig_a.plasOne(i));
% end
=======
fprintf('Fit parameters:\n');
for i=1:m.plastic
    fprintf(' a(%g) = %g +/- %g \n',i,a_fit.plasOne(i),sig_a.plasOne(i));
end
>>>>>>> parent of 861ab51... Iterations give different chi squared values
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
y.plasTwo = log(range.plasticgcm2); % y = ln(R)
dx.plastic = sigma.plasOne./y.plasOne; % dx = dE/E
x.plasTwo = log(energy.plasMeV); % x = ln(E)
sigma.plasTwo = y.plasTwo.*dx.plastic; % dy = dR/R = y*dx
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
%% Aluminum data ------------------------------
density.aluminum = 2.70; % g/cm^3
thick.Aluminum = 0.000054; % thickness in meters
expData.Aluminum=load('aluminumData.mat');
y.one=expData.Aluminum.data(:,2)';
x.one=expData.Aluminum.data(:,1)';
sigma.one = expData.Aluminum.data(:,3)';
dx.aluminum = sigma.one./y.one; % dE/E
%% Chi-Fit
[a_fit.one, sig_a.one, yy.one, chisqr.one] = ...
    linreg(x.one,y.one,sigma.one);
m.aluminum=2;n.aluminum = length(x.one);
zero.x = abs(a_fit.one(1)/a_fit.one(2)); % energy is zero when
zero.thickness = zero.x * thick.Aluminum;
range.alummeters = zero.thickness - x.one * thick.Aluminum; % in meters
range.alumcentimeters = range.alummeters * 100; % in cm
range.alumgcm2 = range.alumcentimeters * density.aluminum; % in g/cm^2
energy.alumkeV = y.one; % in keV
energy.alumMeV = energy.alumkeV * 1e-3; % in MeV
y.two = log(range.alumgcm2);
x.two = log(energy.alumMeV);
sigma.two = y.two.*dx.aluminum;
%% Print out Statistics
[a_fit.two, sig_a.two, yy.two, chisqr.two] = ...
    linreg(x.two,y.two,sigma.two);
dc.aluminum = sig_a.two(1);
B.aluminum = a_fit.two(2);
dB.aluminum = sig_a.two(2);
k.aluminum = exp(a_fit.two(1));
dy.alumRange = dc.aluminum + B.aluminum*dx.aluminum...
    + x.two	*dB.aluminum;
dRsample.alum(:,ii+1) = dy.alumRange.*range.alumgcm2;
dRsample.plas(:,ii+1) = dy.plasRange.*range.plasticgcm2;
%R.gcm2*0.05./R.gcm2;
% fprintf(' b = %g +/- %g \n',a_fit.two(1),dc.aluminum);
% fprintf(' m = %g +/- %g \n',B.aluminum,dB.aluminum);
% fprintf('ln(k)=b and B=m \n');
% fprintf(' R(E)=kE^B\n');
% fprintf('R(E)=%g E^(%g)\n',10^(a_fit.two(1)),B.aluminum);
%% * Graph the data, with error bars, and fitting function.
% Bring figure 1 window forward
figure('Units', 'pixels', ...
    'Position', [100 100 500 375]);
dR.plastic = range.plasticgcm2.*dy.plasRange;
dR.aluminum = range.alumgcm2.*dy.alumRange;
plotOf.OurErrorBarsPlastic = errorbar(energy.plasMeV,...
    range.plasticgcm2,dR.plastic,'o'...
    ,'color','k');  % Graph data with error bars
hold on;                  % Freeze the plot to add the fit
plotOf.OurFitPlastic = plot(energy.plasMeV,exp(yy.plasTwo),'-'...
    ,'color','k');
plotOf.OurErrorBarsAluminum = errorbar(energy.alumMeV,...
<<<<<<< HEAD
    exp(yy.two),dR.aluminum,'.');  % Graph data with error bars
plotOf.OurFitAluminum = plot(energy.alumMeV,range.alumgcm2,'-');
=======
    range.alumgcm2,dR.aluminum,'o');  % Graph data with error bars
plotOf.OurFitAluminum = plot(energy.alumMeV,exp(yy.two),'-');
>>>>>>> parent of 861ab51... Iterations give different chi squared values
% Plot the fit on same graph as data
hXLabel =  xlabel('Energy [MeV]'); hYLabel = ylabel('R(E) [g/cm^{2}]');
hTitle = title(sprintf(...
    '$\\chi^2 ($Al$) = %0.3g, \\chi^2 ($Pl$) = %0.3g$'...
    ,chisqr.two, chisqr.plasTwo),...
                'Interpreter','latex')
fprintf('  y(x) = %g + %g x \n',a_fit.two(1),B.aluminum);
% otherSources(plotOf.OurErrorBarsAluminum,plotOf.OurFitPlastic,plotOf.OurErrorBarsPlastic,plotOf.OurFitAluminum,0,k.aluminum,B.aluminum,k.plastic,B.plastic);
[kinetic,csda] = importNISTdataNow('edatacsda_Range.txt',6, 86);
[kinetic2,csda2] = importNISTdataNow('plasticNISTData.txt',6, 86);
nist.Range = 23:30;
plotOf.NISTplastic = plot(kinetic2(nist.Range),csda2(nist.Range),'color','g');
plotOf.NIST=plot(kinetic(nist.Range),...
    csda(nist.Range),'color','r');
%% Other Source
nist.energy = kinetic;
source.Other = .412*nist.energy.^(1.265 - ...
    0.0954*log(nist.energy));
plotOf.Other = plot(kinetic(nist.Range)...
    ,source.Other(nist.Range),'m');
%% Plot features
hLegend = legend([plotOf.OurFitAluminum,plotOf.OurFitPlastic,...
    plotOf.NIST,plotOf.NISTplastic,plotOf.Other],...
    sprintf('R(E)=%0.3f E^{%0.4g}  (Aluminum)\n',k.aluminum,B.aluminum),...
    sprintf('R(E)=%0.3f E^{%0.4g}  (Plastic)\n',k.plastic,B.plastic),...
    'NIST (Aluminum)',...
    'NIST (Plastic)',...
    sprintf('R(E)=0.412 E^{1.265 - 0.0954*ln(E)}'),'location','best');
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
    plotOf.NIST,plotOf.NISTplastic,plotOf.Other], ...
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
printTrueFalse=1;
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
fprintf(' k = %g +/- %g \n',k.aluminum,k.aluminum*dc.aluminum);
fprintf(' B = %g +/- %g \n',B.aluminum,dB.aluminum);
fprintf(' Chi-squared: %g\n',chisqr.two);
fprintf('         N-M: %g \n',n.aluminum-m.aluminum);
fprintf('Plastic:\n');
fprintf(' k = %g +/- %g \n',k.plastic,k.plastic*dc.plastic);
fprintf(' B = %g +/- %g \n',B.plastic,dB.plastic);
fprintf(' Chi-squared: %g\n',chisqr.plasTwo);
fprintf('         N-M: %g \n',n.plastic-m.plastic);
