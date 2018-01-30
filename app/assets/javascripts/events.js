// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var redirect;

redirect = function() {
  return window.location.replace('/');
};

String.prototype.capitalizeFirstLetter = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
};

$(document).ready(function() {
  $('form[data-remote]').on('ajax:send', function() {
    $(this).children('div').attr('class', 'field');
    $(this).children('div').children('div').remove();
    return $('input').attr('disabled', true);
  });
  $('form[data-remote]').on('ajax:success', function() {
    $(this).children('div').addClass('success');
    return setTimeout(redirect, 500);
  });
  return $('form[data-remote]').on('ajax:error', function(evt, xhr, status, error) {
    var errors, fieldSet, form, key, results;
    $('input').attr('disabled', false);
    errors = xhr.responseJSON.error;
    results = [];
    for (form in errors) {
      fieldSet = $(this).find("#event_" + form).parent();
      fieldSet.addClass('error');
      results.push((function() {
        var results1;
        results1 = [];
        for (key in errors[form]) {
          error = form.capitalizeFirstLetter().replace(/_/g, ' ') + ' ' + errors[form][key];
          results1.push(fieldSet.append("<div><small>" + error + "</small></div>"));
        }
        return results1;
      })());
    }
    return results;
  });
});
