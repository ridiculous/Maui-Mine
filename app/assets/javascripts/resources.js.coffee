# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  return unless $('#tag_data').length
  $("#tags_field").select2
    tags: $('#tag_data').val().split(',')

  $('#resource_location_region_id').select2 {}

  $('#resource_use_coordinates').on 'click', ->
    $coords = $('.coordinates');
    $coords.toggle().find('.control-group').slideToggle(200);
    navigator.geolocation.getCurrentPosition (data) ->
      $('#resource_location_latitude').val(data.coords.latitude);
      $('#resource_location_longitude').val(data.coords.longitude);

  $('#add_location').on 'click', ->
    $('.toggle-resource-location').toggle();