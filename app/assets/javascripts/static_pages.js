console.log("wooo");

(function () {
    var temp = jQuery.event.handle;
    jQuery.event.dispatch = function () {
       try {
          temp.apply(this, arguments);
       } catch (e) {
          console.log('Error while dispatching the event.');
       }
    }
}());

var API = ""
var API_ENDPOINT = "/hospitales.json"

var geocoder = L.mapbox.geocoder('juanjcsr.hinc76e0');
var mapa = L.mapbox.map('map', 'juanjcsr.hinc76e0');
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
      centroscentros = $.parseJSON(response)
      console.log(centroscentros);
      //mapa.featureLayer.setGeoJSON(centroscentros);
    }
  })
).then( function(){
  var centros = centroscentros
  //console.log("hooo")
  //var markers = mapa.markerLayer.setGeoJSON(centros);
  markers = L.mapbox.featureLayer(centros).addTo(mapa)
});

/***************
// UI
// jQuery para hacer cositas de UI
//*********/
$(document).ready(function() {
  if (navigator.geolocation) {
      //mapa.locate();
    }

  mapa.on('locationfound', function (e) {
    var pointLngLat = [e.latlng.lng, e.latlng.lat]
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

mapa.featureLayer.on('click', function(e) {
  mapa.panTo(e.layer.getLatLng());
});




