# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/





# $ ->
#   geocoder = L.mapbox.geocoder('examples.map-9ijuk24y')
#   window.mapa =L.mapbox.map('map', 'examples.map-9ijuk24y')
#   console.log "LALA"
#   geocoder.query 'Zocalo, Mexico City', showMap

#   window.mapa.on('locationfound',
#   (e) ->
#     platlon = [e.latlng.lat, e.latlng.lng]
#     plonlat = [e.latlng.lng, e.latlng.lat]
#     console.log "aaa"
#     mapa.featureLayer.setGeoJSON({
#       type: 'Feature',
#       geometry: {
#         type: 'Point',
#         coordinates: plonlat
#       },
#       properties: {
#         'marker-size': 'large',
#         'marker-color': '#cd0000',
#         'marker-symbol': 'star-stroked',
#         'title': '<div class=\'popup-message\'>You are here</div>'
#       }})
#   )
#   return

#   map_location = ->
#     if navigator.geolocation
#       window.mapa.locate
#     return


# showMap = (err, data) ->
#     window.mapa.fitBounds data.lbounds
#     return





