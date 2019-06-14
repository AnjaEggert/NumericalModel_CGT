%%%%%%%%%%%%%%
% Pre-loop to define cgt_dayofyear, check for leap year
%%%%%%%%%%%%%%
   
mydate=datevec(current_date);
cgt_year=mydate(1);
 
if eomday(mydate(1),2)==29
    if mydate(2)==1
        cgt_dayofyear=mydate(3); 
    end
    if mydate(2)==2 
        cgt_dayofyear=mydate(3)+31; 
    end
    if mydate(2)==3 cgt_dayofyear=mydate(3)+60;   end
    if mydate(2)==4 cgt_dayofyear=mydate(3)+91;   end
    if mydate(2)==5 cgt_dayofyear=mydate(3)+121;  end
    if mydate(2)==6 cgt_dayofyear=mydate(3)+152;  end
    if mydate(2)==7 cgt_dayofyear=mydate(3)+182;  end
    if mydate(2)==8 cgt_dayofyear=mydate(3)+213;  end
    if mydate(2)==9 cgt_dayofyear=mydate(3)+244;  end
    if mydate(2)==10 cgt_dayofyear=mydate(3)+274; end
    if mydate(2)==11 cgt_dayofyear=mydate(3)+305; end
    if mydate(2)==12 cgt_dayofyear=mydate(3)+335; end
else
    if mydate(2)==1
        cgt_dayofyear=mydate(3); 
    end
    if mydate(2)==2 
        cgt_dayofyear=mydate(3)+31; 
    end
    if mydate(2)==3 cgt_dayofyear=mydate(3)+59;   end
    if mydate(2)==4 cgt_dayofyear=mydate(3)+90;   end
    if mydate(2)==5 cgt_dayofyear=mydate(3)+120;  end
    if mydate(2)==6 cgt_dayofyear=mydate(3)+151;  end
    if mydate(2)==7 cgt_dayofyear=mydate(3)+181;  end
    if mydate(2)==8 cgt_dayofyear=mydate(3)+212;  end
    if mydate(2)==9 cgt_dayofyear=mydate(3)+243;  end
    if mydate(2)==10 cgt_dayofyear=mydate(3)+273; end
    if mydate(2)==11 cgt_dayofyear=mydate(3)+304; end
    if mydate(2)==12 cgt_dayofyear=mydate(3)+334; end
end

cgt_hour=mydate(4)+mydate(5)/60+mydate(6)/3600;

      
%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%
             
%------------------------------------
% STEP 1: prepare time-dependent forcing parameters (biotic and abiotic)
%------------------------------------

%------------------------------------
% STEP 1.1: prepare abiotic parameters
%------------------------------------
cgt_temp       = forcing_scalar_temperature;    % potential temperature     [degC]
cgt_light      = forcing_scalar_light;          % light intensity           [W/m2]
cgt_cellheight = cellheight;                    % cell height               [m]
cgt_timestep   = timestep;                      % timestep                  [days]

%------------------------------------
% STEP 1.2: prepare biotic parameters = time-dependent constants
%------------------------------------
<constants dependsOn=zt>
    % <description>:
    <name> = forcing_scalar_<name>;
</constants>
            
%------------------------------------
% STEP 2: load tracer values
%------------------------------------
<tracers vertLoc=WAT>
    % <description>:
    <name> = tracer_scalar_<name>;
</tracers>

<tracers vertLoc=SED>
    % <description>:
    <name> = tracer_scalar_<name>;
</tracers>

<auxiliaries vertLoc=WAT; isUsedElsewhere=1>
    % <description>:
    <name> = auxiliary_scalar_<name>;
</auxiliaries>

<tracers vertLoc=WAT; isPositive=1>
    <name> = max(<name>,0.0);
</tracers>

<tracers vertLoc=SED; isPositive=1>
    <name> = max(<name>,0.0);
</tracers>

%------------------------------------
% STEP 3: calculate auxiliaries
%------------------------------------

%------------------------------------
% STEP 3.1: initialize auxiliaries
%------------------------------------
% initialize auxiliaries for iterative loop
<auxiliaries vertLoc=WAT; calcAfterProcesses=0; iterations/=0>
             <name> = <iterInit>;
</auxiliaries>

% iterative loop follows
for cgt_iteration=1:<maxIterations>
    <auxiliaries vertLoc=WAT; calcAfterProcesses=0; iterations/=0>
    % <description>:
    if cgt_iteration <= <iterations>
        temp1  = <temp1>;
        temp2  = <temp2>;
        temp3  = <temp3>;
        temp4  = <temp4>;
        temp5  = <temp5>;
        temp6  = <temp6>;
        temp7  = <temp7>;
        temp8  = <temp8>;
        temp9  = <temp9>;
        <name> = <formula>;
    end
    </auxiliaries>
