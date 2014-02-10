# Script para controlar el comportamiento de los mapas
# y la ubicación de los puntos.  

unless navigator.geolocation then console.log("No geoloc")

## Init de variables "globales" para los mapas
# TODO: ¿Es posible NO utilizar el objeto window
# 		para salir del closure en Coffeescript y poder
#		implementar Google Maps de forma más limpia?
######
infowindow = new google.maps.InfoWindow({
	maxWidth: 300
	})
window.markers = []
window.infowindows = []
window.current_points = []
######

#jQuery document.ready
#
$ ->
	console.log "poss"
	window.map = gm_init()
	load_all_points(map)
	google.maps.event.addListener(map, 'dragend', moviendo_mapa)
	navigator.geolocation.getCurrentPosition(loc_success, loc_error)
	submit_ajax_form()
	get_current_location()

#  Google Maps init script.
# Mapa localizado en el Zócalo de la Ciudad de México
gm_init =  ->
	gm_center = new google.maps.LatLng(19.49, -99.2033)
	gm_map_type = google.maps.MapTypeId.ROADMAP
	map_options = { center: gm_center, zoom: 14, mapTypeId: gm_map_type }
	new google.maps.Map(@map_canvas, map_options)

#### Browser Geolocation methods
loc_success = (position) ->
	console.log "position disponible"
	latitude = position.coords.latitude
	longitude = position.coords.longitude
	
	center = new google.maps.LatLng(latitude,longitude)
	console.log(latitude, longitude)
	window.map.panTo(center)
	window.center_marker = new google.maps.Marker
		position: center
		map: window.map
		icon: {
			url: 'arrows.png'
		}
	# Clean map
	clean_map(window.map)
	load_from_position(window.map, latitude, longitude)


loc_error = (err) ->
	console.log "no position disponible"

#### /Browser Geolocation Methods

# '/hospitales' es un endpoint que trae todos los puntos
# en caso de que no se obtenga una posición mediante el browser
load_all_points = (map) ->
	callback = (data) -> display_on_map(data, map)
	$.get '/hospitales.json', {}, callback, 'json'
	
# Obtiene puntos para desplegar en el mapa a partir
# de un endpoint. en éste caso '/lugares', sin embargo, éste 
# puede cambiar dependiendo las necesidades del end-user.
load_from_position = (map, lat, lon) ->
	callback_to_map = (data) -> display_on_map(data, map)
	$.get '/lugares', {latitude: lat, longitude: lon}, callback_to_map, 'json'

# A partir de un JSON con array de objetos, genera un nuevo
# marker y adjuntar la referencia de window.map
display_on_map = (data, map) ->
	set_marker_map(null)
	for centro in data.centros
		create_marker(centro, map)
	set_marker_map(map)
	console.log "total marcadores " + window.markers.length
	create_cards()

set_marker_map = (map) ->
	for marker in window.markers
		console.log("marcador")
		marker.setMap(map)

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


moviendo_mapa = ->
	centro_pos = window.map.getCenter()
	distancia_centro =  google.maps.geometry.spherical.computeDistanceBetween(centro_pos, window.center_marker.getPosition());
	console.log distancia_centro + "metros"
	console.log window.current_points
	#console.log window.markers
	create_cards()
	if distancia_centro > 3000
		clean_map(window.map)
		window.center_marker.setMap(null)
		window.center_marker = null
		load_from_position(window.map, centro_pos.lat(), centro_pos.lng())	
		window.center_marker = new google.maps.Marker
			position: window.map.getCenter()
			map: window.map
			icon: {
				url: 'arrows.png'
			}

clean_map = (map)->
	console.log("borrando")
	console.log (window.markers)
	set_marker_map(null)
	window.markers = []
	window.infowindows = []
	window.current_points = []



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


submit_ajax_form = ->
	$("#forma_busqueda").bind('ajax:success', (evt, data, status, xhr) ->
		clean_map(window.map)
		display_on_map(data, map)
	)

get_current_location = ->
	mostrar_todos = ->
		console.log "wooo"
		navigator.geolocation.getCurrentPosition(success,error)
	$("#boton_todos").click(mostrar_todos)
	



