%--------------------------------
% load initial values for tracers
%--------------------------------

% some need to be loaded from files
<tracers vertLoc=WAT; useInitValue=0>
  tempstring = strtrim('<name>');
  tempstring = strcat('init/',tempstring,'.txt');
  tracer_scalar_<name> = load(tempstring);
</tracers>

<tracers vertLoc=SED; useInitValue=0>
  tempstring = strtrim('<name>');
  tempstring = strcat('init/',tempstring,'.txt');
  tracer_scalar_<name> = load(tempstring);
</tracers>

<tracers vertLoc=SUR; useInitValue=0>
  tempstring = strtrim('<name>');
  tempstring = strcat('init/',tempstring,'.txt');
  tracer_scalar_<name> = load(tempstring);
</tracers>

% others are initialized as constant
<tracers vertLoc=WAT; useInitValue=1>
  tracer_scalar_<name> = <initValue>;
</tracers>

<tracers vertLoc=SED; useInitValue=1>
  tracer_scalar_<name> = <initValue>;
</tracers>

<tracers vertLoc=SUR; useInitValue=1>
  tracer_scalar_<name> = <initValue>;
</tracers>

% auxiliaries which communicate data from the last time step are set to 0
<auxiliaries vertLoc=WAT; isUsedElsewhere=1>
  auxiliary_scalar_<name> = 0.0;
</auxiliaries>

<auxiliaries vertLoc=SED; isUsedElsewhere=1>
  auxiliary_scalar_<name> = 0.0;
</auxiliaries>

<auxiliaries vertLoc=SUR; isUsedElsewhere=1>
  auxiliary_scalar_<name> = 0.0;
</auxiliaries>
