import "bootstrap";
import mapboxgl from 'mapbox-gl';
import { initMap } from './map';
import { updateProgressBar } from './progr';
import { initAutocomplete } from "../autocomplete.js"

window.initGoogleJs = function() {
  console.log(initAutocomplete);
  initAutocomplete();
  initMap();
}

updateProgressBar();
window.markers = [];

