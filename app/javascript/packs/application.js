import { displayAnimation } from './animation';
import "bootstrap";
import mapboxgl from 'mapbox-gl';
import { displayMap } from './map';
import { updateProgressBar } from './progr';

displayMap();
displayAnimation();
updateProgressBar();
window.markers = [];
