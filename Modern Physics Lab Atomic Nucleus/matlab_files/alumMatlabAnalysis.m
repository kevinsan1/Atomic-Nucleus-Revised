clear all
clc
close all
myPath = ['/Users/kevin/SkyDrive/KTH Work/Period'...
    ' 3 2014/SH2008/Atomic Nucleus Revised/Modern'...
    ' Physics Lab Atomic Nucleus/'];
addpath(genpath(myPath));
%% Plastic data
density.plastic = 1.13; % g/cm^3
thick.plastic = 0.0001; % thickness in meters
expData=[... % # of sheets, energy in (keV)
0,624.259;
1,591.5  ;
2,567.5  ;
3,537.5  ;
4,501    ;
5,470.5  ;
7,413];
y.plasOne=expData(:,2)';
x.plasOne=expData(:,1)';
sigma.plasOne = [...
6.5,
6.5,
5.5,
6.5,
9  ,
4.5,
13]';
[a_fit.plasOne, sig_a.plasOne, yy.plasOne, chisqr.plasOne] = ...
    linreg(x.plasOne,y.plasOne,sigma.plasOne);
M=2;
N = length(x.plasOne);
%% * Print out the fit parameters, including their error bars.
fprintf('Fit parameters:\n');
for i=1:M
  fprintf(' a(%g) = %g +/- %g \n',i,a_fit.plasOne(i),sig_a.plasOne(i));
