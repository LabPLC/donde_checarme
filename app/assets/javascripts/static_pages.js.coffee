# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/





$ ->
  geocoder = L.mapbox.geocoder('examples.map-9ijuk24y')
  window.mapa =L.mapbox.map('map', 'examples.map-9ijuk24y')
  console.log "LALA"
  geocoder.query 'Zocalo, Mexico City', showMap

showMap = (err, data) ->
    window.mapa.fitBounds data.lbounds
    return

