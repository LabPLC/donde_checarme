console.log("wooo");

var API = ""
var API_ENDPOINT = "/hospitales.json"

var geocoder = L.mapbox.geocoder('examples.map-9ijuk24y');
var mapa = L.mapbox.map('map', 'examples.map-9ijuk24y');
geocoder.query("Mexico City", showMap);



function showMap(err, data) {
  mapa.fitBounds(data.lbounds);
}


/***
//Get data
/****/
$.when(

);

/***************
// UI
// jQuery para hacer cositas de UI
//*********/
$(document).ready(function() {
  if (navigator.geolocation) {
      mapa.locate();
    }

  mapa.on('locationfound', function (e) {
    var pointLngLat = [e.latlng.lng, e.latlng.lat]
    mapa.featureLayer.setGeoJSON({
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
    });
  });
});

mapa.featureLayer.on('click', function(e) {
  mapa.panTo(e.layer.getLatLng());
});




