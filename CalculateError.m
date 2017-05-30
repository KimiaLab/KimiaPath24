function [N_totall,N_P,N_W]=Error_Calc(GS)
if ~isnumeric(GS)
    GS=csvread(GS);
end
if exist('Kimia_Path24.h5','file')==2 % if h5 file was in the current folder
    GT=double(h5read('Kimia_Path24.h5','/test_data/targets'));% Get the target patches labels
else% browse for the h5 file
    [FileName,PathName] = uigetfile('*.h5','Select the MATLAB code file');
    addpath(PathName)
    GT=double(h5read(FileName,'/test_data/targets'));% Get the target patches labels
end

if numel(GS)~=numel(GT) % check if the number of estimated patches are same as target(1325)?
    print('Error : The number of test imagesmust be 1325')
else
    if size(GS)~=size(GT)
        GS=GS';%Transpose if the input was the row vector
    end
    %^Geaound trust label
    N_P=sum(GT==GS)/numel(GT)*100   %Calculate percentage of true guess out of 1325
    Cnf=confusionmat(GS,GT);        %Calculate confusion matrix
    E=eye(numel(unique(GT))).*(Cnf);%Extract the main diagonal (equvalent by the N_W)
    N_W=mean((sum(E)./sum(Cnf)))*100    %whole-scan accuracy
    N_totall=N_W*N_P/100                %Total accuracy
end