// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('[name="admin[approved]"]').on('change', function() {
    $(this).parent().parent().submit();
  });
});