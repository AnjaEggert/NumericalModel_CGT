%-----------------------------
% initialize the output arrays
%-----------------------------

% tracers
<tracers vertLoc=WAT; isOutput=1>
  % <description> :
    output_<name> = zeros(1, max_output_index)/0.0; 
    output_scalar_<name> = 0.0;
</tracers>

<tracers vertLoc=SED; isOutput=1>
  % <description> :
    output_<name> = zeros(1, max_output_index)/0.0;
    output_scalar_<name> = 0.0;
</tracers>

<tracers vertLoc=SUR; isOutput=1>
  % <description>
    output_<name> = zeros(1, max_output_index)/0.0;
    output_scalar_<name> = 0.0;
</tracers>

% processes
<processes vertLoc=WAT; isOutput=1>
  % <description> :
    output_<name> = zeros(1, max_output_index)/0.0; 
    output_scalar_<name> = 0.0;
</processes>

<processes vertLoc=SED; isOutput=1>
  % <description> :
    output_<name> = zeros(1, max_output_index)/0.0;
    output_scalar_<name> = 0.0;
</processes>

<processes vertLoc=SUR; isOutput=1>
  % <description>
    output_<name> = zeros(1, max_output_index)/0.0;
    output_scalar_<name> = 0.0;
</processes>

% auxiliary variables
<auxiliaries vertLoc=WAT; isOutput=1>
  % <description> :
    output_<name> = zeros(1, max_output_index)/0.0; 
    output_scalar_<name> = 0.0;
</auxiliaries>

<auxiliaries vertLoc=SED; isOutput=1>
  % <description> :
    output_<name> = zeros(1, max_output_index)/0.0;
    output_scalar_<name> = 0.0;
</auxiliaries>

<auxiliaries vertLoc=SUR; isOutput=1>
  % <description>
    output_<name> = zeros(1, max_output_index)/0.0;
    output_scalar_<name> = 0.0;
</auxiliaries>

%time-dependent constants
<constants dependsOn=zt>
  % <description> :
    output_<name> = zeros(1, max_output_index)/0.0; 
    output_scalar_<name> = 0.0;
</constants>