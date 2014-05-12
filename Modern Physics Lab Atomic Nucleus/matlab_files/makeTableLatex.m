function makeTableLatex( firstColumn,secondColumn,thirdColumn,fourthColumn,tableName )
%makeTableLatex( firstColumn,secondColumn,thirdColumn,fourthColumn,tableName )
% Summary of this function goes here
%   Detailed explanation goes here
FID = fopen(tableName, 'w');
%%
fprintf(FID, '\\begin{table}[h] \n');
fprintf(FID, '   \\begin{center} \n');
fprintf(FID, '      \\begin{tabular}{llll}\\toprule \n');
fprintf(FID, '\\multicolumn{2}{c}{Aluminum} & \\multicolumn{2}{c}{Plastic}\\\\ \n');
			fprintf(FID,'\\cmidrule(r){1-2} \n'); 
			fprintf(FID,'\\cmidrule(r){3-4} \n');
			fprintf(FID,'$\\delta R(E)$ [$\\frac{\\text{mg}}{\\text{cm}^2}$] & $\\delta E$ [keV] & $\\delta R(E)$ [$\\frac{\\text{mg}}{\\text{cm}^2}$] & $\\delta E$ [keV]\\\\ \\midrule \n');
for k=1:length(firstColumn)
    fprintf(FID, '%8.2f & %8.2f & %8.2f & %8.2f \\\\ ', firstColumn(k), secondColumn(k), thirdColumn(k), fourthColumn(k));
    if k==length(firstColumn)
        fprintf(FID, '\\bottomrule ');
    end
    fprintf(FID, '\n');
end
 fprintf(FID, '      \\end{tabular} \n');
fprintf(FID, '   \\end{center}\n');
fprintf(FID,'\\caption{The uncertainties in the range is calculated from our uncertainties in energy peaks using equation,\\cite{093570275X} $\\delta R(E) = |k| \\delta E$. This equates to about 1 percent uncertainty.} \n');
fprintf(FID,'\\label{tab:uncertaintyConversion} \n')
fprintf(FID, '\\end{table} \n');
fclose(FID);
end

