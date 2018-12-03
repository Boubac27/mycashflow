import "bootstrap";
import mapboxgl from 'mapbox-gl';
import { displayMap } from './map';
import { updateProgressBar } from './progr';
import { soumettre } from './soum';
displayMap();
updateProgressBar();
window.markers = [];

