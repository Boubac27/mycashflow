const initAutocomplete = () => {
  const input = document.getElementById('pac-input');

  if (input == null) { return }

  const searchBox = new google.maps.places.SearchBox(input);
  searchBox.addListener('places_changed', function() {
    const places = searchBox.getPlaces();
    if (places.length == 0) {
      return;
    } else {
      places[0]["address_components"].forEach((component) => {
        if (component["types"][0] === 'locality') {
          const textarea_city = document.getElementById('city');
          textarea_city.innerText = component["long_name"];
        }
        if (component["types"][0] === 'postal_code') {
          const textarea_zipcode = document.getElementById('zipcode');
          textarea_zipcode.innerText = component["long_name"];
        }
      });
    }
  });

  document.getElementById('button').addEventListener('click', function(evt) {
    evt.preventDefault();

    const loader = document.getElementById('loader');
    loader.classList.add('visible');

    const textarea_city = document.getElementById('city').value;
    const textarea_zipcode = document.getElementById('zipcode').value;
    const budget = document.getElementById('budget').value;
    const token = document.getElementById('tok').value;
    let mhash = {};

    mhash["city"] = textarea_city;
    mhash["zipcode"] = textarea_zipcode;
    mhash["budget"] = budget;
    mhash["authenticity_token"] = token;

    document.querySelector('#results').innerHTML = '';

    fetch("/searches", { method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(mhash)
    }).then((response) => {
      return response.text();
    }).then((data) => {
      loader.classList.remove('visible');
      eval(data);
    });
  });
}

export { initAutocomplete };

