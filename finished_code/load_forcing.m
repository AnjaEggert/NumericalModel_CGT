function [ final_vector, i_to_load ] = load_forcing( input_matrix, orig_date, start_date, end_date, old_i_to_load )
  % if the same forcing is repeated several times, find the correct date
  % within the forcing period
  date=orig_date;
  while date >= end_date
      date = date - (end_date-start_date);
  end
  % seek the index to load
  % check if current index is still valid
  i=old_i_to_load;
  newdate1=datenum(input_matrix(i,1),input_matrix(i,2),input_matrix(i,3))+input_matrix(i,4)/24.0;
  if i<size(input_matrix,1)
    newdate2=datenum(input_matrix(i+1,1),input_matrix(i+1,2),input_matrix(i+1,3))+input_matrix(i+1,4)/24.0;
  else
    newdate2=date;
  end
  if (newdate1<date) && (newdate2>=date)
      %everything is fine, the current vector is good
      i_to_load=i;
  else
      if (newdate1 > date) %some time loop has finished and the date moved backwards behind the loaded date
          i=1;
      end
      while (i<size(input_matrix,1))
          newdate2=datenum(input_matrix(i+1,1),input_matrix(i+1,2),input_matrix(i+1,3))+input_matrix(i+1,4)/24.0;
          if newdate2<date
              i=i+1;
          else
              i_to_load=i;
              i=size(input_matrix,1)+1000;
          end
      end
      if i<=size(input_matrix,1)+1 %found no good i in the middle => use the last one
          i_to_load=size(input_matrix,1);
      end
  end
  % load the forcing
  final_vector=input_matrix(i_to_load,5:min(4+1,size(input_matrix,2)));    
end

