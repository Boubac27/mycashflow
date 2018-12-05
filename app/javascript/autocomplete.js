const initAutocomplete = () => {

    console.log("je suis la");
    console.log(document.getElementById('map2'));

    if (document.getElementById('map2') == null) { return }

    var map = new google.maps.Map(document.getElementById('map2'), {
      center: {lat: -33.8688, lng: 151.2195},
      zoom: 13,
      mapTypeId: 'roadmap'
    });
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
      searchBox.setBounds(map.getBounds());
    });

    var markers = [];

    var input = document.getElementById('pac-input');
    var searchBox = new google.maps.places.SearchBox(input);
    searchBox.addListener('places_changed', function() {
      var places = searchBox.getPlaces();
      if (places.length == 0) {
        return;
      }
      else {
        places[0]["address_components"].forEach((component) => {
          console.log(component["types"][0]);
          if (component["types"][0] === 'locality') {
            textarea_city = document.getElementById('city');
            textarea_city.innerText = component["long_name"];
          }
          if (component["types"][0] === 'postal_code') {
            textarea_zipcode = document.getElementById('zipcode');
            textarea_zipcode.innerText = component["long_name"];
          }
        });
      }

      markers.forEach(function(marker) {
        marker.setMap(null);
      });
      markers = [];

      var bounds = new google.maps.LatLngBounds();

      places.forEach(function(place) {
        if (!place.geometry) {
          console.log("Returned place contains no geometry");
          return;
        }
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };

        // Create a marker for each place.
        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

        if (place.geometry.viewport) {
        // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }
      });
      map.fitBounds(bounds);
    });
    document.getElementById('button').addEventListener('click', function(evt) {
      evt.preventDefault();
      console.log("bouton clique");
      const loader = document.getElementById('loader');
      loader.classList.remove('loader')

      const textarea_city = document.getElementById('city').value;
      const textarea_zipcode = document.getElementById('zipcode').value;
      const budget = document.getElementById('budget').value;
      const token = document.getElementById('tok').value;
      let mhash = {};
      console.log(textarea_city);
      console.log(textarea_zipcode);
      console.log(budget);
      mhash["city"] = textarea_city;
      mhash["zipcode"] = textarea_zipcode;
      mhash["budget"] = budget;
      mhash["authenticity_token"] = token;
      console.log(mhash);

      fetch("/searches", { method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(mhash)
      }).then((response) => {
        return response.text();
      }).then((data) => {
        //console.log(data);
        loader.classList.add('loader')
        eval(data);
      });
    });
  }

export { initAutocomplete };

