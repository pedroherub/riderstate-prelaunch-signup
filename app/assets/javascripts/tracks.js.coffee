# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#function updateHourTimeSelect(){
#  $i = 24; 
#  while($i < 100){
#     $('#track_duration_4i').append('<option value="' + $i + '">' + $i + '</option>');
#     $i++;
#   }
#}

$('#departing').datepicker()
$('#duration').timepicker()
