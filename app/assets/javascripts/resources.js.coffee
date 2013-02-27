# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  return unless $('#tag_data').length

  $("#tags_field").select2
    tags: $('#tag_data').val().split(',')        # make select box

  $('#resource_location_region_id').select2 {}   # make select box

  $lat = $('#resource_location_latitude')
  $lng = $('#resource_location_longitude')
  $coords = $('.coordinates');
  $add_location = $('#resource_add_location');
  $location_box = $('.toggle-resource-location');
  $add_coords = $('#resource_add_coordinates');

  showCoords = () ->
    $coords.toggle().find('.control-group').toggle();
    $lat.val(maui.coords.latitude) unless $lat.val()
    $lng.val(maui.coords.longitude) unless $lng.val()

  if $add_location.attr('checked')
    $location_box.show();

  if $add_coords.attr('checked')
    showCoords {}

  $add_coords.on 'click', ->
    showCoords {}

  $add_location.on 'click', ->
    $location_box.toggle();