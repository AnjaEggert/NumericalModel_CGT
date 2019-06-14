%cd '/silor/eggert/bioacid_fucus_model/fucus_boxmodel/finished_code'
clear all


%----------------------------------------------
% MATLAB 0-d fucus boxmodel
% hagen.radtke@io-warnemuende.de
%----------------------------------------------
global time_axis
global cellheight

disp('   initialization');

%load timestep, initial date etc.
configure;

%initialize the date
current_date        =start_date;
current_output_date =start_date;
current_output_index=1; % time index in output matrix
max_output_index    =floor(repeated_runs*(end_date-start_date)/output_interval);
time_axis           =zeros(1,max_output_index);
for i=1:max_output_index
    time_axis(i)=(i-1)*output_interval+start_date;
end

disp('   loading physical and biochemical forcing');

%load depth of box = cell height
cellheight = load('physics/cellheights.txt'); % cell height of box = depth [m]

%load physical forcing
forcing_temperature   = load('physics/temperature.txt');    % temperature [deg_C]
forcing_light         = load('physics/light.txt');          % downward flux of shortwave radiation at box surface [W/m2]

forcing_index_temperature   = 1;
forcing_index_light         = 1;

disp('   loading biological initialization values');

%load constants and time-dependent biochemical forcing
cgt_init_constants;

%load initial tracer concentrations
cgt_init_tracers;

% fill the output with zeros or NaNs
cgt_init_output;

output_scalar_temperature = 0.0;
output_scalar_light       = 0.0;

output_temperature        = zeros(1, max_output_index)/0.0;
output_light              = zeros(1, max_output_index)/0.0;

output_count              = 0;

disp('   starting the run');

% do the timestep
while current_date < repeated_runs*(end_date-start_date)+start_date
    % load the physical forcing
    [forcing_scalar_temperature  , forcing_index_temperature]   = load_forcing(forcing_temperature  , current_date, start_date, end_date, forcing_index_temperature);
    [forcing_scalar_light        , forcing_index_light]         = load_forcing(forcing_light        , current_date, start_date, end_date, forcing_index_light);
    
    % output of physical forcing during this time step
    output_scalar_temperature = output_scalar_temperature + forcing_scalar_temperature;
    output_scalar_light       = output_scalar_light       + forcing_scalar_light;
        
    output_count=output_count+1;

    % update the values of time-dependent constants
    % load biochemical forcing and give output during this time step
    cgt_update_constants;
  
    % do the biology
    cgt_bio_timestep;
          
    % check if output needs to be saved in final array
    if current_date*(1.0+1.0e-10) >= current_output_date + output_interval
        % display current date/time
        disp(datestr(current_date));
        
        % do the output of physical forcing
        output_temperature(current_output_index) = output_scalar_temperature /output_count;
        output_light(current_output_index)       = output_scalar_light       /output_count;
        
        % reset temporary physical forcing output values
        output_scalar_temperature = 0.0;
        output_scalar_light       = 0.0;
        
        %do the output of biology
        cgt_output_final;
        
        %reset output indexes
        output_count  = 0;
        current_output_index = current_output_index + 1;
        current_output_date=current_output_date+output_interval;
    end
    
    % update the current date/time
    current_date = current_date + timestep;
end
