console.log("wooo");

var API = "";
var API_ENDPOINT = "/hospitales.json";

var geocoder = L.mapbox.geocoder('juanjcsr.hinc76e0');
var mapa = L.mapbox.map('map', 'juanjcsr.hinc76e0');
var featureLayer = "";
geocoder.query("Mexico City", showMap);



var centroscentros = "";
var markers = "";


function showMap(err, data) {
  mapa.fitBounds(data.lbounds);
}


/***
//Get data
/****/
$.when(
  markerLayer = $.ajax({
    url: API + API_ENDPOINT,
    cache: false,
    dataType: 'text',
    success: function (response) {
      centroscentros = $.parseJSON(response);
      console.log(centroscentros);
      //mapa.featureLayer.setGeoJSON(centroscentros);
    }
  })
).then( function(){
  var centros = centroscentros;
  console.log("hooo")
  //var markers = mapa.markerLayer.setGeoJSON(centros);



}). done(function() {
  console.log(centroscentros);
  console.log("wola")
  markers = mapa.featureLayer.setGeoJSON(centroscentros);
  console.log("wolo")
  //markers = L.mapbox.featureLayer(centros).addTo(mapa)

  markers.on('click', function(e) {
    //TODO, arreglar a offest
    mapa.panTo(e.layer.getLatLng());
    console.log("clickclick");
  });

});

/***************
// UI
// jQuery para hacer cositas de UI
//*********/
$(document).ready(function() {

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
        'marker-color': '#cd0000',
        'marker-symbol': 'star-stroked',
        'title': '<div class=\'popup-message\'>You are here</div>'
      }
    }).addTo(mapa);
  });

  addDatos();
});


mapa.on('dragend', function(e) {
  console.log(e.distance);
  console.log(mapa.getBounds().getCenter())
});

mapa.featureLayer.on('layeradd', function(e){
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
  });

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
  $('#vendor-info-now h3').html('There are no trucks open right now.')
}





