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


infowindow = new google.maps.InfoWindow({
	maxWidth: 300
	})
window.markers = []
window.infowindows = []
window.current_points = []

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
	$.get '/hospitales.json', {}, callback, 'json'

set_marker_map = (map) ->
	#indow.center_marker.setMap(map)
	for marker in window.markers
		console.log("marcador")
		marker.setMap(map)

display_on_map = (data, map) ->
	#console.log(map)
	#console.log(data.centros[0])
	set_marker_map(null)
	for centro in data.centros
		create_marker(centro, map)
	set_marker_map(map)
	console.log "total marcadores " + window.markers.length
	create_cards()

create_marker = (point, map) ->

	content_string = '<div class="centro_info">' +
		'<div class="centro_encabezado">' +
			'<h3>' + point.nombre + '</h3>' +
		'</div>' +
		'<div class="centro_content"' +
			'<h4>Teléfonos:</h4>' + 
			'<p>' + point.telefono + '</p>' + 
			'<h4> Horario:</h4>'+
			'<p>'+ point.horario + '</p>' +
		'</div>' + '</div>'

	marker = new google.maps.Marker
		position: new google.maps.LatLng(point.latitude, point.longitude)
		animation: google.maps.Animation.DROP,
		map: map

	window.markers.push(marker)
	window.current_points.push(point)
	google.maps.event.addListener(marker, 'click', ->
		infowindow.setContent(content_string);
		infowindow.open(map, this)
		window.infowindows.push(infowindow)
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
	window.infowindows = []
	window.current_points = []

moviendo_mapa = ->
	centro_pos = window.map.getCenter()
	distancia_centro =  google.maps.geometry.spherical.computeDistanceBetween(centro_pos, window.center_marker.getPosition());
	console.log distancia_centro + "metros"
	console.log window.current_points
	#console.log window.markers
	create_cards()
	if distancia_centro > 3000
		delete_markers(window.map)
		window.center_marker.setMap(null)
		window.center_marker = null
		load_from_position(window.map, centro_pos.lat(), centro_pos.lng())	
		window.center_marker = new google.maps.Marker
			position: window.map.getCenter()
			map: window.map
			icon: {
				url: 'arrows.png'
			}

create_cards = ->
	$("#tarjetas div").remove()
	$("#tarjetas").append(card(point)) for point in window.current_points

card = (point) ->
	nombre_centro = "<h3 class='card_title'><a href='#'>"+ point.nombre + "</a></h3>"
	direccion_centro = "<p class='card_direccion'>" + point.direccion + "</p>"
	horario_centro = "<p class='card_horario'>" + point.horario + "</p>"
	telefonos_centro = "<p class='card_telefonos'>" + point.telefono + "</p>"
	hacer_cita = "<span class='card_cita'><a href='places/" + point.id + "'>Agenda una cita</a></span>" 
	div_card_centro = "<div class='card'>" + 
		nombre_centro +
		direccion_centro +
		horario_centro +
		telefonos_centro + 
		hacer_cita + "</div>"
	



