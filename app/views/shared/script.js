console.log("hello!");
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
  fetch(`https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1600+lyon&key=AIzaSyAZuR-94uFzg2VuikctpXZHBOcFcuX0Wzo`,{

  })
    .then(response => response.json())
    .then((data) => {
                        console.log(data["predictions"]);
    });
};

input.addEventListener('keyup', autocomplete);


{
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    }
