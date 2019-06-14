<constants dependsOn=zt>
  [forcing_scalar_<name>, forcing_index_<name>] = load_forcing(forcing_<name>,current_date,start_date,end_date,forcing_index_<name>);
  output_scalar_<name> = output_scalar_<name> + forcing_scalar_<name>;
</constants>