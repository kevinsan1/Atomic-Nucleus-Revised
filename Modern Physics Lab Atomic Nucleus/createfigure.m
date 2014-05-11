function createfigure(XMatrix1, YMatrix1, EMatrix1, X1, Y1, X2, Y2)
%CREATEFIGURE(XMATRIX1, YMATRIX1, EMATRIX1, X1, Y1, X2, Y2)
%  XMATRIX1:  errorbar x matrix
%  YMATRIX1:  errorbar y matrix
%  EMATRIX1:  errorbar e matrix
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  Y2:  vector of y data

%  Auto-generated by MATLAB on 11-May-2014 18:20:29

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');

% Create multiple error bars using matrix input to errorbar
errorbar1 = errorbar(XMatrix1,YMatrix1,EMatrix1,'Marker','o',...
    'LineStyle','none');
set(errorbar1(2),'Color',[0 0 0]);

% Create plot
plot(X1,Y1,'Color',[0 0 0]);

% Create plot
plot(X2,Y2);

% Create xlabel
xlabel('Energy [MeV]');

% Create ylabel
ylabel('R(E) [g/cm^{2}]');

