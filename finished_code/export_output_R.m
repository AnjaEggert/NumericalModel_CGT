% save all data starting with output_
workspaceVars = who;
findVars = strfind(workspaceVars, 'output_');
indexVars = find(not(cellfun('isempty', findVars)));
% Now you can use workspaceVars and indexVars along with save
save('../results/output.mat',workspaceVars{indexVars})

% save time_axis in a separate file
% first convert matlab time to string
datetime = datestr(time_axis);
workspaceVars1 = who;
findVars1 = strfind(workspaceVars1, 'datetime');
indexVars1 = find(not(cellfun('isempty', findVars1)));
% Now you can use workspaceVars and indexVars along with save
save('../results/datetime.mat',workspaceVars1{indexVars1})