end

<auxiliaries vertLoc=WAT; calcAfterProcesses=0; iterations=0>
    % <description>:
    temp1  = <temp1>;
    temp2  = <temp2>;
    temp3  = <temp3>;
    temp4  = <temp4>;
    temp5  = <temp5>;
    temp6  = <temp6>;
    temp7  = <temp7>;
    temp8  = <temp8>;
    temp9  = <temp9>;
    <name> = <formula>;
</auxiliaries>

% initialize auxiliaries for iterative loop
<auxiliaries vertLoc=SED; calcAfterProcesses=0; iterations/=0>
    <name> = <iterInit>;
</auxiliaries>

% iterative loop follows
for cgt_iteration=1:<maxIterations>
    <auxiliaries vertLoc=SED; calcAfterProcesses=0; iterations/=0>
        % <description>:
        if cgt_iteration <= <iterations>
            temp1  = <temp1>;
            temp2  = <temp2>;
            temp3  = <temp3>;
            temp4  = <temp4>;
            temp5  = <temp5>;
            temp6  = <temp6>;
            temp7  = <temp7>;
            temp8  = <temp8>;
            temp9  = <temp9>;
            <name> = <formula>;
        end
    </auxiliaries>
end

<auxiliaries vertLoc=SED; calcAfterProcesses=0; iterations=0>
    % <description>:
    temp1  = <temp1>;
    temp2  = <temp2>;
    temp3  = <temp3>;
    temp4  = <temp4>;
    temp5  = <temp5>;
    temp6  = <temp6>;
    temp7  = <temp7>;
    temp8  = <temp8>;
    temp9  = <temp9>;
    <name> = <formula>;
</auxiliaries>
             
% initialize auxiliaries for iterative loop
<auxiliaries vertLoc=SUR; calcAfterProcesses=0; iterations/=0>
    <name> = <iterInit>;
</auxiliaries>

% iterative loop follows
for cgt_iteration=1:<maxIterations>
    <auxiliaries vertLoc=SUR; calcAfterProcesses=0; iterations/=0>
        % <description> :
        if cgt_iteration <= <iterations>
            temp1  = <temp1>;
            temp2  = <temp2>;
            temp3  = <temp3>;
            temp4  = <temp4>;
            temp5  = <temp5>;
            temp6  = <temp6>;
            temp7  = <temp7>;
            temp8  = <temp8>;
            temp9  = <temp9>;
            <name> = <formula>;
        end
    </auxiliaries>
end

<auxiliaries vertLoc=SUR; calcAfterProcesses=0; iterations=0>
    % <description>:
    temp1  = <temp1>;
    temp2  = <temp2>;
    temp3  = <temp3>;
    temp4  = <temp4>;
    temp5  = <temp5>;
    temp6  = <temp6>;
    temp7  = <temp7>;
    temp8  = <temp8>;
    temp9  = <temp9>;                
    <name> = <formula>;
</auxiliaries>

%------------------------------------
% STEP 3.2: output of auxiliaries
%------------------------------------
<auxiliaries vertLoc=WAT; calcAfterProcesses=0; isOutput=1>             
    output_scalar_<name> = output_scalar_<name> + <name>;
</auxiliaries>

<auxiliaries vertLoc=SED; calcAfterProcesses=0; isOutput=1>
    output_scalar_<name> = output_scalar_<name> + <name>;
</auxiliaries>

<auxiliaries vertLoc=SUR; calcAfterProcesses=0; isOutput=1>
    output_scalar_<name> = output_scalar_<name> + <name>;
</auxiliaries>

%------------------------------------
% STEP 4: calculate process limitations
%------------------------------------

<tracers vertLoc=WAT>
    <limitations>
        <name> = <formula>;
    </limitations>
</tracers>

<tracers vertLoc=SED>
    <limitations>
        <name> = <formula>;
    </limitations>
</tracers>

<tracers vertLoc=SUR>
    <limitations>
        <name> = <formula>;
    </limitations>
</tracers>

%------------------------------------
%-- STEP 5: POSITIVE-DEFINITE SCHEME --------
%-- means the following steps will be repeated as often as nessecary
%------------------------------------

fraction_of_total_timestep = 1.0;   % how much of the original timestep is remaining

<processes>
    total_rate_<name> = 0.0;
</processes>

number_of_loop = 1;

