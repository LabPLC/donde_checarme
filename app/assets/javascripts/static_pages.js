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
  //console.log("hooo")
  //var markers = mapa.markerLayer.setGeoJSON(centros);
  markers = mapa.featureLayer.setGeoJSON(centros);
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
});


mapa.on('dragend', function(e) {
  console.log(e.distance);
  console.log(mapa.getBounds().getCenter())
});





