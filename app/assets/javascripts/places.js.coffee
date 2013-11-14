# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

unless navigator.geolocation then console.log("No geoloc")

success = (position) ->
	console.log "position disponible"
	latitude = position.coords.latitude
	longitude = position.coords.longitude
	#@map = gm_init(latitude, longitude)
	#load_points(@map
	
	center = new google.maps.LatLng(latitude,longitude)
	console.log(latitude, longitude)
	window.map.panTo(center)
	window.center_marker = new google.maps.Marker
		position: center
		map: window.map
		icon: {
			url: 'arrows.png'
		}
	delete_markers(window.map)
	load_from_position(window.map, latitude, longitude)

error = (err) ->
	console.log "no position disponible"
	


gm_init =  ->
	gm_center = new google.maps.LatLng(19.49, -99.2033)
	gm_map_type = google.maps.MapTypeId.ROADMAP
	map_options = { center: gm_center, zoom: 14, mapTypeId: gm_map_type }
	new google.maps.Map(@map_canvas, map_options)

#gm_center = (map, lat, lon) ->


infowindow = new google.maps.InfoWindow
window.markers = []

$ ->
	console.log "poss"
	window.map = gm_init()
	load_points(map)
	google.maps.event.addListener(map, 'dragend', moviendo_mapa)
	navigator.geolocation.getCurrentPosition(success,error)
	#

load_from_position = (map, lat, lon) ->
	callback = (data) -> display_on_map(data, map)
	$.get '/lugares', {latitude: lat, longitude: lon}, callback, 'json'


load_points = (map) ->
	callback = (data) -> display_on_map(data, map)
	$.get '/mapa.json', {}, callback, 'json'

set_marker_map = (map) ->
	for marker in window.markers
		console.log("marcador")
		marker.setMap(map)

display_on_map = (data, map) ->
	console.log(map)
	console.log(data.centros[0])
	for centro in data.centros
		create_marker(centro, map)
	set_marker_map(map)

create_marker = (point, map) ->

	content_string = '<div class="centro_info"' +
		'<div class="centro_encabezado">' +
			'<h1>' + point.nombre + '</h1>' +
		'</div>' +
		'<div class="centro_content"' +
			'<strong>Teléfono:</strong>' + 
			'<p>' + point.telefono + '</p>' + 
		'</div>'

	marker = new google.maps.Marker
		position: new google.maps.LatLng(point.latitude, point.longitude)
		animation: google.maps.Animation.DROP,
		map: map

	window.markers.push(marker)
	google.maps.event.addListener(marker, 'click', ->
		infowindow.setContent(content_string);
		infowindow.open(map, this)
		#if marker.getAnimation()?
		#	marker.setAnimation(null)
		#else
		#	marker.setAnimation(google.maps.Animation.BOUNCE)
			
	)


delete_markers = (map)->
	console.log("borrando")
	console.log (window.markers)
	set_marker_map(null)
	window.markers = []

moviendo_mapa = ->
	centro_pos = window.map.getCenter()
	console.log(centro_pos)
	delete_markers(window.map)
	load_from_position(window.map, centro_pos.lat(), centro_pos.lng())



