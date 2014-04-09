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
    mapa.panToOffset(e.layer.getLatLng(),_getCenterOffset());
    console.log("clickclick");
  });
  showDataAtZoom(centroscentros);
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
      console.log()
      l.setIcon(L.icon(l.feature.properties.icon))
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


  $('.lugares-encabezado').click(function() {
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
    icon: L.mapbox.marker.icon({'marker-color': '0043C9'}),
    draggable:true
  });
  centralmarker.on('dragend', function(e){
    getCentros(centralmarker.getLatLng().lat, centralmarker.getLatLng().lng)
    showDataAtZoom(markers.getGeoJSON());
  })

  centralmarker.addTo(mapa);
}

L.Map.prototype.panToOffset = function (latlng, offset, options) {
    var x = this.latLngToContainerPoint(latlng).x - offset[0]
    var y = this.latLngToContainerPoint(latlng).y - offset[1]
    var point = this.containerPointToLatLng([x, y])
    return this.setView(point, this._zoom, { pan: options })
  }
  function _getCenterOffset () {
    var offset = [0, 0]
    var $overlay = $('#info-lugares')
    if ($overlay.is(':visible')) {
      var viewableWidth = $(window).width() - $overlay.width() - $overlay.offset().left
      offset[0] =  ($overlay.width() + $overlay.offset().left) / 2
      if (viewableWidth > 840) {
        // Tweak to balance super wide windows.
        offset[0] = offset[0] - 60
      }
    }
    if ($(window).width() < 530) {
      offset[1] = $(window).height() / 4
    } else {
      offset[1] = $(window).height() / 10
    }

    return offset

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
  if (mapa.getZoom() >= 13){
    getCentros(mapa.getBounds().getCenter().lat,mapa.getBounds().getCenter().lng)
    showDataAtZoom(markers.getGeoJSON());

  } else {
    if (markers.getGeoJSON().features.length < 240) {
      getCentros();
    }

  }

});


function toggleVendor(clicked) {
  if (clicked.next('.lugares-entrada').is(':visible')) {
    clicked.removeClass('active')
    $('.lugares-entrada').slideUp(200)
  }
  else {
    if ($('.lugares-entrada').is(':visible')) {
      $('.lugares-entrada').prev('.lugares-encabezado').removeClass('active')
      $('.lugares-entrada').slideUp(200)
    }
    clicked.next('.lugares-entrada').slideDown(200)
    clicked.addClass('active')
  }
}

function addDatos(){
  var $panelNow = $('#lugares-pregunta .place-entry-list')
  $('#lugares-pregunta h3').html('Cargando...')
}

function showDataAtZoom(data){
  var mustacheTemplate = $('#mustache-entry').html()
  var $panelCerca = $('#lugares-pregunta .place-entry-list')
  $panelCerca.html(Mustache.render(mustacheTemplate,data));
  $('.place-entry').click(function(ex){
        openPopUpOnClick(this.getAttribute("data-location-id"))
      })
}

function openPopUpOnClick(id) {
  markers.eachLayer(function(marker) {
    console.log(marker)
    if (marker.feature.properties.id == id ) {
      console.log(id)
      marker.openPopup();
      mapa.panToOffset(marker.getLatLng(),_getCenterOffset)
    }
  })
}




