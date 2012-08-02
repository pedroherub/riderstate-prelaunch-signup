// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require rails.validations
//= require rails.validations.simple_form
//= require autocomplete-rails
//= require jquery.tabSlideOut.v1.3.js
//= require jquery.multiFieldExtender-2.0.min.js
//= require_tree .

// display validation errors for the "request invitation" form
$('document').ready(function() {

  $i = 24;
  while($i < 100){
     $('#track_duration_4i').append('<option value="' + $i + '">' + $i + '</option>');
     $i++;
   }

  $("#itemUsersForClub").EnableMultiField();

#// For fixed width containers
jQuery ->
  $('.datatable').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "aaSorting": [[ 2, "desc" ]],
    "bRetrieve":true
    });
//$('#departing').datepicker({
//    dateFormat: "yy-mm-dd"
//  })
//$('#duration').timepicker()

//  $('.slide-out-div').tabSlideOut({
//    tabHandle: '.handle', //class of the element that will become your tab
//    pathToTabImage: '/images/contact_tab.jpg',//path to the image for the tab
//    //Optionally can be set using css
//    imageHeight: '122px', //height of tab image
//    //Optionally can be set using css
//    imageWidth: '40px', //width of tab image
//    //Optionally can be set using css
//    tabLocation: 'left', //side of screen where tab lives, top, right, bottom, or left
//    speed: 300, //speed of animation
//    action: 'hover', //options: 'click' or 'hover', action to trigger animation
//    topPos: '200px', //position from the top/ use if tabLocation is left or right
//    leftPos: '20px', //position from left/ use if tabLocation is bottom or top
//    fixedPosition: true //options: true makes it stick(fixed position) on scroll
//  });

  // use AJAX to submit the "request invitation" form
  $('#invitation_button').live('click', function() {
    var email = $('form #user_email').val();
    var password = $('form #user_password').val();
    var betatester = $('form #user_betatester').is(':checked') ? true : false;
    //var betatester = $('form #user_betatester').val();
    var dataString = 'user[email]='+ email + '&user[password]=' + password + '&user[betatester]=' + betatester;
    $.ajax({
      type: "POST",
      url: "/users",
      data: dataString,
      success: function(data) {
        $('#request-invite').html(data);
      }
    });
    return false;
  });

  // use AJAX to update the user as a betatester 
  $('#betatester_button').live('click', function() {
    var action = $("#betatester_email").attr("action");
    //console.log(action);
    $.ajax({
      type: "POST",
      url: action,
      success: function(data) {
        $('#request-invite').html(data);
      }
    });
    return false;
  });

})
