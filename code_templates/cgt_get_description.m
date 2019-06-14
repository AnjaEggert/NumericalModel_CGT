function [ description ] = cgt_get_description( name )
%CGT_GET_DESCRIPTION get the description for a cgt output variable name
  
  description = '';
  <tracers isOutput=1; vertLoc=WAT>
    if strcmpi(strtrim(name),strtrim('<name>'))
        description = '<description>';
    end
  </tracers>
  <tracers isOutput=1; vertLoc/=WAT>
    if strcmpi(strtrim(name),strtrim('<name>'))
        description = '<description>';
    end
  </tracers>
  <auxiliaries isOutput=1>
    if strcmpi(strtrim(name),strtrim('<name>'))
        description = '<description>';
    end
  </auxiliaries>
  <processes isOutput=1>
    if strcmpi(strtrim(name),strtrim('<name>'))
        description = '<description>';
    end
  </processes>
end

