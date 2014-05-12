function variableMaker( variableValue, variableName, variablePath,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% variableName = num2mstr(variableName);
FID = fopen([variablePath variableName '.tex'], 'w');
% n=3;
%%
if n == 1
    fprintf(FID, ['\\def\\' variableName sprintf('{%0.2f} \n',variableValue)]);
    fclose(FID);
elseif n==3
    fprintf(FID, ['\\def\\' variableName sprintf('{%0.3f} \n',variableValue)]);
    fclose(FID);
end

