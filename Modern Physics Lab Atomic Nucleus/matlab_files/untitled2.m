clear all
FID = fopen('file.tex', 'w');
TC = [-273.15 -40 0 100]';
TK = TC + 273.15;
TF = (TC+40)*9/5-40;
TR = TF + 459.67;
%%
fprintf(FID, '\\begin{tabular}{|rrrr|}\\hline \n');
fprintf(FID, 'T ($^{\\circ}$C) & T (K) & T ($^{\\circ}$F) & T ($^{\\circ}$R)\\\\ \\hline \n');
for k=1:length(TC)
    fprintf(FID, '%8.2f & %8.2f & %8.2f & %8.2f \\\\ ', TC(k), TK(k), TF(k), TR(k));
    if k==length(TC)
        fprintf(FID, '\\hline ');
    end
    fprintf(FID, '\n');
end
 
fprintf(FID, '\\end{tabular}\n');
fclose(FID);