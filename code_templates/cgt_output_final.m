%--------------------------------------------------------------------------
% save tracers, auxiliary variables and process rates to final output array
%--------------------------------------------------------------------------
% in the water column
<tracers vertLoc=WAT; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</tracers>

<auxiliaries vertLoc=WAT; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</auxiliaries>

<processes vertLoc=WAT; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</processes>

% in the sediment
<tracers vertLoc=SED; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</tracers>

<auxiliaries vertLoc=SED; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</auxiliaries>

<processes vertLoc=SED; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</processes>

% at the sea surface
<tracers vertLoc=SUR; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</tracers>

<auxiliaries vertLoc=SUR; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</auxiliaries>

<processes vertLoc=SUR; isOutput=1>
  output_<name>(1,current_output_index)=output_scalar_<name>/output_count;
</processes>

% now, set the temporary output vector to zero
<tracers vertLoc=WAT; isOutput=1>
  output_scalar_<name> = 0.0;
</tracers>

<auxiliaries vertLoc=WAT; isOutput=1>
  output_scalar_<name> = 0.0;
</auxiliaries>

<processes vertLoc=WAT; isOutput=1>
  output_scalar_<name> = 0.0;
</processes>

<tracers vertLoc=SED; isOutput=1>
  output_scalar_<name> = 0.0;        
</tracers>

<auxiliaries vertLoc=SED; isOutput=1>
  output_scalar_scalar_<name> = 0.0;        
</auxiliaries>

<processes vertLoc=SED; isOutput=1>
  output_scalar_<name> = 0.0;        
</processes>

<tracers vertLoc=SUR; isOutput=1>
  output_scalar_<name> = 0.0;        
</tracers>

<auxiliaries vertLoc=SUR; isOutput=1>
  output_scalar_<name> = 0.0;        
</auxiliaries>

<processes vertLoc=SUR; isOutput=1>
  output_scalar_<name> = 0.0;        
</processes>

<constants dependsOn=zt>
  output_scalar_<name> = 0.0;
</constants>