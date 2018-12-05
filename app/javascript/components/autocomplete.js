const initAutocomplete = () => {

    var input = document.getElementById('pac-input');


    if (input == null) { return }

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

