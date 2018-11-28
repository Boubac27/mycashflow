// TODO: Autocomplete the input with AJAX calls.
const input = document.querySelector('#search');
const results = document.querySelector('#results');

const drawResponseList = (data) => {
  results.innerHTML = '';
  data.words.forEach((word) => {
    results.insertAdjacentHTML('beforeend', `<li>${word}</li>`);
  });
};

const autocomplete = (e) => {
  fetch(`https://maps.googleapis.com/maps/api/geocode/json?address=1600+#{word}&key=AIzaSyAZuR-94uFzg2VuikctpXZHBOcFcuX0Wzo`,{

  })
    .then(response => response.json())
    .then((data) => { drawResponseList(data);
                        console.log(data["results"][0]["address_components"]);
    });
};

input.addEventListener('keyup', autocomplete);
console.log("hello!");


// const input = document.querySelector('#search');
// const results = document.querySelector('#results');

// const autocomplete = (e) => {
//   fetch(`https://maps.googleapis.com/maps/api/geocode/json?address=1600+lyon&key=AIzaSyAZuR-94uFzg2VuikctpXZHBOcFcuX0Wzo`)
// }
//     .then(response => response.json())
//     .then((data) => {
//       results.innerHTML = '';
//       data.words.forEach(function(word) => {
//         results.insertAdjacentHTML('beforeend', `<li>${word}</li>`);
//   });
// };

// input.addEventListener('keyup', autocomplete);
