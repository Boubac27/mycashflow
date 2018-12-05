import "bootstrap";

import { initMap } from '../components/map.js';
import { updateProgressBar } from '../components/progr.js';
import { initAutocomplete } from "../components/autocomplete.js"

window.initGoogleJs = function() {
  console.log(initAutocomplete);
  initAutocomplete();
  initMap();
}

updateProgressBar();
window.markers = [];