while cgt_timestep > 0.0
    
    %------------------------------------
    % STEP 5.1: calculate process rates
    %------------------------------------
    <processes vertLoc=WAT>
        % <description>:
        <name> = <turnover>;
        <name> = max(<name>,0.0);
    </processes>

    <processes vertLoc=SED>
        % <description> :
        <name> = <turnover>;
        <name> = max(<name>,0.0);
    </processes>

    <processes vertLoc=SUR>
        % <description> :
        <name> = <turnover>;
        <name> = max(<name>,0.0);
    </processes>

    %------------------------------------
    % STEP 5.2: calculate possible euler-forward change (in a full timestep)
    %------------------------------------
    <tracers>
        change_of_<name> = 0.0;
    </tracers>

    <tracers vertLoc=WAT; hasTimeTendenciesVertLoc=WAT>
        change_of_<name> = change_of_<name> + cgt_timestep*(0.0 ...
            <timeTendencies vertLoc=WAT>
                <timeTendency> ... % <description>
            </timeTendencies>
         );
    </tracers>

    <tracers vertLoc=WAT; hasTimeTendenciesVertLoc=SUR>
        change_of_<name> = change_of_<name> + cgt_timestep*(0.0 ...
            <timeTendencies vertLoc=SUR>
                <timeTendency> ... % <description>
         </timeTendencies>
        );
    </tracers>

    <tracers vertLoc=WAT; hasTimeTendenciesVertLoc=SED>
        change_of_<name> = change_of_<name> + cgt_timestep*(0.0 ...
            <timeTendencies vertLoc=SED>
                <timeTendency> ... % <description>
            </timeTendencies>
        );
    </tracers>

    <tracers vertLoc=SED; hasTimeTendencies>
        change_of_<name> = change_of_<name> + cgt_timestep*(0.0 ...
            <timeTendencies>
                <timeTendency> ... % <description>
            </timeTendencies>
        );
    </tracers>    

    %------------------------------------
    % STEP 5.3: calculate maximum fraction of the timestep before some tracer gets exhausted
    %------------------------------------
    timestep_fraction = 1.0;
    which_tracer_exhausted = -1;

    % find the tracer which is exhausted after the shortest period of time

    % in the water column
    <tracers vertLoc=WAT; isPositive=1>
    % check if tracer <name> was exhausted from the beginning and is still consumed
    if (tracer_scalar_<name> <= 0.0) && (change_of_<name> < 0.0)
       timestep_fraction = 0.0;
        which_tracer_exhausted = <numTracer>;
    end
    % check if tracer <name> was present, but got exhausted
    if (tracer_scalar_<name> > 0.0) && (tracer_scalar_<name> + change_of_<name> < 0.0)
        timestep_fraction_new = tracer_scalar_<name> / (0.0 - change_of_<name>);
        if timestep_fraction_new <= timestep_fraction
            which_tracer_exhausted = <numTracer>;
            timestep_fraction = timestep_fraction_new;
        end
    end
    </tracers>
          
    % in the bottom layer
    <tracers vertLoc=SED; isPositive=1>
    % check if tracer <name> was exhausted from the beginning and is still consumed
    if (tracer_scalar_<name> <= 0.0) && (change_of_<name> < 0.0)
        timestep_fraction = 0.0;
        which_tracer_exhausted = <numTracer>;
    end
    % check if tracer <name> was present, but got exhausted
    if (tracer_scalar_<name> > 0.0) && (tracer_scalar_<name> + change_of_<name> < 0.0)
        timestep_fraction_new = tracer_scalar_<name> / (0.0 - change_of_<name>);
        if timestep_fraction_new <= timestep_fraction
            which_tracer_exhausted = <numTracer>;
            timestep_fraction = timestep_fraction_new;
        end
    end
    </tracers>                                   

    % now, update the limitations: rates of the processes limited by this tracer become zero in the future
    <tracers isPositive=1; vertLoc=WAT>
        if <numTracer> == which_tracer_exhausted
            <limitations>
                <name> = 0.0;
         </limitations>
        end
    </tracers>

    <tracers isPositive=1; vertLoc=SED>
        if <numTracer> == which_tracer_exhausted
            <limitations>
                <name> = 0.0;
            </limitations>
        end
    </tracers>

    %------------------------------------
    % STEP 5.4: apply a Euler-forward timestep with the fraction of the time
    %------------------------------------ 
    % in the water column
    <tracers vertLoc=WAT>
        % tracer <name> (<description>):
        tracer_scalar_<name> = tracer_scalar_<name> + change_of_<name> * timestep_fraction;
    </tracers>
        
    % in the bottom layer
    <tracers vertLoc=SED>
        % tracer <name> (<description>)
        tracer_scalar_<name> = tracer_scalar_<name> + change_of_<name> * timestep_fraction;
    </tracers>                                    

    %------------------------------------
    % STEP 5.5: output of process rates
    %------------------------------------
    <processes vertLoc=WAT; isOutput=1>             
        output_scalar_<name> = output_scalar_<name> + <name> * timestep_fraction * fraction_of_total_timestep;
    </processes>

    <processes vertLoc=SED; isOutput=1>
        output_scalar_<name> = output_scalar_<name> + <name> * timestep_fraction * fraction_of_total_timestep;
    </processes>

    <processes vertLoc=SUR; isOutput=1>
        output_scalar_<name> = output_scalar_<name> + <name> * timestep_fraction * fraction_of_total_timestep;
    </processes>
             
    %------------------------------------
    % STEP 5.6: set timestep to remaining timestep only
    %------------------------------------
    cgt_timestep = cgt_timestep * (1.0 - timestep_fraction);                             % remaining timestep
    fraction_of_total_timestep = fraction_of_total_timestep * (1.0 - timestep_fraction); % how much of the original timestep is remaining

    if number_of_loop > 100
        error('aborted positive-definite scheme: more than 100 iterations');
    end
    number_of_loop=number_of_loop+1;
             