end
%% Find Zero of y(x) Plastic
zero.xPlas = abs(a_fit.plasOne(1)/a_fit.plasOne(2)); % energy is zero when
% x is _. x is in units of # of sheets of plastic multiply
% (# of sheets)
% by sheet thickness to get total sheet thickness when it should
% stop the electrons
zero.thicknessPlas = zero.xPlas * thick.plastic;
%% Define R(E) = kE^B
R.meters = zero.thicknessPlas - x.plasOne * thick.plastic; % in meters
R.centimeters = R.meters * 100; % in cm
R.plasticgcm2 = R.centimeters * density.plastic; % in g/cm^2
E.keV = y.plasOne; % in keV
E.MeV = E.keV * 1e-3; % in MeV
y.plasTwo = log10(R.plasticgcm2);
x.plasTwo = log10(E.MeV);
sigma.plasTwo = (sigma.plasOne*expData(:,1)./expData(:,2))';
%%
[a_fit.plasTwo, sig_a.plasTwo, yy.plasTwo, chisqr.plasTwo] = ...
    linreg(x.plasTwo,y.plasTwo,sigma.plasTwo);
fprintf('Fit parameters:\n');
fprintf(' b = %g +/- %g \n',a_fit.plasTwo(1),sig_a.plasTwo(1));
fprintf(' m = %g +/- %g \n',a_fit.plasTwo(2),sig_a.plasTwo(2));
fprintf('ln(k)=b and B=m \n');
fprintf(' R(E)=kE^B\n');
fprintf('R(E)=%g E^(%g)\n',10^(a_fit.plasTwo(1)),a_fit.plasTwo(2));
%% * Graph the data, with error bars, and fitting function.
plotOf.OurErrorBarsPlastic = errorbar(10.^x.plasTwo,...
    10.^y.plasTwo,sigma.plasTwo,'o'...
    ,'color','k');  % Graph data with error bars
hold on;                  % Freeze the plot to add the fit
plotOf.OurFitPlastic = plot(10.^x.plasTwo,10.^yy.plasTwo,'-'...
    ,'color','k');
% Plot the fit on same graph as data
xlabel('Energy [MeV]'); ylabel('R(E) [g/cm^{2}]');
title(['\chi^2 = ',num2str(chisqr.plasTwo),'  N-M = ',num2str(N-M)]);
fprintf('  y(x) = %g + %g x \n',a_fit.plasTwo(1),a_fit.plasTwo(2));
%%%%%
%%%%%
%% Aluminum data ------------------------------
density.aluminum = 2.70; % g/cm^3
thickAlum = 0.000054; % thickness in meters
expData=[... % # of sheets, energy in (keV)
0,624.259; 
1,601    ;
2,577.5  ;
3,550.5  ;
4,505.5  ;
5,470.5  ;
6,450.5 ];
y.one=expData(:,2)';
x.one=expData(:,1)';
sigma.one = [...
4,
4,
1.5,
7.5,
1.5,
8.5,
10.5]';
[a_fit.one, sig_a.one, yy.one, chisqr.one] = ...
    linreg(x.one,y.one,sigma.one);
M=2;
N = length(x);
%% * Print out the fit parameters, including their error bars.
fprintf('Fit parameters:\n');
for i=1:M
  fprintf(' a(%g) = %g +/- %g \n',i,a_fit.one(i),sig_a.one(i));
end
%% * Graph the data, with error bars, and fitting function.
errorbar(x.one,y.one,sigma.one,'o'); % Graph data with error bars
hold on;                  % Freeze the plot to add the fit
plot(x.one,yy.one,'-');           % Plot the fit on same 
% graph as data
xlabel('x_i'); ylabel('y_i and Y(x)');
title(['\chi^2 = ',num2str(chisqr.one),'  N-M = ',num2str(N-M)]);
fprintf('  y(x) = %g + %g x \n',a_fit.one(1),a_fit.one(2));
%% Find Zero of y(x)
zero.x = abs(a_fit.one(1)/a_fit.one(2)); % energy is zero when
% x is _. x is in units of # of sheets of aluminum multiply
% (# of sheets)
% by sheet thickness to get total sheet thickness when it should
% stop the electrons
zero.thickness = zero.x * thickAlum;
%% Define R(E) = kE^B
R.meters = zero.thickness - x.one * thickAlum; % in meters
R.centimeters = R.meters * 100; % in cm
R.gcm2 = R.centimeters * density.aluminum; % in g/cm^2
E.keV = y.one; % in keV
E.MeV = E.keV * 1e-3; % in MeV
y.two = log10(R.gcm2);
x.two = log10(E.MeV);
sigma.two = (sigma.one*expData(:,1)./expData(:,2))';
%%
[a_fit.two, sig_a.two, yy.two, chisqr.two] = ...
    linreg(x.two,y.two,sigma.two);
fprintf('Fit parameters:\n');
fprintf(' b = %g +/- %g \n',a_fit.two(1),sig_a.two(1));
fprintf(' m = %g +/- %g \n',a_fit.two(2),sig_a.two(2));
fprintf('ln(k)=b and B=m \n');
fprintf(' R(E)=kE^B\n');
fprintf('R(E)=%g E^(%g)\n',10^(a_fit.two(1)),a_fit.two(2));
%% * Graph the data, with error bars, and fitting function.
          % Bring figure 1 window forward
figure('Units', 'pixels', ...
    'Position', [500 100 500 375]);
plotOf.OurErrorBarsPlastic = errorbar(10.^x.plasTwo,...
    10.^y.plasTwo,sigma.plasTwo,'o'...
    ,'color','k');  % Graph data with error bars
hold on;                  % Freeze the plot to add the fit
plotOf.OurFitPlastic = plot(10.^x.plasTwo,10.^yy.plasTwo,'-'...
    ,'color','k');
plotOf.OurErrorBarsAluminum = errorbar(10.^x.two,...
    10.^y.two,sigma.two,'o');  % Graph data with error bars
plotOf.OurFitAluminum = plot(10.^x.two,10.^yy.two,'-');
% Plot the fit on same graph as data
hXLabel =  xlabel('Energy [MeV]'); hYLabel = ylabel('R(E) [g/cm^{2}]');
hTitle = title(['\chi^2 = ',num2str(chisqr.two),'  N-M = ',num2str(N-M)]);
fprintf('  y(x) = %g + %g x \n',a_fit.two(1),a_fit.two(2));
%% NIST
[Kinetic,CSDA] = importNISTdataNow('edataCSDA_Range.txt',6, 86);
startNist = 23;
endNist = 30;
plotOf.NIST=plot(Kinetic(startNist:endNist),...
CSDA(startNist:endNist),'.','color','r');
hLegend = legend([plotOf.OurFitAluminum,plotOf.OurFitPlastic,...
    plotOf.NIST],...
sprintf('R(E)=%g E^{%g}\n',10^(a_fit.two(1)),a_fit.two(2)),...
sprintf('R(E)=%g E^{%g}\n',10^(a_fit.plasTwo(1)),a_fit.plasTwo(2)),...
'NIST');
%% Plot features
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
    plotOf.NIST], ...
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
set(gcf, 'PaperPositionMode', 'auto');
figurePath = ['/Users/kevin/SkyDrive/KTH Work/Period 3'...
    ' 2014/SH2008/Atomic Nucleus Revised/Figures/'];
print('-depsc2',[figurePath sprintf('alum_plas_NIST_plot')])
