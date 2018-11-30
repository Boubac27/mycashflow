import mapboxgl from 'mapbox-gl';

mapboxgl.accessToken = 'pk.eyJ1Ijoic3RlcG1pIiwiYSI6ImNqcDEwbjc1bTJqZXkzcXMzdmp6eXgyYjEifQ.04zRl-cA0VHPErxPv-Q9pw';
window.mapboxgl = mapboxgl;

const displayMap = () => {
  const map = document.querySelector('#map');

  if (map) {
    window.map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v9',
      center: [ 4.84977, 45.76931 ],
      zoom: 12
    });
  }
}

export { displayMap };
