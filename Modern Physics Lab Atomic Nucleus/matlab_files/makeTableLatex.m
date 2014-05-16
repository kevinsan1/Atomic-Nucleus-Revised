function makeTableLatex( firstColumn,secondColumn,thirdColumn,fourthColumn,fifthColumn,sixthColumn,tableName )
%makeTableLatex( firstColumn,secondColumn,thirdColumn,fourthColumn,tableName )
% Summary of this function goes here
%   Detailed explanation goes here
FID = fopen(tableName, 'w');
%%
fprintf(FID, '\\begin{table}[h] \n');
fprintf(FID, '   \\begin{center} \n');
fprintf(FID, '      \\begin{tabular}{llllll}\\toprule \n');
fprintf(FID, '\\multicolumn{3}{c}{Aluminum} & \\multicolumn{3}{c}{Plastic}\\\\ \n');
fprintf(FID,'\\cmidrule(r){1-3} \n');
fprintf(FID,'\\cmidrule(r){4-6} \n');
fprintf(FID,[...
    '$\\delta R(E)$ [$\\frac{\\text{mg}}{\\text{cm}^2}$]',...
    '& $\\delta E$ [keV]',...
    '& $\\delta R/R$ &',...
    '$\\delta R(E)$ [$\\frac{\\text{mg}}{\\text{cm}^2}$]',...
    '& $\\delta E$ [keV]',...
    '& $\\delta R/R$',...
    '\\\\ \\midrule \n']);
for k=1:length(firstColumn)
    fprintf(FID, '%8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f \\\\ ', firstColumn(k), secondColumn(k), thirdColumn(k), fourthColumn(k), fifthColumn(k),sixthColumn(k));
    if k==length(firstColumn)
        fprintf(FID, '\\bottomrule ');
    end
    fprintf(FID, '\n');
end
fprintf(FID, '      \\end{tabular} \n');
fprintf(FID, '   \\end{center}\n');
fprintf(FID,['\\caption{The uncertainties in the range is calculated from',...
    'our extrapolation of the fit and',...
    ' Equation~\\eqref{eq:transformationEquations}',...
    ' $\\delta y = \\delta R/R$. The values obtained are',...
    ' around $1\\perc~$to$~2\\perc$, agreeing with Equation~\\eqref{eq:bergerUncertainty}.   } \n']);
fprintf(FID,'\\label{tab:uncertaintyConversion} \n');
fprintf(FID, '\\end{table} \n');
fclose(FID);
end

