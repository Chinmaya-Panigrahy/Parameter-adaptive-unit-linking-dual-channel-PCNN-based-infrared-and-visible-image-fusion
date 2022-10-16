function [cp map]=cell2matrix_nsct(nsct_cell)
% for [2 3 4];
% Level of decomposition.
clevels = length( nsct_cell) ;
cp=[];
map=[];
for i=1:clevels
    if iscell( nsct_cell{i} )
        cp=[cp cell2mat(nsct_cell{i})];
        map(1,i)=length(nsct_cell{i});
    else
        cp=nsct_cell{i};
        map(1,1)=1;
    end
end