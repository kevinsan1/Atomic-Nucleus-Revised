function variableMaker( variableValue, variableName, variablePath)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% variableName = num2mstr(variableName);
FID = fopen([variablePath variableName '.tex'], 'w');
%%
fprintf(FID, ['\\def\\' variableName sprintf('{%0.4f} \n',variableValue)]);
fclose(FID);
end

