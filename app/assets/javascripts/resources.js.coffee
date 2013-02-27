# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  return unless $('#tag_data').length

  $("#tags_field").select2
    tags: $('#tag_data').val().split(',')
  # make select box

  $('#resource_location_region_id').select2 {}
  # make select box

  $lat = $('#resource_location_latitude')
  $lng = $('#resource_location_longitude')
  $coords = $('.coordinates');
  $add_location = $('#resource_add_location');
  $location_box = $('.toggle-resource-location');
  $add_coords = $('#resource_add_coordinates');
  $coord_control = $('#coords_control')

  showCoords = () ->
    $coords.toggle()
    $lat.val(maui.coords.latitude) unless $lat.val()
    $lng.val(maui.coords.longitude) unless $lng.val()

  if $add_location.attr('checked')
    $location_box.show()
    $coord_control.show()

  if $add_coords.attr('checked')
    showCoords()

  loc_opts =
    style:
      enabled: 'success'
      disabled: 'danger'
    label:
      enabled: '+ location'
      disabled: '- location'
    onChange: () ->
      $location_box.toggle()
      $coord_control.toggle()

  coord_opts =
    width: 165
    height: 30
    style:
      enabled: 'info'
      disabled: 'warning'
    label:
      enabled: '+ coords'
      disabled: '- coords'
    onChange: () ->
      showCoords {}

  doToggleButtons(loc_opts, '#add_loc')
  doToggleButtons(coord_opts, '#add_coords')

