console.log("wooo");

var API = "";
var API_ENDPOINT = "/hospitales.json";

var geocoder = L.mapbox.geocoder('juanjcsr.hinc76e0');
var mapa = L.mapbox.map('map', 'juanjcsr.hinc76e0');
var featureLayer = "";
var markers;
geocoder.query("Mexico City", showMap);



var centroscentros = "";
var markers = "";


function showMap(err, data) {
  mapa.fitBounds(data.lbounds);
}


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
  var prom = $.ajax({
    url: API + API_ENDPOINT,
    cache: false,
    dataType: 'json'
  })

  var success = function(resp) {
    console.log("RESPUESTA RESPUESTA");
    console.log(resp);
    centroscentros = resp;
    markers.on('click', function(e) {
      //TODO, arreglar a offest
      mapa.panTo(e.layer.getLatLng());
      console.log("clickclick");
    });
  }
  prom.then(function(resp) {
    console.log("then")
    console.log(resp)
    if (markers != ""){
      console.log("quitocosas")
      mapa.removeLayer(markers);


      //markers = mapa.markerLayer.setGeoJSON(resp);
      //
    }
    markers = L.mapbox.featureLayer(resp);
    markers.eachLayer(function(l) {
    var popupContent = "<div class='popup'>" +
                                       "<div class='popup-info'>" +
                                        "<div class='popup-location'>" +
                                          "<span class='location'>" + l.feature.properties.name + "</span>" +
                                          "<br>" +
                                          "<span class='address'>" +
                                            "<i class='fi-compass'/>" +
                                            "<a href='https://maps.google.com/maps?daddr=" + l.feature.geometry.coordinates[1] + "," + l.feature.geometry.coordinates[0]+"&z=17&' target='_blank'>" +
                                          l.feature.properties.address + "</a></span>" +
                                        "</div>" +
                                      "</div>" +
                                    '</div>'

    l.bindPopup(popupContent)
    })
    markers.addTo(mapa)
  });
  prom.done(success);
}


/***
//Get data
/****/

/***************
// UI
// jQuery para hacer cositas de UI
//*********/
$(document).ready(function() {
  getCentros();
  $('.vendor-heading').click(function() {
    toggleVendor($(this));
  });

  var lc = L.control.locate().addTo(mapa);
  if (navigator.geolocation) {
      mapa.locate();
    }

  mapa.on('locationfound', function (e) {
    var pointLngLat = [e.latlng.lng, e.latlng.lat];
    L.mapbox.featureLayer({
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: pointLngLat
      },
      properties: {
        'marker-size': 'large',
        'marker-color': '#0000ff',
        'marker-symbol': 'star-stroked',
        'title': '<div class=\'popup-message\'>You are here</div>'
      }
    }).addTo(mapa);
  });

  addDatos();

});


mapa.on('dragend', function(e) {
  console.log(e.distance);
  console.log(mapa.getBounds().getCenter().lat)
  console.log(mapa.getBounds().getCenter().lng)
  if (mapa.getZoom() == 14){
    getCentros(mapa.getBounds().getCenter().lat,mapa.getBounds().getCenter().lng)
    addDatosMustache(markers.getGeoJSON());
  } else {
    getCentros();
  }

});

mapa.featureLayer.on('layerremove', function(){
  console.log("buuu")
})
//mapa.featureLayer.on('layeradd', callbackevent);

function callbackevent(e){
  console.log('kakakakaka')
  var mrkr = e.layer,
    feature = mrkr.feature;

  var popupContent = "<div class='popup'>" +
                                     "<div class='popup-info'>" +
                                      "<div class='popup-location'>" +
                                        "<span class='location'>" + feature.properties.name + "</span>" +
                                        "<br>" +
                                        "<span class='address'>" +
                                          "<i class='fi-compass'/>" +
                                          "<a href='https://maps.google.com/maps?daddr=" + feature.geometry.coordinates[1] + "," + feature.geometry.coordinates[0]+"&z=17&' target='_blank'>" +
                                        feature.properties.address + "</a></span>" +
                                      "</div>" +
                                    "</div>" +
                                  '</div>'
  mrkr.bindPopup(popupContent, {
    closeButton: true,
    minWidth: 320
  });
  //mapa.featureLayer.off('layeradd',callbackevent)
}

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





