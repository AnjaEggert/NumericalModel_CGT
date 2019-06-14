%-----------------
% define constants
%-----------------
<constants dependsOn=none>
  <name> = <value>; % <description>
</constants>

<constants dependsOn=zt>
forcing_<name>   = load('bgc_forcing/<trimname>.txt');  % <description>
forcing_index_<name> = 1;
</constants>
