workspaceVars = who;

findVars = strfind(workspaceVars, 'output_');
indexVars = find(not(cellfun('isempty', findVars)));
% Now you can use workspaceVars and indexVars along with save
save('../results/output.mat',workspaceVars{indexVars})

% first convert matlab time to string
datetime = datestr(time_axis);
findVars1 = strfind(workspaceVars, 'datetime');
indexVars1 = find(not(cellfun('isempty', findVars1)));
% Now you can use workspaceVars and indexVars along with save
save('../results/datetime.mat',workspaceVars{indexVars1})



