function [ionLabels,numIons] = read_POSCAR(filepath)

fullFile = readlines(filepath);
ionLabels = split(fullFile(6));
numIons=split(fullFile(7));

end