end
             
%------------------------------------
%-- END OF POSITIVE-DEFINITE SCHEME -
%------------------------------------  

%------------------------------------
% STEP 6: output
%------------------------------------

%------------------------------------
% STEP 6.1: output of new tracer concentrations
%------------------------------------
<tracers vertLoc=WAT; isOutput=1>
    output_scalar_<name> = output_scalar_<name> + <name>;
</tracers>

<tracers vertLoc=SED; isOutput=1>
    output_scalar_<name> = output_scalar_<name> + <name>;
</tracers>

<tracers vertLoc=SUR; isOutput=1>
    output_scalar_<name> = output_scalar_<name> + <name>;
</tracers>
             
%------------------------------------
% STEP 6.2: calculate "late" auxiliaries
%------------------------------------
<auxiliaries vertLoc=WAT; calcAfterProcesses=1>
    % <description>:
    temp1  = <temp1>;
    temp2  = <temp2>;
    temp3  = <temp3>;
    temp4  = <temp4>;
    temp5  = <temp5>;
    temp6  = <temp6>;
    temp7  = <temp7>;
    temp8  = <temp8>;
    temp9  = <temp9>;
    <name> = <formula>;
</auxiliaries>

<auxiliaries vertLoc=SED; calcAfterProcesses=1>
    % <description>:
    temp1  = <temp1>;
    temp2  = <temp2>;
    temp3  = <temp3>;
    temp4  = <temp4>;
    temp5  = <temp5>;
    temp6  = <temp6>;
    temp7  = <temp7>;
    temp8  = <temp8>;
    temp9  = <temp9>;
    <name> = <formula>;
</auxiliaries>

<auxiliaries vertLoc=SUR; calcAfterProcesses=1>
    % <description> :
    temp1  = <temp1>;
    temp2  = <temp2>;
    temp3  = <temp3>;
    temp4  = <temp4>;
    temp5  = <temp5>;
    temp6  = <temp6>;
    temp7  = <temp7>;
    temp8  = <temp8>;
    temp9  = <temp9>;
    <name> = <formula>;
</auxiliaries>
              
%------------------------------------
% STEP 6.3: output of "late" auxiliaries
%------------------------------------
<auxiliaries vertLoc=WAT; calcAfterProcesses=1; isOutput=1>             
    output_scalar_<name> = output_scalar_<name> + <name>;
</auxiliaries>

<auxiliaries vertLoc=WAT; calcAfterProcesses=1; isUsedElsewhere=1>             
    auxiliary_scalar_<name> = <name>;
</auxiliaries>

<auxiliaries vertLoc=SED; calcAfterProcesses=1; isOutput=1>
    output_scalar_<name> = output_scalar_<name> + <name>;
</auxiliaries>

<auxiliaries vertLoc=WAT; calcAfterProcesses=1; isUsedElsewhere=1>             
    auxiliary_scalar_<name> = <name>;
</auxiliaries>

<auxiliaries vertLoc=SUR; calcAfterProcesses=1; isOutput=1>
    output_scalar_<name> = output_scalar_<name> + <name>;
</auxiliaries>

<auxiliaries vertLoc=SUR; calcAfterProcesses=1; isUsedElsewhere=1>             
    auxiliary_scalar_<name> = <name>;
</auxiliaries>
   
%---------------------------------------
% THE END of the biological timestep
%---------------------------------------