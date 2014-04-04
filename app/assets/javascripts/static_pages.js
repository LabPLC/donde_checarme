/**
*Rutinas de ubicación en el mapa, l
*
*/

///API ENDPOINT
var API = "";
var API_ENDPOINT = "/hospitales.json";


/***Funciones de eventos***/


/*Inicialización del mapa y del geocoder */
var geocoder = L.mapbox.geocoder('codigocdmx.hn10j8d4');
var mapa = L.mapbox.map('map', 'codigocdmx.hn10j8d4');
geocoder.query("Mexico City", showMap);

/**Global variables*/
var featureLayer = "";
var markers = "";
var centroscentros = "";
var centralmarker = "";

function onGetMapaSccess(resp) {
  console.log("RESPUESTA RESPUESTA");
  console.log(resp);
  centroscentros = resp;
  markers.on('click', function(e) {
    //TODO, arreglar a offest
    mapa.panTo(e.layer.getLatLng());
    console.log("clickclick");
  });
}

function onGetCentrosThen(resp) {
  console.log("then")
    console.log(resp)
    if (markers != ""){
      console.log("quitocosas")
      mapa.removeLayer(markers);
    }
    markers = L.mapbox.featureLayer(resp);
    markers.eachLayer(function(l) {
    var mustacheTemplate = $('#mustache-popup').html()
    var popupContent = Mustache.render(mustacheTemplate,l)
    l.bindPopup(popupContent)
    })
    markers.addTo(mapa)
}


function showMap(err, data) {
  mapa.fitBounds(data.lbounds);
}

/***
//Get data
/****/

function getCentros(lat, lng, busqueda) {
  lat =  typeof lat !== 'undefined' ? lat : 0;
  lng =  typeof lng !== 'undefined' ? lng : 0;
  busqueda = typeof busqueda !== 'undefined' ? busqueda : 0;
  var centrossalud = "a"
  mapa
  if (lat != 0 && lng != 0) {
    API_ENDPOINT = "/lugares.json?latitude="+lat+"&longitude="+lng
  } else {
    API_ENDPOINT = "/hospitales.json"
  }
  console.log(API_ENDPOINT);

  var prom = $.ajax({
    url: API + API_ENDPOINT,
    cache: false,
    dataType: 'json'
  })
  prom.then(onGetCentrosThen);
  prom.done(onGetMapaSccess);
}




/***************
// UI
// jQuery para hacer cositas de UI
//*********/
$(document).ready(function() {
  getCentros();
  submit_ajax_form();


  $('.vendor-heading').click(function() {
    toggleVendor($(this));
  });

  var lc = L.control.locate().addTo(mapa);
  if (navigator.geolocation) {
      mapa.locate();
  }

  mapa.on('locationfound', onMapLocationFound);

  addDatos();

});

function onMapLocationFound(e){
  if (centralmarker != "") {
    mapa.removeLayer(centralmarker)
  }
  var pointLngLat = [e.latlng.lng, e.latlng.lat];
  centralmarker = L.marker(new L.LatLng(e.latlng.lat,e.latlng.lng), {
    icon: L.mapbox.marker.icon({'marker-color': 'CC0033'}),
    draggable:true
  });
  centralmarker.on('dragend', function(e){
    getCentros(centralmarker.getLatLng().lat, centralmarker.getLatLng().lng)
    showDataAtZoom(markers.getGeoJSON());
  })

  centralmarker.addTo(mapa);

}

function submit_ajax_form() {
  $('#preguntas').bind('ajax:success', function(e,data,status,xhr) {
    console.log(xhr.responseJSON)
    if (markers != ""){
      console.log("quitocosas")
      mapa.removeLayer(markers);
    }
    markers = L.mapbox.featureLayer(xhr.responseJSON);
    markers.eachLayer(function(l) {
      var mustacheTemplate = $('#mustache-popup').html()
      console.log(l.feature)
      var popupContent = Mustache.render(mustacheTemplate,l)
      l.bindPopup(popupContent)
    })
    markers.addTo(mapa)
    mapa.fitBounds(markers.getBounds())
  }).bind("ajax:error", function(e,xhr, status, error) {
    console.log(error)
  });
}



mapa.on('dragend', function(e) {
  console.log(e.distance);
  console.log(mapa.getBounds().getCenter().lat)
  console.log(mapa.getBounds().getCenter().lng)
  console.log(mapa.getZoom())
  if (mapa.getZoom() >= 13){
    getCentros(mapa.getBounds().getCenter().lat,mapa.getBounds().getCenter().lng)
    console.log("datatozoom")
    console.log(markers.getGeoJSON())
    showDataAtZoom(markers.getGeoJSON());
  } else {
    console.log(markers)
    if (markers.getGeoJSON().features.length < 240) {
      getCentros();
    }

  }

});

mapa.featureLayer.on('layerremove', function(){
  console.log("buuu")
})
//mapa.featureLayer.on('layeradd', callbackevent);


function toggleVendor(clicked) {
  if (clicked.next('.vendor-entries').is(':visible')) {
    clicked.removeClass('active')
    $('.vendor-entries').slideUp(200)
  }
  else {
    if ($('.vendor-entries').is(':visible')) {
      $('.vendor-entries').prev('.vendor-heading').removeClass('active')
      $('.vendor-entries').slideUp(200)
    }
    clicked.next('.vendor-entries').slideDown(200)
    clicked.addClass('active')
  }
}

function addDatos(){
  var $panelNow = $('#vendor-info-now .vendor-entry-list')
  $('#vendor-info-now h3').html('Cargando...')
}

function showDataAtZoom(data){
  console.log("mustachestuff")
  console.log(data);
  var mustacheTemplate = $('#mustache-entry').html()
  var $panelCerca = $('#vendor-info-now .vendor-entry-list')
  $panelCerca.html(Mustache.render(mustacheTemplate,data));
}




