# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  return unless $('#tag_data').length
  $lat = $('#resource_location_latitude')
  $lng = $('#resource_location_longitude')

  showCoords = () ->
    $coords = $('.coordinates');
    $coords.toggle().find('.control-group').slideToggle(200);

  if $('#resource_add_location').attr('checked')
    $('.toggle-resource-location').show();

  if $('#resource_add_coordinates').attr('checked')
    showCoords {}

  navigator.geolocation.getCurrentPosition (data) ->
    $lat.val(data.coords.latitude) unless $lat.val()
    $lng.val(data.coords.longitude) unless $lng.val()

  $("#tags_field").select2
    tags: $('#tag_data').val().split(',')

  $('#resource_location_region_id').select2 {}

  $('#resource_add_coordinates').on 'click', ->
    showCoords {}

  $('#resource_add_location').on 'click', ->
    $('.toggle-resource-location').toggle();